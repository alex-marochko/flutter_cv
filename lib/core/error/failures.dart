import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class PdfGenerationFailure extends Failure {
  const PdfGenerationFailure({required super.message});
}

class GeneralFailure extends Failure {
  const GeneralFailure({required super.message});
}
