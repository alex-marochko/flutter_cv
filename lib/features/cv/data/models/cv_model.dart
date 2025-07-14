import 'package:flutter_cv/features/cv/domain/entities/cv.dart';

class CvModel {
  final String nameEn;
  final String nameUa;
  final String position;
  final String location;
  final String phone;
  final String email;

  CvModel({
    required this.nameEn,
    required this.nameUa,
    required this.position,
    required this.location,
    required this.phone,
    required this.email,
  });

  factory CvModel.fromJson(Map<String, dynamic> json) {
    return CvModel(
      nameEn: json['name_en'] ?? '',
      nameUa: json['name_ua'] ?? '',
      position: json['position'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_en': nameEn,
      'name_ua': nameUa,
      'position': position,
      'location': location,
      'phone': phone,
      'email': email,
    };
  }

  /// Converts this data model to a domain entity
  Cv toEntity() {
    return Cv(
      nameEn: nameEn,
      nameUa: nameUa,
      position: position,
      location: location,
      phone: phone,
      email: email,
    );
  }
}