import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/locale_provider.dart';
import '../services/storage_service.dart';
import '../services/supabase_service.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  int _usedCount = 0;

  @override
  void initState() {
    super.initState();
    SupabaseService().getRemainingAnalyses().then((remaining) {
      if (mounted) {
        setState(() => _usedCount = StorageService.freeLimit - remaining);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<LocaleProvider>().strings;
    final theme = Theme.of(context);
    final remaining = (StorageService.freeLimit - _usedCount).clamp(0, StorageService.freeLimit);

    return Scaffold(
      appBar: AppBar(title: Text(s.paywallTitle)),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star_rounded, size: 56, color: Colors.amber),
            ),
            const SizedBox(height: 32),
            Text(
              s.paywallSubtitle,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              s.paywallDesc,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            _LimitBar(used: _usedCount, total: StorageService.freeLimit),
            const SizedBox(height: 8),
            Text(
              '${s.paywallFreeLeft} $remaining / ${StorageService.freeLimit}',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 40),
            FilledButton.icon(
              onPressed: () {
                // TODO: integrate payment system
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Оплата буде доступна незабаром')),
                );
              },
              icon: const Icon(Icons.star_rounded),
              label: Text(s.paywallPrice),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: Colors.amber[700],
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
              ),
              child: Text(s.paywallBack),
            ),
          ],
        ),
      ),
    );
  }
}

class _LimitBar extends StatelessWidget {
  final int used;
  final int total;
  const _LimitBar({required this.used, required this.total});

  @override
  Widget build(BuildContext context) {
    final fraction = (used / total).clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: fraction,
        minHeight: 12,
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(
          fraction >= 1.0 ? Colors.red : Colors.amber[700]!,
        ),
      ),
    );
  }
}
