import 'package:doortodoor_app/features/auth/views/views.dart';
import 'package:doortodoor_app/features/home/home.dart';
import 'package:doortodoor_app/features/splash/splash.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initial = SplashView.route;
  static final mainNavigatorKey = GlobalKey<NavigatorState>();
  static Map<String, WidgetBuilder> get routes => {
        SplashView.route: (_) => const SplashView(),
        HomeView.route: (_) => const HomeView(),
        SignInView.route: (_) => const SignInView(),
      };
}
