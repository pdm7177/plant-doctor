import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../l10n/locale_provider.dart';
import '../models/plant_analysis.dart';
import '../services/notification_service.dart';
import '../services/storage_service.dart';
import 'chat_screen.dart';

class ResultScreen extends StatefulWidget {
  final PlantAnalysis analysis;
  const ResultScreen({super.key, required this.analysis});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _storage = StorageService();
  PlantAnalysis? _previousAnalysis;
  bool _reminderActive = false;

  @override
  void initState() {
    super.initState();
    _loadExtra();
  }

  Future<void> _loadExtra() async {
    final all = await _storage.loadAnalyses();
    final normalized = widget.analysis.plantName.toLowerCase().trim();
    final previous = all.where((a) {
      return a.id != widget.analysis.id &&
          a.plantName.toLowerCase().trim() == normalized;
    }).toList();

    final reminders = await _storage.loadReminders();
    final hasReminder = reminders.any(
        (r) => r['analysisId'] == widget.analysis.id);

    if (mounted) {
      setState(() {
        _previousAnalysis = previous.isNotEmpty ? previous.first : null;
        _reminderActive = hasReminder;
      });
    }
  }

  Future<void> _toggleReminder() async {
    if (!mounted) return;
    final s = context.read<LocaleProvider>().strings;
    final notif = NotificationService.instance;
    final intervalDays = widget.analysis.wateringIntervalDays ?? 7;
    final notifId = notif.notificationIdFromAnalysisId(widget.analysis.id);

    if (_reminderActive) {
      await notif.cancelNotification(notifId);
      await _storage.deleteReminder(widget.analysis.id);
      if (!mounted) return;
      setState(() => _reminderActive = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.reminderDisabled)),
      );
    } else {
      final granted = await notif.requestPermission();
      if (!mounted) return;
      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification permission denied')),
        );
        return;
      }
      await notif.scheduleWateringReminder(
        id: notifId,
        plantName: widget.analysis.plantName,
        intervalDays: intervalDays,
        reminderDesc: s.wateringReminderDesc,
      );
      await _storage.saveReminder({
        'analysisId': widget.analysis.id,
        'plantName': widget.analysis.plantName,
        'intervalDays': intervalDays,
        'nextDate': DateTime.now()
            .add(Duration(days: intervalDays))
            .toIso8601String(),
      });
      if (!mounted) return;
      setState(() => _reminderActive = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${s.wateringEvery} $intervalDays ${s.wateringDays}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<LocaleProvider>().strings;
    final theme = Theme.of(context);
    final isHealthy = widget.analysis.isHealthy;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.file(
                File(widget.analysis.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (_, e, s2) => Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.broken_image, size: 60),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.analysis.plantName,
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('d MMMM yyyy, HH:mm').format(widget.analysis.date),
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  _StatusBadge(isHealthy: isHealthy, s: s),
                  const SizedBox(height: 16),
                  Text(widget.analysis.healthDescription,
                      style: theme.textTheme.bodyLarge),

                  // Toxicity warning
                  if (widget.analysis.isToxic == true) ...[
                    const SizedBox(height: 16),
                    _ToxicityWarning(
                      toxicTo: widget.analysis.toxicTo ?? [],
                      details: widget.analysis.toxicityDetails ?? '',
                      s: s,
                    ),
                  ],

                  // Progress comparison
                  if (_previousAnalysis != null) ...[
                    const SizedBox(height: 16),
                    _ProgressCard(
                      current: widget.analysis,
                      previous: _previousAnalysis!,
                      s: s,
                    ),
                  ],

                  if (widget.analysis.problems.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _Section(
                      icon: Icons.warning_amber_rounded,
                      title: s.problems,
                      color: Colors.orange[700]!,
                      items: widget.analysis.problems,
                    ),
                  ],
                  if (widget.analysis.recommendations.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _Section(
                      icon: Icons.lightbulb_outlined,
                      title: s.careRecommendations,
                      color: Colors.green[700]!,
                      items: widget.analysis.recommendations,
                    ),
                  ],
                  if (widget.analysis.careTips.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _Section(
                      icon: Icons.eco_outlined,
                      title: s.usefulTips,
                      color: Colors.teal[700]!,
                      items: widget.analysis.careTips,
                    ),
                  ],

                  // Watering reminder button
                  if (widget.analysis.wateringIntervalDays != null) ...[
                    const SizedBox(height: 16),
                    _WateringReminderButton(
                      active: _reminderActive,
                      intervalDays: widget.analysis.wateringIntervalDays!,
                      s: s,
                      onTap: _toggleReminder,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'chat',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChatScreen(analysis: widget.analysis)),
            ),
            icon: const Icon(Icons.chat_bubble_outline_rounded),
            label: Text(s.askQuestion),
            backgroundColor: theme.colorScheme.secondaryContainer,
            foregroundColor: theme.colorScheme.onSecondaryContainer,
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'new',
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.add_photo_alternate_outlined),
            label: Text(s.newAnalysis),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isHealthy;
  final dynamic s;
  const _StatusBadge({required this.isHealthy, required this.s});

  @override
  Widget build(BuildContext context) {
    final color = isHealthy ? Colors.green[700]! : Colors.orange[700]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isHealthy ? Icons.check_circle : Icons.warning_amber_rounded,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            isHealthy ? s.healthy : s.needsAttention,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _ToxicityWarning extends StatelessWidget {
  final List<String> toxicTo;
  final String details;
  final dynamic s;
  const _ToxicityWarning(
      {required this.toxicTo, required this.details, required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_rounded, color: Colors.red, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  s.toxicWarningTitle,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          if (toxicTo.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Text('${s.toxicTo} ',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                ...toxicTo.map((who) => _ToxicChip(label: who)),
              ],
            ),
          ],
          if (details.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(details, style: const TextStyle(fontSize: 13)),
          ],
        ],
      ),
    );
  }
}

class _ToxicChip extends StatelessWidget {
  final String label;
  const _ToxicChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red[300]!),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 12, color: Colors.red)),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final PlantAnalysis current;
  final PlantAnalysis previous;
  final dynamic s;
  const _ProgressCard(
      {required this.current, required this.previous, required this.s});

  @override
  Widget build(BuildContext context) {
    final wasHealthy = previous.isHealthy;
    final isNowHealthy = current.isHealthy;
    final prevProblems = previous.problems.length;
    final nowProblems = current.problems.length;

    Color color;
    IconData icon;
    String statusText;

    if (!wasHealthy && isNowHealthy) {
      color = Colors.green;
      icon = Icons.trending_up;
      statusText = s.progressImproved;
    } else if (wasHealthy && !isNowHealthy) {
      color = Colors.red;
      icon = Icons.trending_down;
      statusText = s.progressWorsened;
    } else if (nowProblems < prevProblems) {
      color = Colors.green;
      icon = Icons.trending_up;
      statusText = s.progressFewerProblems;
    } else if (nowProblems > prevProblems) {
      color = Colors.orange;
      icon = Icons.trending_down;
      statusText = s.progressMoreProblems;
    } else {
      color = Colors.blue;
      icon = Icons.trending_flat;
      statusText = s.progressStable;
    }

    final prevDate = DateFormat('d MMM yyyy').format(previous.date);
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.compare_arrows_rounded, color: color, size: 22),
                const SizedBox(width: 8),
                Text(
                  s.progressTitle,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(statusText,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: color)),
                      Text(
                        '${s.progressPrevious}: $prevDate • $prevProblems ${s.progressProblems} → $nowProblems ${s.progressProblems}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WateringReminderButton extends StatelessWidget {
  final bool active;
  final int intervalDays;
  final dynamic s;
  final VoidCallback onTap;
  const _WateringReminderButton({
    required this.active,
    required this.intervalDays,
    required this.s,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(
        active ? Icons.notifications_active : Icons.notifications_none,
        color: active ? Colors.blue : null,
      ),
      label: Text(
        active
            ? '${s.reminderEnabled} (${s.wateringEvery} $intervalDays ${s.wateringDays})'
            : '${s.wateringReminder} — ${s.wateringEvery} $intervalDays ${s.wateringDays}',
        style: TextStyle(color: active ? Colors.blue : null),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        side: active ? const BorderSide(color: Colors.blue) : null,
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final List<String> items;

  const _Section({
    required this.icon,
    required this.title,
    required this.color,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      width: 6,
                      height: 6,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
