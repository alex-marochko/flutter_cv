import 'package:flutter_cv/features/cv/domain/entities/experience.dart';

class Cv {
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
  final List<Experience> experience;

  Cv({
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
    required this.experience,
  });
}