import 'dart:typed_data';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/domain/entities/experience.dart';
import 'package:flutter_cv/features/pdf/data/pdf_generator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCv extends Mock implements Cv {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PdfGeneratorService pdfGeneratorService;
  late MockCv mockCv;

  setUp(() {
    pdfGeneratorService = PdfGeneratorService();
    mockCv = MockCv();
  });

  // A dummy CV data for testing
  final testCv = Cv(
    nameEn: 'Test Name',
    nameUa: 'Тестове Ім\'я',
    position: 'Test Position',
    location: 'Test Location',
    phone: '123456789',
    email: 'test@example.com',
    linkedin: 'linkedin.com',
    telegram: 'telegram.me',
    github: 'github.com',
    stackoverflow: 'stackoverflow.com',
    skillsGeneral: 'Test General',
    skillsFlutter: 'Test Flutter',
    skillsAndroid: 'Test Android',
    skillsLanguages: 'Test Languages',
    skillsAdditional: 'Test Additional',
    education: 'Test Education',
    experience: [
      Experience(
        yearFrom: 2022,
        yearTo: 2023,
        position: 'Test Position',
        company: 'Test Company',
        description: 'Test Description',
        reference: 'test.com',
      )
    ],
  );

  testWidgets('generateCvPdf should return a non-empty Uint8List for valid Cv data',
      (WidgetTester tester) async {
    // Pumping a MaterialApp and waiting for it to settle is the most robust way
    // to ensure the asset bundle is ready.
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    await tester.pumpAndSettle();

    // Arrange
    when(() => mockCv.nameEn).thenReturn(testCv.nameEn);
    when(() => mockCv.nameUa).thenReturn(testCv.nameUa);
    when(() => mockCv.position).thenReturn(testCv.position);
    when(() => mockCv.location).thenReturn(testCv.location);
    when(() => mockCv.phone).thenReturn(testCv.phone);
    when(() => mockCv.email).thenReturn(testCv.email);
    when(() => mockCv.linkedin).thenReturn(testCv.linkedin);
    when(() => mockCv.telegram).thenReturn(testCv.telegram);
    when(() => mockCv.github).thenReturn(testCv.github);
    when(() => mockCv.stackoverflow).thenReturn(testCv.stackoverflow);
    when(() => mockCv.experience).thenReturn(testCv.experience);
    when(() => mockCv.skills).thenReturn(testCv.skills);
    when(() => mockCv.education).thenReturn(testCv.education);

    // Act
    final result = await pdfGeneratorService.generateCvPdf(mockCv);

    // Assert
    expect(result, isA<Uint8List>());
    expect(result, isNotEmpty);
  });
}