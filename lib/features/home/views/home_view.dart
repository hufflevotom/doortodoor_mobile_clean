import 'dart:developer';

import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/app/widgets/commons/overlay_loader.dart';
import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/home/bloc/maps_bloc.dart';
import 'package:doortodoor_app/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String route = 'home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MapsBloc(context.read<AuthBloc>())..add(const HandlePermissionGPS()),
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.naranja_100.withOpacity(0.7),
        ),
        child: BlocConsumer<MapsBloc, MapsState>(
          listener: (context, state) {
            log('ESTATE 1: ${state.runtimeType}');
            if (state is MapsLoading) {
              OverlayLoader.show(context);
            } else {
              OverlayLoader.hide();
            }
          },
          builder: (context, state) {
            print('ESTATE 2: ${state.runtimeType}');
            log('ESTATE 2: ${state.runtimeType}');

            switch (state.runtimeType) {
              case MapsGPSDenied:
                return const MapGpsDenied();

              case MapsGPSSuccess:
                return const MapGpsSuccess();

              case MapsPermissionGranted:
                return const MapsPermissionGrantde();

              case ChangeThemeMapState:
                return const MapsPermissionGrantde();
            }

            return const MapDefault();
          },
        ),
      ),
    );
  }
}
