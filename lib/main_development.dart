import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:doortodoor_app/app/app.dart';
import 'package:doortodoor_app/app/preferences/preferences.dart';
import 'package:doortodoor_app/bootstrap.dart';
import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/auth/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'dependencies_development.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final _sharedPreferences = await SharedPreferences.getInstance();
  final _preferences = LocalPreferences(_sharedPreferences);

  configDio();

  bootstrap(() => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => authRepository),
          RepositoryProvider(create: (_) => _preferences),
          RepositoryProvider(create: (_) => foliosRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthBloc(
                authRepository,
                _preferences,
                foliosRepository,
              ),
            ),
            BlocProvider(
              create: (_) => SignInBloc(
                authRepository,
                _preferences,
              ),
            ),
          ],
          child: const App(),
        ),
      ));
}
