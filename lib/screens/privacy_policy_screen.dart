import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/locale_provider.dart';
import '../services/storage_service.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const Map<String, String> _policyText = {
    'uk': '''Дата оновлення: червень 2026

Plant Doctor — мобільний застосунок для діагностики здоров'я рослин. Ця політика пояснює, як ми обробляємо ваші дані.

ДАНІ, ЯКІ МИ ЗБИРАЄМО

• Фотографії рослин — надсилаються на сервери OpenAI для аналізу. Ми не зберігаємо їх на власних серверах.
• Результати аналізів — зберігаються виключно на вашому пристрої.
• API ключ OpenAI — зберігається локально на вашому пристрої, ніколи не передається нам.
• Нагадування про полив — зберігаються локально на вашому пристрої.

СТОРОННІ СЕРВІСИ

Фотографії обробляються сервісом OpenAI (GPT-4o). Використовуючи застосунок, ви погоджуєтесь з Політикою конфіденційності OpenAI (openai.com).

ЗБЕРІГАННЯ ДАНИХ

Усі дані, крім фотографій, надісланих на аналіз, зберігаються виключно на вашому пристрої. Ми не маємо серверів або баз даних, що збирають вашу особисту інформацію.

ВАШІ ПРАВА

Ви можете видалити всі свої дані в будь-який час за допомогою кнопки нижче.

ЗВ'ЯЗОК

З питань щодо цієї політики: p.dm.7177@gmail.com''',
    'en': '''Last updated: June 2026

Plant Doctor is a mobile application for plant health diagnosis. This policy explains how we handle your data.

DATA WE COLLECT

• Plant photos — sent to OpenAI's servers for analysis. We do not store them on our own servers.
• Analysis history — saved locally on your device only.
• OpenAI API key — stored locally on your device only, never transmitted to us.
• Watering reminders — stored locally on your device only.

THIRD-PARTY SERVICES

Your photos are processed by OpenAI (GPT-4o). By using this app, you agree to OpenAI's Privacy Policy (openai.com).

DATA STORAGE

All data except photos sent for analysis is stored exclusively on your device. We have no servers or databases collecting your personal information.

YOUR RIGHTS

You can delete all your data at any time using the button below.

CONTACT

For questions about this policy: p.dm.7177@gmail.com''',
    'es': '''Última actualización: junio de 2026

Plant Doctor es una aplicación móvil para el diagnóstico de la salud de las plantas. Esta política explica cómo manejamos tus datos.

DATOS QUE RECOPILAMOS

• Fotos de plantas — enviadas a los servidores de OpenAI para su análisis. No las almacenamos en nuestros propios servidores.
• Historial de análisis — guardado localmente solo en tu dispositivo.
• Clave API de OpenAI — almacenada localmente en tu dispositivo, nunca nos la transmites.
• Recordatorios de riego — almacenados localmente en tu dispositivo.

SERVICIOS DE TERCEROS

Tus fotos son procesadas por OpenAI (GPT-4o). Al usar esta aplicación, aceptas la Política de privacidad de OpenAI (openai.com).

ALMACENAMIENTO DE DATOS

Todos los datos, excepto las fotos enviadas para análisis, se almacenan exclusivamente en tu dispositivo. No tenemos servidores ni bases de datos que recopilen tu información personal.

TUS DERECHOS

Puedes eliminar todos tus datos en cualquier momento usando el botón de abajo.

CONTACTO

Para preguntas sobre esta política: p.dm.7177@gmail.com''',
    'ru': '''Дата обновления: июнь 2026

Plant Doctor — мобильное приложение для диагностики здоровья растений. Эта политика объясняет, как мы обрабатываем ваши данные.

ДАННЫЕ, КОТОРЫЕ МЫ СОБИРАЕМ

• Фотографии растений — отправляются на серверы OpenAI для анализа. Мы не храним их на собственных серверах.
• История анализов — сохраняется исключительно на вашем устройстве.
• API ключ OpenAI — хранится локально на вашем устройстве, никогда не передаётся нам.
• Напоминания о поливе — хранятся локально на вашем устройстве.

СТОРОННИЕ СЕРВИСЫ

Фотографии обрабатываются сервисом OpenAI (GPT-4o). Используя приложение, вы соглашаетесь с Политикой конфиденциальности OpenAI (openai.com).

ХРАНЕНИЕ ДАННЫХ

Все данные, кроме фотографий, отправленных на анализ, хранятся исключительно на вашем устройстве. У нас нет серверов или баз данных, собирающих вашу личную информацию.

ВАШИ ПРАВА

Вы можете удалить все свои данные в любое время с помощью кнопки ниже.

КОНТАКТ

По вопросам этой политики: p.dm.7177@gmail.com''',
    'de': '''Zuletzt aktualisiert: Juni 2026

Plant Doctor ist eine mobile Anwendung zur Diagnose der Pflanzengesundheit. Diese Richtlinie erklärt, wie wir mit deinen Daten umgehen.

DATEN, DIE WIR ERFASSEN

• Pflanzenfotos — werden zur Analyse an OpenAI-Server gesendet. Wir speichern sie nicht auf unseren eigenen Servern.
• Analysehistorie — wird ausschließlich lokal auf deinem Gerät gespeichert.
• OpenAI API-Schlüssel — wird lokal auf deinem Gerät gespeichert, niemals an uns übertragen.
• Gieß-Erinnerungen — werden lokal auf deinem Gerät gespeichert.

DRITTANBIETER-DIENSTE

Deine Fotos werden von OpenAI (GPT-4o) verarbeitet. Durch die Nutzung der App stimmst du der Datenschutzrichtlinie von OpenAI (openai.com) zu.

DATENSPEICHERUNG

Alle Daten außer den zur Analyse gesendeten Fotos werden ausschließlich auf deinem Gerät gespeichert. Wir haben keine Server oder Datenbanken, die deine persönlichen Daten sammeln.

DEINE RECHTE

Du kannst alle deine Daten jederzeit über die Schaltfläche unten löschen.

KONTAKT

Bei Fragen zu dieser Richtlinie: p.dm.7177@gmail.com''',
    'fr': '''Dernière mise à jour : juin 2026

Plant Doctor est une application mobile de diagnostic de la santé des plantes. Cette politique explique comment nous traitons vos données.

DONNÉES QUE NOUS COLLECTONS

• Photos de plantes — envoyées aux serveurs d'OpenAI pour analyse. Nous ne les stockons pas sur nos propres serveurs.
• Historique des analyses — sauvegardé uniquement en local sur votre appareil.
• Clé API OpenAI — stockée en local sur votre appareil, jamais transmise à nos serveurs.
• Rappels d'arrosage — stockés en local sur votre appareil.

SERVICES TIERS

Vos photos sont traitées par OpenAI (GPT-4o). En utilisant cette application, vous acceptez la Politique de confidentialité d'OpenAI (openai.com).

STOCKAGE DES DONNÉES

Toutes les données, sauf les photos envoyées pour analyse, sont stockées exclusivement sur votre appareil. Nous ne disposons d'aucun serveur ni base de données collectant vos informations personnelles.

VOS DROITS

Vous pouvez supprimer toutes vos données à tout moment en utilisant le bouton ci-dessous.

CONTACT

Pour toute question sur cette politique : p.dm.7177@gmail.com''',
  };

  Future<void> _confirmDelete(BuildContext context) async {
    final s = context.read<LocaleProvider>().strings;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.deleteDataTitle),
        content: Text(s.deleteDataMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(s.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(s.deleteDataBtn),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    await StorageService().clearAllData();
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(s.deleteDataDone)),
    );
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<LocaleProvider>().strings;
    final lang = context.watch<LocaleProvider>().languageCode;
    final text = _policyText[lang] ?? _policyText['en']!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(s.privacyPolicy)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                20, 8, 20, MediaQuery.of(context).padding.bottom + 20),
            child: OutlinedButton.icon(
              onPressed: () => _confirmDelete(context),
              icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
              label: Text(
                s.deleteDataBtn,
                style: const TextStyle(color: Colors.red),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
