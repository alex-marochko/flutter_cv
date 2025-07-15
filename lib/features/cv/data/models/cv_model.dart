import 'package:flutter_cv/features/cv/data/models/experience_model.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';

class CvModel {
  final String nameEn;
  final String nameUa;
  final String position;
  final String location;
  final String phone;
  final String email;
  final String telegram;
  final String linkedin;
  final String github;
  final String stackoverflow;
  final String skillsGeneral;
  final String skillsFlutter;
  final String skillsAndroid;
  final String skillsLanguages;
  final String skillsAdditional;
  final String education;
  final List<ExperienceModel> experienceModels;

  CvModel({
    required this.nameEn,
    required this.nameUa,
    required this.position,
    required this.location,
    required this.phone,
    required this.email,
    required this.telegram,
    required this.linkedin,
    required this.github,
    required this.stackoverflow,
    required this.skillsGeneral,
    required this.skillsFlutter,
    required this.skillsAndroid,
    required this.skillsLanguages,
    required this.skillsAdditional,
    required this.education,
    required this.experienceModels,
  });

  factory CvModel.fromJson(
      Map<String, dynamic> json,
      List<ExperienceModel> experienceModels,
      ) {
    return CvModel(
      nameEn: json['name_en'] ?? '',
      nameUa: json['name_ua'] ?? '',
      position: json['position'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      telegram: json['telegram'] ?? '',
      linkedin: json['linkedin'] ?? '',
      github: json['github'] ?? '',
      stackoverflow: json['stackoverflow'] ?? '',
      skillsGeneral: json['skills_general'] ?? '',
      skillsFlutter: json['skills_flutter'] ?? '',
      skillsAndroid: json['skills_android'] ?? '',
      skillsLanguages: json['skills_languages'] ?? '',
      skillsAdditional: json['skills_additional'] ?? '',
      education: json['education'] ?? '',
      experienceModels: experienceModels,
    );
  }

  Cv toEntity() {
    return Cv(
      nameEn: nameEn,
      nameUa: nameUa,
      position: position,
      location: location,
      phone: phone,
      email: email,
      telegram: telegram,
      linkedin: linkedin,
      github: github,
      stackoverflow: stackoverflow,
      skillsGeneral: skillsGeneral,
      skillsFlutter: skillsFlutter,
      skillsAndroid: skillsAndroid,
      skillsLanguages: skillsLanguages,
      skillsAdditional: skillsAdditional,
      education: education,
      experience: experienceModels.map((e) => e.toEntity()).toList(),
    );
  }
}