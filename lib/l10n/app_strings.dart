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
          'Ви використали 5 безкоштовних аналізів цього місяця. Оформіть підписку щоб продовжити.',
      'paywallPrice': 'Підписатися — \$4.99/місяць',
      'paywallBack': 'Повернутися назад',
      'paywallFreeLeft': 'Безкоштовних аналізів залишилось:',
      'languageTitle': 'Мова',
      'languageUk': 'Українська',
      'languageEn': 'English',
      'languageEs': 'Español',
      'deleteAnalysisConfirm': 'Видалити "{name}" з історії?',
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
          'You have used 5 free analyses this month. Subscribe to continue.',
      'paywallPrice': 'Subscribe — \$4.99/month',
      'paywallBack': 'Go back',
      'paywallFreeLeft': 'Free analyses remaining:',
      'languageTitle': 'Language',
      'languageUk': 'Українська',
      'languageEn': 'English',
      'languageEs': 'Español',
      'deleteAnalysisConfirm': 'Delete "{name}" from history?',
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
          'Has usado 5 análisis gratuitos este mes. Suscríbete para continuar.',
      'paywallPrice': 'Suscribirse — \$4.99/mes',
      'paywallBack': 'Volver',
      'paywallFreeLeft': 'Análisis gratuitos restantes:',
      'languageTitle': 'Idioma',
      'languageUk': 'Українська',
      'languageEn': 'English',
      'languageEs': 'Español',
      'deleteAnalysisConfirm': '¿Eliminar "{name}" del historial?',
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

  String deleteAnalysisConfirm(String name) =>
      get('deleteAnalysisConfirm').replaceAll('{name}', name);

  String get aiLanguageName {
    switch (languageCode) {
      case 'uk':
        return 'Ukrainian';
      case 'es':
        return 'Spanish';
      default:
        return 'English';
    }
  }
}
