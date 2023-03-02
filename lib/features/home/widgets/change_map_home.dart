import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/features/home/bloc/maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeMapHome extends StatelessWidget {
  const ChangeMapHome({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: use_decorated_box
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.azul_100,
            AppColors.azul_100,
          ],
        ),
      ),
      child: IconButton(
        constraints: const BoxConstraints(
          maxHeight: 40,
          maxWidth: 40,
        ),
        onPressed: () => context.read<MapsBloc>().add(const ChangeThemeMap()),
        icon: const Icon(
          Icons.map_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
