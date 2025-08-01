import 'package:flutter_cv/features/cv/domain/entities/experience.dart';
import 'package:flutter_cv/features/cv/domain/enums/skill_category.dart';

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
  final String copyright;
  final String pdfFooter;
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
    required this.copyright,
    required this.pdfFooter,
    required this.experience,
  });

  Map<SkillCategory, String> get skills => {
    SkillCategory.general: skillsGeneral,
    SkillCategory.flutter: skillsFlutter,
    SkillCategory.android: skillsAndroid,
    SkillCategory.languages: skillsLanguages,
    SkillCategory.additional: skillsAdditional,
  };
}
