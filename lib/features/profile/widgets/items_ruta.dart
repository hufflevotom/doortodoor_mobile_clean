import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ItemsRuta extends StatelessWidget {
  const ItemsRuta({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>().state;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ruta:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                authBloc.user?.ruta ?? '0',
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
