import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/features/profile/profile.dart';
import 'package:flutter/material.dart';

class ProfileHome extends StatelessWidget {
  const ProfileHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(25),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.naranja_100,
            AppColors.naranja_100,
          ],
        ),
      ),
      child: IconButton(
        onPressed: () => Navigator.push<void>(
          context,
          MaterialPageRoute(builder: (context) => const ProfileView()),
        ),
        icon: const Icon(
          Icons.account_circle_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
