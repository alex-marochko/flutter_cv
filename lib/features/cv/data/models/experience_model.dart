import 'package:flutter_cv/features/cv/domain/entities/experience.dart';

class ExperienceModel {
  final int yearFrom;
  final int yearTo;
  final String position;
  final String company;
  final String reference;
  final String description;

  ExperienceModel({
    required this.yearFrom,
    required this.yearTo,
    required this.position,
    required this.company,
    required this.reference,
    required this.description,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      yearFrom: int.tryParse(json['year_from'] ?? '') ?? 0,
      yearTo: int.tryParse(json['year_to'] ?? '') ?? 0,
      position: json['position'] ?? '',
      company: json['company'] ?? '',
      reference: json['reference'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Experience toEntity() {
    return Experience(
      yearFrom: yearFrom,
      yearTo: yearTo,
      position: position,
      company: company,
      reference: reference,
      description: description,
    );
  }
}
