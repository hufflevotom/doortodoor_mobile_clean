import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/app/config/routes.dart';
import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/auth/views/views.dart';
import 'package:doortodoor_app/features/home/home.dart';
import 'package:doortodoor_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = AppRoutes.mainNavigatorKey;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case Authenticated:
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              HomeView.route,
              (route) => false,
            );
            break;

          case Unauthenticated:
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              SignInView.route,
              (route) => false,
            );
            break;
        }
      },
      child: MaterialApp(
        title: 'Salvatore App',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: AppColors.naranja_100,
          ),
          fontFamily: 'Quicksand',
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        routes: AppRoutes.routes,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppRoutes.initial,
      ),
    );
  }
}
