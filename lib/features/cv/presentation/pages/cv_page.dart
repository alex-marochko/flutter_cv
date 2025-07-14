import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My CV')),
      body: Center(
        child: Card(
          child: BlocBuilder<CvCubit, CvState>(
            builder: (context, state) {
              if (state is CvLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CvLoaded) {
                final cv = state.cv;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(cv.nameEn, style: Theme.of(context).textTheme.headlineMedium),
                      Text(cv.position, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16),
                      Text('Location: ${cv.location}'),
                      Text('Phone: ${cv.phone}'),
                      Text('Email: ${cv.email}'),
                    ],
                  ),
                );
              } else if (state is CvError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}