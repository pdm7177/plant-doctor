import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../l10n/locale_provider.dart';
import '../models/plant_analysis.dart';
import '../services/storage_service.dart';
import 'result_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _storage = StorageService();
  List<PlantAnalysis> _analyses = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final analyses = await _storage.loadAnalyses();
    if (mounted) {
      setState(() {
        _analyses = analyses;
        _loading = false;
      });
    }
  }

  Future<void> _delete(PlantAnalysis analysis) async {
    final s = context.read<LocaleProvider>().strings;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.deleteRecord),
        content: Text(s.deleteAnalysisConfirm(analysis.plantName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: Text(s.deleteConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await _storage.deleteAnalysis(analysis.id);
    final imageFile = File(analysis.imagePath);
    if (await imageFile.exists()) await imageFile.delete();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<LocaleProvider>().strings;
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_analyses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              s.historyEmpty,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Text(s.checkFirstPlant, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _analyses.length,
        itemBuilder: (context, i) {
          final analysis = _analyses[i];
          return _HistoryCard(
            analysis: analysis,
            s: s,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ResultScreen(analysis: analysis)),
              );
            },
            onDelete: () => _delete(analysis),
          );
        },
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final PlantAnalysis analysis;
  final dynamic s;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _HistoryCard({
    required this.analysis,
    required this.s,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isHealthy = analysis.isHealthy;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Image.file(
                File(analysis.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (_, e, st) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      analysis.plantName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          isHealthy
                              ? Icons.check_circle
                              : Icons.warning_amber_rounded,
                          size: 14,
                          color: isHealthy ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isHealthy ? s.healthy : s.needsAttention,
                          style: TextStyle(
                            color: isHealthy ? Colors.green : Colors.orange,
                            fontSize: 13,
                          ),
                        ),
                        if (analysis.isToxic == true) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.warning_rounded,
                              size: 14, color: Colors.red),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('d MMM yyyy').format(analysis.date),
                      style:
                          TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDelete,
              tooltip: s.deleteConfirm,
            ),
          ],
        ),
      ),
    );
  }
}
