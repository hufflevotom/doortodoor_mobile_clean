import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/app/widgets/views/info_all.dart';
import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/profile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de sesión'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const InfoAll(
                icon: Icons.account_circle_outlined,
                text: 'Datos del Usuario',
                child: ItemsUser(),
              ),
              const SizedBox(height: 20),
              const InfoAll(
                icon: Icons.directions_car_filled_outlined,
                text: 'Vehículo asignado',
                child: ItemsVehicle(),
              ),
              const SizedBox(height: 20),
              const InfoAll(
                icon: Icons.route_outlined,
                text: 'Ruta',
                child: ItemsRuta(),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.naranja_100,
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(SignOut());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text('Cerrar sesión'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
