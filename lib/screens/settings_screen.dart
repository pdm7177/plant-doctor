import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/locale_provider.dart';
import '../services/storage_service.dart';
import '../services/supabase_service.dart';
import 'privacy_policy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _controller = TextEditingController();
  final _storage = StorageService();
  bool _obscure = true;
  bool _saved = false;
  int _usedCount = 0;

  @override
  void initState() {
    super.initState();
    _storage.loadApiKey().then((key) {
      if (key != null && mounted) {
        _controller.text = key;
        setState(() => _saved = true);
      }
    });
    SupabaseService().getRemainingAnalyses().then((remaining) {
      if (mounted) {
        setState(() => _usedCount = StorageService.freeLimit - remaining);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    final s = context.read<LocaleProvider>().strings;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.signOutTitle),
        content: Text(s.signOutMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(s.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(s.signOutBtn),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await SupabaseService().signOut();
    }
  }

  Future<void> _save() async {
    final s = context.read<LocaleProvider>().strings;
    final key = _controller.text.trim();
    if (key.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.apiKeyEmpty)),
      );
      return;
    }
    await _storage.saveApiKey(key);
    if (!mounted) return;
    setState(() => _saved = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s.apiKeySaved)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final s = locale.strings;
    final theme = Theme.of(context);
    final remaining =
        (StorageService.freeLimit - _usedCount).clamp(0, StorageService.freeLimit);

    return Scaffold(
      appBar: AppBar(title: Text(s.settings)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language selector
            Text(
              s.languageTitle,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _LanguageSelector(
              current: locale.languageCode,
              onChanged: (code) => locale.setLanguage(code),
              s: s,
            ),
            const SizedBox(height: 32),

            // API key
            Text(
              s.apiKeyTitle,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(s.apiKeyDesc, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              obscureText: _obscure,
              onChanged: (_) => setState(() => _saved = false),
              decoration: InputDecoration(
                hintText: s.apiKeyHint,
                border: const OutlineInputBorder(),
                prefixIcon: _saved
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.key_outlined),
                suffixIcon: IconButton(
                  icon: Icon(_obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: Text(s.save),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
              ),
            ),
            const SizedBox(height: 32),

            // Monthly limit info
            Text(
              s.paywallFreeLeft,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: (_usedCount / StorageService.freeLimit).clamp(0.0, 1.0),
                      minHeight: 10,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(
                        _usedCount >= StorageService.freeLimit
                            ? Colors.red
                            : Colors.green[700]!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '$remaining / ${StorageService.freeLimit}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: remaining == 0 ? Colors.red : Colors.green[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Privacy Policy link
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text(s.privacyPolicy),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const PrivacyPolicyScreen()),
              ),
            ),

            const Divider(height: 32),

            // Account info + sign out
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.account_circle_outlined),
              title: Text(s.account),
              subtitle: Text(
                SupabaseService().currentUser?.email ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                s.signOutBtn,
                style: const TextStyle(color: Colors.red),
              ),
              onTap: _signOut,
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  final String current;
  final void Function(String) onChanged;
  final dynamic s;

  const _LanguageSelector({
    required this.current,
    required this.onChanged,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    final options = [
      ('uk', s.languageUk, '🇺🇦'),
      ('en', s.languageEn, '🇬🇧'),
      ('es', s.languageEs, '🇪🇸'),
      ('ru', s.languageRu, '🇷🇺'),
      ('de', s.languageDe, '🇩🇪'),
      ('fr', s.languageFr, '🇫🇷'),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1.6,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: options.map((opt) {
        final (code, label, flag) = opt;
        final isSelected = current == code;
        return GestureDetector(
          onTap: () => onChanged(code),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 2)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(flag, style: const TextStyle(fontSize: 22)),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color:
                        isSelected ? Theme.of(context).colorScheme.primary : null,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
