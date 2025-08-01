import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/core/theme/cubit/theme_cubit.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(
          themeCubit.state == ThemeMode.dark
              ? Icons.light_mode
              : Icons.dark_mode,
        ),
        onPressed: () => themeCubit.toggleTheme(),
      ),
    );
  }
}
