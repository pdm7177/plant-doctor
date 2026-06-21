class PlantAnalysis {
  final String id;
  final String imagePath;
  final String plantName;
  final String healthStatus;
  final String healthDescription;
  final List<String> problems;
  final List<String> recommendations;
  final List<String> careTips;
  final DateTime date;
  final bool? isToxic;
  final List<String>? toxicTo;
  final String? toxicityDetails;
  final int? wateringIntervalDays;

  const PlantAnalysis({
    required this.id,
    required this.imagePath,
    required this.plantName,
    required this.healthStatus,
    required this.healthDescription,
    required this.problems,
    required this.recommendations,
    required this.careTips,
    required this.date,
    this.isToxic,
    this.toxicTo,
    this.toxicityDetails,
    this.wateringIntervalDays,
  });

  bool get isHealthy => healthStatus == 'healthy';

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': imagePath,
        'plantName': plantName,
        'healthStatus': healthStatus,
        'healthDescription': healthDescription,
        'problems': problems,
        'recommendations': recommendations,
        'careTips': careTips,
        'date': date.toIso8601String(),
        if (isToxic != null) 'isToxic': isToxic,
        if (toxicTo != null) 'toxicTo': toxicTo,
        if (toxicityDetails != null) 'toxicityDetails': toxicityDetails,
        if (wateringIntervalDays != null) 'wateringIntervalDays': wateringIntervalDays,
      };

  factory PlantAnalysis.fromJson(Map<String, dynamic> json) => PlantAnalysis(
        id: json['id'] as String,
        imagePath: json['imagePath'] as String,
        plantName: json['plantName'] as String,
        healthStatus: json['healthStatus'] as String,
        healthDescription: json['healthDescription'] as String,
        problems: List<String>.from(json['problems'] as List),
        recommendations: List<String>.from(json['recommendations'] as List),
        careTips: List<String>.from((json['careTips'] as List?) ?? []),
        date: DateTime.parse(json['date'] as String),
        isToxic: json['isToxic'] as bool?,
        toxicTo: json['toxicTo'] != null
            ? List<String>.from(json['toxicTo'] as List)
            : null,
        toxicityDetails: json['toxicityDetails'] as String?,
        wateringIntervalDays: json['wateringIntervalDays'] as int?,
      );
}
