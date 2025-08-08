import 'package:equatable/equatable.dart';
import 'package:flutter_cv/core/error/failures.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';

abstract class CvState extends Equatable {
  const CvState();

  @override
  List<Object?> get props => [];
}

class CvInitial extends CvState {}

class CvLoading extends CvState {}

class CvLoaded extends CvState {
  final Cv cv;

  const CvLoaded(this.cv);

  @override
  List<Object?> get props => [cv];
}

class CvError extends CvState {
  final Failure failure;

  const CvError(this.failure);

  @override
  List<Object?> get props => [failure];
}
