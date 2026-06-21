import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../l10n/locale_provider.dart';
import '../models/plant_analysis.dart';
import '../services/openai_service.dart';
import '../services/storage_service.dart';
import 'result_screen.dart';
import 'settings_screen.dart';
import 'paywall_screen.dart';

class AnalyzeScreen extends StatefulWidget {
  const AnalyzeScreen({super.key});

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  File? _image;
  bool _loading = false;
  final _picker = ImagePicker();
  final _openAI = OpenAIService();
  final _storage = StorageService();

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1024,
    );
    if (picked != null) setState(() => _image = File(picked.path));
  }

  Future<void> _analyze() async {
    if (_image == null) return;

    final apiKey = await _storage.loadApiKey();
    if (!mounted) return;

    if (apiKey == null || apiKey.isEmpty) {
      final s = context.read<LocaleProvider>().strings;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(s.apiKeyMissing),
          action: SnackBarAction(
            label: s.goToSettings,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ),
      );
      return;
    }

    // Check monthly free limit
    final count = await _storage.getMonthlyAnalysisCount();
    if (!mounted) return;
    if (count >= StorageService.freeLimit) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PaywallScreen()),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final locale = context.read<LocaleProvider>();
      final result = await _openAI.analyzePlant(
          _image!, apiKey, locale.strings.aiLanguageName);
      final savedPath = await _storage.saveImage(_image!);

      final toxicityData = result['toxicity'] as Map<String, dynamic>?;
      final analysis = PlantAnalysis(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imagePath: savedPath,
        plantName: result['plant_name'] as String? ?? 'Unknown plant',
        healthStatus: result['health_status'] as String? ?? 'needs_attention',
        healthDescription: result['health_description'] as String? ?? '',
        problems: List<String>.from(result['problems'] as List? ?? []),
        recommendations: List<String>.from(result['recommendations'] as List? ?? []),
        careTips: List<String>.from(result['care_tips'] as List? ?? []),
        date: DateTime.now(),
        isToxic: toxicityData?['is_toxic'] as bool?,
        toxicTo: toxicityData?['toxic_to'] != null
            ? List<String>.from(toxicityData!['toxic_to'] as List)
            : null,
        toxicityDetails: toxicityData?['details'] as String?,
        wateringIntervalDays: result['watering_interval_days'] is int
            ? result['watering_interval_days'] as int
            : null,
      );

      await _storage.saveAnalysis(analysis);
      await _storage.incrementAnalysisCount();

      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResultScreen(analysis: analysis)),
      );
      setState(() => _image = null);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${context.read<LocaleProvider>().strings.error}: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<LocaleProvider>().strings;
    final theme = Theme.of(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _loading ? null : () => _pickImage(ImageSource.gallery),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                        width: 1.5,
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 80,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                s.tapToSelect,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                s.uploadFromGallery,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          _loading ? null : () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: Text(_image == null ? s.gallery : s.fromGallery),
                      style:
                          OutlinedButton.styleFrom(minimumSize: const Size(0, 52)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          _loading ? null : () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: Text(_image == null ? s.camera : s.takePhoto),
                      style:
                          OutlinedButton.styleFrom(minimumSize: const Size(0, 52)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: (_image == null || _loading) ? null : _analyze,
                icon: const Icon(Icons.search),
                label: Text(_image == null ? s.selectOrPhoto : s.analyzeBtn),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
            ],
          ),
        ),
        if (_loading)
          Container(
            color: Colors.black45,
            child: Center(
              child: Card(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      Text(
                        s.analyzing,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        s.analyzingSubtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
