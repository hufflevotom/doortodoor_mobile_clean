import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/features/folios/folios.dart';
import 'package:flutter/material.dart';

class ListFoliosHome extends StatelessWidget {
  const ListFoliosHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
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
          MaterialPageRoute(builder: (context) => const FoliosView()),
        ),
        icon: const Icon(
          Icons.alt_route_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
