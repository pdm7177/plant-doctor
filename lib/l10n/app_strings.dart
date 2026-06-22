class AppStrings {
  final String languageCode;
  const AppStrings(this.languageCode);

  static const Map<String, Map<String, String>> _strings = {
    'uk': {
      'appTitle': 'Plant Doctor',
      'tabAnalyze': 'Аналіз',
      'tabHistory': 'Історія',
      'settings': 'Налаштування',
      'analyzeBtn': 'Аналізувати',
      'selectOrPhoto': 'Виберіть або сфотографуйте рослину',
      'gallery': 'Галерея',
      'fromGallery': 'З галереї',
      'camera': 'Камера',
      'takePhoto': 'Зробити фото',
      'tapToSelect': 'Натисніть щоб вибрати фото',
      'uploadFromGallery': 'Завантажте фото з галереї',
      'analyzing': 'Аналізую рослину...',
      'analyzingSubtitle': 'Це може зайняти кілька секунд',
      'newAnalysis': 'Новий аналіз',
      'healthy': 'Рослина здорова',
      'needsAttention': 'Потребує уваги',
      'problems': 'Проблеми',
      'careRecommendations': 'Рекомендації по догляду',
      'usefulTips': 'Корисні поради',
      'historyEmpty': 'Історія порожня',
      'checkFirstPlant': 'Перевірте свою першу рослину!',
      'deleteRecord': 'Видалити запис?',
      'deleteConfirm': 'Видалити',
      'cancel': 'Скасувати',
      'apiKeyTitle': 'OpenAI API ключ',
      'apiKeyDesc':
          'Введіть ваш API ключ від OpenAI (platform.openai.com). Ключ зберігається тільки на вашому пристрої.',
      'apiKeyHint': 'sk-...',
      'save': 'Зберегти',
      'apiKeySaved': 'API ключ збережено',
      'apiKeyEmpty': 'Введіть API ключ',
      'apiKeyMissing': 'Спочатку додайте API ключ у налаштуваннях',
      'goToSettings': 'Налаштування',
      'error': 'Помилка',
      'toxicWarningTitle': 'Увага: токсична рослина',
      'toxicTo': 'Небезпечна для:',
      'toxicCats': 'кішок',
      'toxicDogs': 'собак',
      'toxicChildren': 'дітей',
      'progressTitle': 'Порівняння з попереднім аналізом',
      'progressPrevious': 'Попередня перевірка',
      'progressImproved': 'Рослина покращилась',
      'progressWorsened': 'Стан погіршився',
      'progressStable': 'Стан стабільний',
      'progressMoreProblems': 'Більше проблем',
      'progressFewerProblems': 'Менше проблем',
      'progressProblems': 'проблем',
      'askQuestion': 'Запитати про рослину',
      'chatTitle': 'Запитання про рослину',
      'chatHint': 'Ваше запитання...',
      'chatSend': 'Надіслати',
      'wateringReminder': 'Нагадування про полив',
      'wateringReminderSet': 'Нагадування встановлено',
      'wateringReminderCancel': 'Скасувати нагадування',
      'wateringReminderDesc': 'Нагадую полити',
      'wateringEvery': 'Поливати кожні',
      'wateringDays': 'днів',
      'reminderEnabled': 'Нагадування увімкнено',
      'reminderDisabled': 'Нагадування вимкнено',
      'paywallTitle': 'Преміум доступ',
      'paywallSubtitle': 'Ліміт безкоштовних аналізів вичерпано',
      'paywallDesc':
          'Ви використали 5 безкоштовних аналізів за останні 30 днів. Оформіть підписку щоб продовжити.',
      'paywallPrice': 'Підписатися — \$4.99/місяць',
      'paywallBack': 'Повернутися назад',
      'paywallFreeLeft': 'Безкоштовних аналізів залишилось:',
      'languageTitle': 'Мова',
      'languageUk': 'Українська',
      'languageEn': 'English',
      'languageEs': 'Español',
      'languageRu': 'Русский',
      'languageDe': 'Deutsch',
      'languageFr': 'Français',
      'deleteAnalysisConfirm': 'Видалити "{name}" з історії?',
      'loginSubtitle': 'Діагностика рослин за допомогою ШІ',
      'loginWithGoogle': 'Увійти через Google',
      'loginPrivacyNote': 'Входячи, ви погоджуєтесь з Політикою конфіденційності',
      'account': 'Акаунт',
      'signOutBtn': 'Вийти з акаунту',
      'signOutTitle': 'Вийти?',
      'signOutMsg': 'Ви впевнені, що хочете вийти з акаунту?',
      'recWatering': 'Полив',
      'recLight': 'Освітлення',
      'recTemperature': 'Температура',
      'recFertilizer': 'Добриво',
      'recAdditional': 'Додатково',
      'notifPermDenied': 'Дозвіл на сповіщення не надано',
      'privacyPolicy': 'Політика конфіденційності',
      'deleteDataBtn': 'Видалити всі дані',
      'deleteDataTitle': 'Видалити всі дані?',
      'deleteDataMsg':
          'Вся історія аналізів, нагадування та API ключ будуть видалені з пристрою. Цю дію не можна скасувати.',
      'deleteDataDone': 'Всі дані видалено',
    },
    'en': {
      'appTitle': 'Plant Doctor',
      'tabAnalyze': 'Analyze',
      'tabHistory': 'History',
      'settings': 'Settings',
      'analyzeBtn': 'Analyze',
      'selectOrPhoto': 'Select or photograph a plant',
      'gallery': 'Gallery',
      'fromGallery': 'From gallery',
      'camera': 'Camera',
      'takePhoto': 'Take photo',
      'tapToSelect': 'Tap to select a photo',
      'uploadFromGallery': 'Upload a photo from gallery',
      'analyzing': 'Analyzing plant...',
      'analyzingSubtitle': 'This may take a few seconds',
      'newAnalysis': 'New analysis',
      'healthy': 'Plant is healthy',
      'needsAttention': 'Needs attention',
      'problems': 'Problems',
      'careRecommendations': 'Care recommendations',
      'usefulTips': 'Useful tips',
      'historyEmpty': 'History is empty',
      'checkFirstPlant': 'Check your first plant!',
      'deleteRecord': 'Delete record?',
      'deleteConfirm': 'Delete',
      'cancel': 'Cancel',
      'apiKeyTitle': 'OpenAI API Key',
      'apiKeyDesc':
          'Enter your OpenAI API key (platform.openai.com). The key is stored only on your device.',
      'apiKeyHint': 'sk-...',
      'save': 'Save',
      'apiKeySaved': 'API key saved',
      'apiKeyEmpty': 'Please enter an API key',
      'apiKeyMissing': 'Please add an API key in settings first',
      'goToSettings': 'Settings',
      'error': 'Error',
      'toxicWarningTitle': 'Warning: toxic plant',
      'toxicTo': 'Dangerous for:',
      'toxicCats': 'cats',
      'toxicDogs': 'dogs',
      'toxicChildren': 'children',
      'progressTitle': 'Compared to previous analysis',
      'progressPrevious': 'Previous check',
      'progressImproved': 'Plant has improved',
      'progressWorsened': 'Condition has worsened',
      'progressStable': 'Condition is stable',
      'progressMoreProblems': 'More problems',
      'progressFewerProblems': 'Fewer problems',
      'progressProblems': 'problems',
      'askQuestion': 'Ask about this plant',
      'chatTitle': 'Plant question',
      'chatHint': 'Your question...',
      'chatSend': 'Send',
      'wateringReminder': 'Watering reminder',
      'wateringReminderSet': 'Reminder set',
      'wateringReminderCancel': 'Cancel reminder',
      'wateringReminderDesc': 'Time to water',
      'wateringEvery': 'Water every',
      'wateringDays': 'days',
      'reminderEnabled': 'Reminder enabled',
      'reminderDisabled': 'Reminder disabled',
      'paywallTitle': 'Premium access',
      'paywallSubtitle': 'Free analysis limit reached',
      'paywallDesc':
          'You have used 5 free analyses in the last 30 days. Subscribe to continue.',
      'paywallPrice': 'Subscribe — \$4.99/month',
      'paywallBack': 'Go back',
      'paywallFreeLeft': 'Free analyses remaining:',
      'languageTitle': 'Language',
      'languageUk': 'Українська',
      'languageEn': 'English',
      'languageEs': 'Español',
      'languageRu': 'Русский',
      'languageDe': 'Deutsch',
      'languageFr': 'Français',
      'deleteAnalysisConfirm': 'Delete "{name}" from history?',
      'loginSubtitle': 'AI-powered plant health diagnosis',
      'loginWithGoogle': 'Sign in with Google',
      'loginPrivacyNote': 'By signing in, you agree to our Privacy Policy',
      'account': 'Account',
      'signOutBtn': 'Sign Out',
      'signOutTitle': 'Sign Out?',
      'signOutMsg': 'Are you sure you want to sign out?',
      'recWatering': 'Watering',
      'recLight': 'Light',
      'recTemperature': 'Temperature',
      'recFertilizer': 'Fertilizer',
      'recAdditional': 'Additional',
      'notifPermDenied': 'Notification permission denied',
      'privacyPolicy': 'Privacy Policy',
      'deleteDataBtn': 'Delete all data',
      'deleteDataTitle': 'Delete all data?',
      'deleteDataMsg':
          'All analysis history, reminders and API key will be deleted from your device. This action cannot be undone.',
      'deleteDataDone': 'All data deleted',
    },
    'es': {
      'appTitle': 'Plant Doctor',
      'tabAnalyze': 'Analizar',
      'tabHistory': 'Historial',
      'settings': 'Ajustes',
      'analyzeBtn': 'Analizar',
      'selectOrPhoto': 'Selecciona o fotografía una planta',
      'gallery': 'Galería',
      'fromGallery': 'De la galería',
      'camera': 'Cámara',
      'takePhoto': 'Tomar foto',
      'tapToSelect': 'Toca para seleccionar una foto',
      'uploadFromGallery': 'Sube una foto de la galería',
      'analyzing': 'Analizando la planta...',
      'analyzingSubtitle': 'Esto puede tardar unos segundos',
      'newAnalysis': 'Nuevo análisis',
      'healthy': 'La planta está sana',
      'needsAttention': 'Necesita atención',
      'problems': 'Problemas',
      'careRecommendations': 'Recomendaciones de cuidado',
      'usefulTips': 'Consejos útiles',
      'historyEmpty': 'El historial está vacío',
      'checkFirstPlant': '¡Revisa tu primera planta!',
      'deleteRecord': '¿Eliminar registro?',
      'deleteConfirm': 'Eliminar',
      'cancel': 'Cancelar',
      'apiKeyTitle': 'Clave API de OpenAI',
      'apiKeyDesc':
          'Ingresa tu clave API de OpenAI (platform.openai.com). La clave se almacena solo en tu dispositivo.',
      'apiKeyHint': 'sk-...',
      'save': 'Guardar',
      'apiKeySaved': 'Clave API guardada',
      'apiKeyEmpty': 'Por favor ingresa una clave API',
      'apiKeyMissing': 'Primero agrega una clave API en los ajustes',
      'goToSettings': 'Ajustes',
      'error': 'Error',
      'toxicWarningTitle': 'Advertencia: planta tóxica',
      'toxicTo': 'Peligrosa para:',
      'toxicCats': 'gatos',
      'toxicDogs': 'perros',
      'toxicChildren': 'niños',
      'progressTitle': 'Comparado con el análisis anterior',
      'progressPrevious': 'Revisión anterior',
      'progressImproved': 'La planta ha mejorado',
      'progressWorsened': 'La condición ha empeorado',
      'progressStable': 'La condición es estable',
      'progressMoreProblems': 'Más problemas',
      'progressFewerProblems': 'Menos problemas',
      'progressProblems': 'problemas',
      'askQuestion': 'Preguntar sobre esta planta',
      'chatTitle': 'Pregunta sobre la planta',
      'chatHint': 'Tu pregunta...',
      'chatSend': 'Enviar',
      'wateringReminder': 'Recordatorio de riego',
      'wateringReminderSet': 'Recordatorio establecido',
      'wateringReminderCancel': 'Cancelar recordatorio',
      'wateringReminderDesc': 'Es hora de regar',
      'wateringEvery': 'Regar cada',
      'wateringDays': 'días',
      'reminderEnabled': 'Recordatorio activado',
      'reminderDisabled': 'Recordatorio desactivado',
      'paywallTitle': 'Acceso premium',
      'paywallSubtitle': 'Límite de análisis gratuitos alcanzado',
      'paywallDesc':
          'Has usado 5 análisis gratuitos en los últimos 30 días. Suscríbete para continuar.',
      'paywallPrice': 'Suscribirse — \$4.99/mes',
      'paywallBack': 'Volver',
      'paywallFreeLeft': 'Análisis gratuitos restantes:',
      'languageTitle': 'Idioma',
      'languageUk': 'Українська',
      'languageEn': 'English',
      'languageEs': 'Español',
      'languageRu': 'Русский',
      'languageDe': 'Deutsch',
      'languageFr': 'Français',
      'deleteAnalysisConfirm': '¿Eliminar "{name}" del historial?',
      'loginSubtitle': 'Diagnóstico de plantas con IA',
      'loginWithGoogle': 'Iniciar sesión con Google',
      'loginPrivacyNote': 'Al iniciar sesión, aceptas nuestra Política de privacidad',
      'account': 'Cuenta',
      'signOutBtn': 'Cerrar sesión',
      'signOutTitle': '¿Cerrar sesión?',
      'signOutMsg': '¿Seguro que quieres cerrar sesión?',
      'recWatering': 'Riego',
      'recLight': 'Luz',
      'recTemperature': 'Temperatura',
      'recFertilizer': 'Fertilizante',
      'recAdditional': 'Adicional',
      'notifPermDenied': 'Permiso de notificación denegado',
      'privacyPolicy': 'Política de privacidad',
      'deleteDataBtn': 'Eliminar todos los datos',
      'deleteDataTitle': '¿Eliminar todos los datos?',
      'deleteDataMsg':
          'Todo el historial de análisis, recordatorios y clave API se eliminarán de tu dispositivo. Esta acción no se puede deshacer.',
      'deleteDataDone': 'Todos los datos eliminados',
    },
    'ru': {
      'appTitle': 'Plant Doctor',
      'tabAnalyze': 'Анализ',
      'tabHistory': 'История',
      'settings': 'Настройки',
      'analyzeBtn': 'Анализировать',
      'selectOrPhoto': 'Выберите или сфотографируйте растение',
      'gallery': 'Галерея',
      'fromGallery': 'Из галереи',
      'camera': 'Камера',
      'takePhoto': 'Сделать фото',
      'tapToSelect': 'Нажмите чтобы выбрать фото',
      'uploadFromGallery': 'Загрузите фото из галереи',
      'analyzing': 'Анализирую растение...',
      'analyzingSubtitle': 'Это может занять несколько секунд',
      'newAnalysis': 'Новый анализ',
      'healthy': 'Растение здорово',
      'needsAttention': 'Требует внимания',
      'problems': 'Проблемы',
      'careRecommendations': 'Рекомендации по уходу',
      'usefulTips': 'Полезные советы',
      'historyEmpty': 'История пуста',
      'checkFirstPlant': 'Проверьте ваше первое растение!',
      'deleteRecord': 'Удалить запись?',
      'deleteConfirm': 'Удалить',
      'cancel': 'Отмена',
      'apiKeyTitle': 'OpenAI API ключ',
      'apiKeyDesc':
          'Введите ваш API ключ от OpenAI (platform.openai.com). Ключ хранится только на вашем устройстве.',
      'apiKeyHint': 'sk-...',
      'save': 'Сохранить',
      'apiKeySaved': 'API ключ сохранён',
      'apiKeyEmpty': 'Введите API ключ',
      'apiKeyMissing': 'Сначала добавьте API ключ в настройках',
      'goToSettings': 'Настройки',
      'error': 'Ошибка',
      'toxicWarningTitle': 'Внимание: токсичное растение',
      'toxicTo': 'Опасно для:',
      'toxicCats': 'кошек',
      'toxicDogs': 'собак',
      'toxicChildren': 'детей',
      'progressTitle': 'Сравнение с предыдущим анализом',
      'progressPrevious': 'Предыдущая проверка',
      'progressImproved': 'Растение улучшилось',
      'progressWorsened': 'Состояние ухудшилось',
      'progressStable': 'Состояние стабильно',
      'progressMoreProblems': 'Больше проблем',
      'progressFewerProblems': 'Меньше проблем',
      'progressProblems': 'проблем',
      'askQuestion': 'Спросить о растении',
      'chatTitle': 'Вопрос о растении',
      'chatHint': 'Ваш вопрос...',
      'chatSend': 'Отправить',
      'wateringReminder': 'Напоминание о поливе',
      'wateringReminderSet': 'Напоминание установлено',
      'wateringReminderCancel': 'Отменить напоминание',
      'wateringReminderDesc': 'Напоминаю полить',
      'wateringEvery': 'Поливать каждые',
      'wateringDays': 'дней',
      'reminderEnabled': 'Напоминание включено',
      'reminderDisabled': 'Напоминание выключено',
      'paywallTitle': 'Премиум доступ',
      'paywallSubtitle': 'Лимит бесплатных анализов исчерпан',
      'paywallDesc':
          'Вы использовали 5 бесплатных анализов за последние 30 дней. Оформите подписку чтобы продолжить.',
      'paywallPrice': 'Подписаться — \$4.99/месяц',
      'paywallBack': 'Вернуться назад',
      'paywallFreeLeft': 'Бесплатных анализов осталось:',
      'languageTitle': 'Язык',
      'languageUk': 'Українська',
      'languageEn': 'English',
      'languageEs': 'Español',
      'languageRu': 'Русский',
      'languageDe': 'Deutsch',
      'languageFr': 'Français',
      'deleteAnalysisConfirm': 'Удалить "{name}" из истории?',
      'loginSubtitle': 'Диагностика растений с помощью ИИ',
      'loginWithGoogle': 'Войти через Google',
      'loginPrivacyNote': 'Входя, вы соглашаетесь с Политикой конфиденциальности',
      'account': 'Аккаунт',
      'signOutBtn': 'Выйти из аккаунта',
      'signOutTitle': 'Выйти?',
      'signOutMsg': 'Вы уверены, что хотите выйти из аккаунта?',
      'recWatering': 'Полив',
      'recLight': 'Освещение',
      'recTemperature': 'Температура',
      'recFertilizer': 'Удобрение',
      'recAdditional': 'Дополнительно',
      'notifPermDenied': 'Разрешение на уведомления не предоставлено',
      'privacyPolicy': 'Политика конфиденциальности',
      'deleteDataBtn': 'Удалить все данные',
      'deleteDataTitle': 'Удалить все данные?',
      'deleteDataMsg':
          'Вся история анализов, напоминания и API ключ будут удалены с устройства. Это действие нельзя отменить.',
      'deleteDataDone': 'Все данные удалены',
    },
    'de': {
      'appTitle': 'Plant Doctor',
      'tabAnalyze': 'Analyse',
      'tabHistory': 'Verlauf',
      'settings': 'Einstellungen',
      'analyzeBtn': 'Analysieren',
      'selectOrPhoto': 'Pflanze auswählen oder fotografieren',
      'gallery': 'Galerie',
      'fromGallery': 'Aus Galerie',
      'camera': 'Kamera',
      'takePhoto': 'Foto aufnehmen',
      'tapToSelect': 'Tippen um Foto auszuwählen',
      'uploadFromGallery': 'Foto aus Galerie hochladen',
      'analyzing': 'Pflanze analysieren...',
      'analyzingSubtitle': 'Dies kann einige Sekunden dauern',
      'newAnalysis': 'Neue Analyse',
      'healthy': 'Pflanze ist gesund',
      'needsAttention': 'Braucht Aufmerksamkeit',
      'problems': 'Probleme',
      'careRecommendations': 'Pflegeempfehlungen',
      'usefulTips': 'Nützliche Tipps',
      'historyEmpty': 'Verlauf ist leer',
      'checkFirstPlant': 'Prüfe deine erste Pflanze!',
      'deleteRecord': 'Eintrag löschen?',
      'deleteConfirm': 'Löschen',
      'cancel': 'Abbrechen',
      'apiKeyTitle': 'OpenAI API-Schlüssel',
      'apiKeyDesc':
          'Gib deinen OpenAI API-Schlüssel ein (platform.openai.com). Der Schlüssel wird nur auf deinem Gerät gespeichert.',
      'apiKeyHint': 'sk-...',
      'save': 'Speichern',
      'apiKeySaved': 'API-Schlüssel gespeichert',
      'apiKeyEmpty': 'Bitte API-Schlüssel eingeben',
      'apiKeyMissing': 'Bitte zuerst API-Schlüssel in Einstellungen hinzufügen',
      'goToSettings': 'Einstellungen',
      'error': 'Fehler',
      'toxicWarningTitle': 'Achtung: giftige Pflanze',
      'toxicTo': 'Gefährlich für:',
      'toxicCats': 'Katzen',
      'toxicDogs': 'Hunde',
      'toxicChildren': 'Kinder',
      'progressTitle': 'Vergleich mit vorheriger Analyse',
      'progressPrevious': 'Vorherige Prüfung',
      'progressImproved': 'Pflanze hat sich verbessert',
      'progressWorsened': 'Zustand hat sich verschlechtert',
      'progressStable': 'Zustand ist stabil',
      'progressMoreProblems': 'Mehr Probleme',
      'progressFewerProblems': 'Weniger Probleme',
      'progressProblems': 'Probleme',
      'askQuestion': 'Über diese Pflanze fragen',
      'chatTitle': 'Pflanzenfrage',
      'chatHint': 'Deine Frage...',
      'chatSend': 'Senden',
      'wateringReminder': 'Gieß-Erinnerung',
      'wateringReminderSet': 'Erinnerung gesetzt',
      'wateringReminderCancel': 'Erinnerung abbrechen',
      'wateringReminderDesc': 'Zeit zum Gießen',
      'wateringEvery': 'Gießen alle',
      'wateringDays': 'Tage',
      'reminderEnabled': 'Erinnerung aktiviert',
      'reminderDisabled': 'Erinnerung deaktiviert',
      'paywallTitle': 'Premium-Zugang',
      'paywallSubtitle': 'Limit für kostenlose Analysen erreicht',
      'paywallDesc':
          'Du hast 5 kostenlose Analysen in den letzten 30 Tagen verwendet. Abonnieren um fortzufahren.',
      'paywallPrice': 'Abonnieren — \$4.99/Monat',
      'paywallBack': 'Zurück',
      'paywallFreeLeft': 'Kostenlose Analysen übrig:',
      'languageTitle': 'Sprache',
      'languageUk': 'Українська',
      'languageEn': 'English',
      'languageEs': 'Español',
      'languageRu': 'Русский',
      'languageDe': 'Deutsch',
      'languageFr': 'Français',
      'deleteAnalysisConfirm': '"{name}" aus Verlauf löschen?',
      'loginSubtitle': 'KI-gestützte Pflanzendiagnose',
      'loginWithGoogle': 'Mit Google anmelden',
      'loginPrivacyNote': 'Durch die Anmeldung stimmst du unserer Datenschutzrichtlinie zu',
      'account': 'Konto',
      'signOutBtn': 'Abmelden',
      'signOutTitle': 'Abmelden?',
      'signOutMsg': 'Möchtest du dich wirklich abmelden?',
      'recWatering': 'Bewässerung',
      'recLight': 'Licht',
      'recTemperature': 'Temperatur',
      'recFertilizer': 'Dünger',
      'recAdditional': 'Zusätzlich',
      'notifPermDenied': 'Benachrichtigungsberechtigung verweigert',
      'privacyPolicy': 'Datenschutzrichtlinie',
      'deleteDataBtn': 'Alle Daten löschen',
      'deleteDataTitle': 'Alle Daten löschen?',
      'deleteDataMsg':
          'Die gesamte Analysehistorie, Erinnerungen und der API-Schlüssel werden vom Gerät gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.',
      'deleteDataDone': 'Alle Daten gelöscht',
    },
    'fr': {
      'appTitle': 'Plant Doctor',
      'tabAnalyze': 'Analyser',
      'tabHistory': 'Historique',
      'settings': 'Paramètres',
      'analyzeBtn': 'Analyser',
      'selectOrPhoto': 'Sélectionnez ou photographiez une plante',
      'gallery': 'Galerie',
      'fromGallery': 'De la galerie',
      'camera': 'Appareil photo',
      'takePhoto': 'Prendre une photo',
      'tapToSelect': 'Appuyez pour sélectionner une photo',
      'uploadFromGallery': 'Téléchargez une photo de la galerie',
      'analyzing': 'Analyse de la plante...',
      'analyzingSubtitle': 'Cela peut prendre quelques secondes',
      'newAnalysis': 'Nouvelle analyse',
      'healthy': 'La plante est saine',
      'needsAttention': 'Nécessite attention',
      'problems': 'Problèmes',
      'careRecommendations': 'Recommandations de soins',
      'usefulTips': 'Conseils utiles',
      'historyEmpty': "L'historique est vide",
      'checkFirstPlant': 'Vérifiez votre première plante !',
      'deleteRecord': 'Supprimer l\'enregistrement ?',
      'deleteConfirm': 'Supprimer',
      'cancel': 'Annuler',
      'apiKeyTitle': 'Clé API OpenAI',
      'apiKeyDesc':
          'Entrez votre clé API OpenAI (platform.openai.com). La clé est stockée uniquement sur votre appareil.',
      'apiKeyHint': 'sk-...',
      'save': 'Enregistrer',
      'apiKeySaved': 'Clé API enregistrée',
      'apiKeyEmpty': 'Veuillez entrer une clé API',
      'apiKeyMissing': 'Veuillez d\'abord ajouter une clé API dans les paramètres',
      'goToSettings': 'Paramètres',
      'error': 'Erreur',
      'toxicWarningTitle': 'Attention : plante toxique',
      'toxicTo': 'Dangereuse pour :',
      'toxicCats': 'les chats',
      'toxicDogs': 'les chiens',
      'toxicChildren': 'les enfants',
      'progressTitle': "Comparaison avec l'analyse précédente",
      'progressPrevious': 'Vérification précédente',
      'progressImproved': "La plante s'est améliorée",
      'progressWorsened': "L'état s'est dégradé",
      'progressStable': "L'état est stable",
      'progressMoreProblems': 'Plus de problèmes',
      'progressFewerProblems': 'Moins de problèmes',
      'progressProblems': 'problèmes',
      'askQuestion': 'Poser une question sur cette plante',
      'chatTitle': 'Question sur la plante',
      'chatHint': 'Votre question...',
      'chatSend': 'Envoyer',
      'wateringReminder': "Rappel d'arrosage",
      'wateringReminderSet': 'Rappel défini',
      'wateringReminderCancel': 'Annuler le rappel',
      'wateringReminderDesc': "Il est temps d'arroser",
      'wateringEvery': 'Arroser tous les',
      'wateringDays': 'jours',
      'reminderEnabled': 'Rappel activé',
      'reminderDisabled': 'Rappel désactivé',
      'paywallTitle': 'Accès premium',
      'paywallSubtitle': "Limite d'analyses gratuites atteinte",
      'paywallDesc':
          "Vous avez utilisé 5 analyses gratuites au cours des 30 derniers jours. Abonnez-vous pour continuer.",
      'paywallPrice': "S'abonner — \$4.99/mois",
      'paywallBack': 'Retour',
      'paywallFreeLeft': 'Analyses gratuites restantes :',
      'languageTitle': 'Langue',
      'languageUk': 'Українська',
      'languageEn': 'English',
      'languageEs': 'Español',
      'languageRu': 'Русский',
      'languageDe': 'Deutsch',
      'languageFr': 'Français',
      'deleteAnalysisConfirm': 'Supprimer « {name} » de l\'historique ?',
      'loginSubtitle': 'Diagnostic de plantes par IA',
      'loginWithGoogle': 'Se connecter avec Google',
      'loginPrivacyNote': 'En vous connectant, vous acceptez notre Politique de confidentialité',
      'account': 'Compte',
      'signOutBtn': 'Se déconnecter',
      'signOutTitle': 'Se déconnecter ?',
      'signOutMsg': 'Êtes-vous sûr de vouloir vous déconnecter ?',
      'recWatering': 'Arrosage',
      'recLight': 'Lumière',
      'recTemperature': 'Température',
      'recFertilizer': 'Fertilisant',
      'recAdditional': 'Supplémentaire',
      'notifPermDenied': 'Permission de notification refusée',
      'privacyPolicy': 'Politique de confidentialité',
      'deleteDataBtn': 'Supprimer toutes les données',
      'deleteDataTitle': 'Supprimer toutes les données ?',
      'deleteDataMsg':
          "Tout l'historique d'analyses, les rappels et la clé API seront supprimés de votre appareil. Cette action est irréversible.",
      'deleteDataDone': 'Toutes les données supprimées',
    },
  };

  String get(String key) => _strings[languageCode]?[key] ?? _strings['en']![key] ?? key;

  String get appTitle => get('appTitle');
  String get tabAnalyze => get('tabAnalyze');
  String get tabHistory => get('tabHistory');
  String get settings => get('settings');
  String get analyzeBtn => get('analyzeBtn');
  String get selectOrPhoto => get('selectOrPhoto');
  String get gallery => get('gallery');
  String get fromGallery => get('fromGallery');
  String get camera => get('camera');
  String get takePhoto => get('takePhoto');
  String get tapToSelect => get('tapToSelect');
  String get uploadFromGallery => get('uploadFromGallery');
  String get analyzing => get('analyzing');
  String get analyzingSubtitle => get('analyzingSubtitle');
  String get newAnalysis => get('newAnalysis');
  String get healthy => get('healthy');
  String get needsAttention => get('needsAttention');
  String get problems => get('problems');
  String get careRecommendations => get('careRecommendations');
  String get usefulTips => get('usefulTips');
  String get historyEmpty => get('historyEmpty');
  String get checkFirstPlant => get('checkFirstPlant');
  String get deleteRecord => get('deleteRecord');
  String get deleteConfirm => get('deleteConfirm');
  String get cancel => get('cancel');
  String get apiKeyTitle => get('apiKeyTitle');
  String get apiKeyDesc => get('apiKeyDesc');
  String get apiKeyHint => get('apiKeyHint');
  String get save => get('save');
  String get apiKeySaved => get('apiKeySaved');
  String get apiKeyEmpty => get('apiKeyEmpty');
  String get apiKeyMissing => get('apiKeyMissing');
  String get goToSettings => get('goToSettings');
  String get error => get('error');
  String get toxicWarningTitle => get('toxicWarningTitle');
  String get toxicTo => get('toxicTo');
  String get toxicCats => get('toxicCats');
  String get toxicDogs => get('toxicDogs');
  String get toxicChildren => get('toxicChildren');
  String get progressTitle => get('progressTitle');
  String get progressPrevious => get('progressPrevious');
  String get progressImproved => get('progressImproved');
  String get progressWorsened => get('progressWorsened');
  String get progressStable => get('progressStable');
  String get progressMoreProblems => get('progressMoreProblems');
  String get progressFewerProblems => get('progressFewerProblems');
  String get progressProblems => get('progressProblems');
  String get askQuestion => get('askQuestion');
  String get chatTitle => get('chatTitle');
  String get chatHint => get('chatHint');
  String get chatSend => get('chatSend');
  String get wateringReminder => get('wateringReminder');
  String get wateringReminderSet => get('wateringReminderSet');
  String get wateringReminderCancel => get('wateringReminderCancel');
  String get wateringReminderDesc => get('wateringReminderDesc');
  String get wateringEvery => get('wateringEvery');
  String get wateringDays => get('wateringDays');
  String get reminderEnabled => get('reminderEnabled');
  String get reminderDisabled => get('reminderDisabled');
  String get paywallTitle => get('paywallTitle');
  String get paywallSubtitle => get('paywallSubtitle');
  String get paywallDesc => get('paywallDesc');
  String get paywallPrice => get('paywallPrice');
  String get paywallBack => get('paywallBack');
  String get paywallFreeLeft => get('paywallFreeLeft');
  String get languageTitle => get('languageTitle');
  String get languageUk => get('languageUk');
  String get languageEn => get('languageEn');
  String get languageEs => get('languageEs');
  String get languageRu => get('languageRu');
  String get languageDe => get('languageDe');
  String get languageFr => get('languageFr');
  String get loginSubtitle => get('loginSubtitle');
  String get loginWithGoogle => get('loginWithGoogle');
  String get loginPrivacyNote => get('loginPrivacyNote');
  String get account => get('account');
  String get signOutBtn => get('signOutBtn');
  String get signOutTitle => get('signOutTitle');
  String get signOutMsg => get('signOutMsg');
  String get privacyPolicy => get('privacyPolicy');
  String get deleteDataBtn => get('deleteDataBtn');
  String get deleteDataTitle => get('deleteDataTitle');
  String get deleteDataMsg => get('deleteDataMsg');
  String get deleteDataDone => get('deleteDataDone');
  String get recWatering => get('recWatering');
  String get recLight => get('recLight');
  String get recTemperature => get('recTemperature');
  String get recFertilizer => get('recFertilizer');
  String get recAdditional => get('recAdditional');
  String get notifPermDenied => get('notifPermDenied');

  String deleteAnalysisConfirm(String name) =>
      get('deleteAnalysisConfirm').replaceAll('{name}', name);

  String get aiLanguageName {
    switch (languageCode) {
      case 'uk':
        return 'Ukrainian';
      case 'es':
        return 'Spanish';
      case 'ru':
        return 'Russian';
      case 'de':
        return 'German';
      case 'fr':
        return 'French';
      default:
        return 'English';
    }
  }
}
