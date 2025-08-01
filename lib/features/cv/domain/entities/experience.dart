class Experience {
  final int yearFrom;
  final int yearTo;
  final String position;
  final String company;
  final String reference;
  final String description; // Use \n for bullet points

  Experience({
    required this.yearFrom,
    required this.yearTo,
    required this.position,
    required this.company,
    required this.reference,
    required this.description,
  });
}
