import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsVehicle extends StatelessWidget {
  const ItemsVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>().state;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Modelo:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                authBloc.user?.vehicle?.modelo ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Placa:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                authBloc.user?.vehicle?.placa ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
