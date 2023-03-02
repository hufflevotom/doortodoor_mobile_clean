import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowErrorHome extends StatelessWidget {
  const ShowErrorHome({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    if (authBloc.state.alert != '' && authBloc.state.alert != null) {
      return Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.red,
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  authBloc.state.alert!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(
                Icons.cancel_presentation_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                context.read<AuthBloc>().add(AlertCleared());
              },
            ),
          ),
        ],
      );
    }

    return SizedBox();
  }
}
