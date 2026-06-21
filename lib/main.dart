import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/locale_provider.dart';
import 'screens/main_screen.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.init();
  final localeProvider = LocaleProvider();
  await localeProvider.load();
  runApp(
    ChangeNotifierProvider.value(
      value: localeProvider,
      child: const PlantDoctorApp(),
    ),
  );
}

class PlantDoctorApp extends StatelessWidget {
  const PlantDoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Doctor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
