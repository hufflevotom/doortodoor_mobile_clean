import 'package:doortodoor_app/features/home/home.dart';
import 'package:flutter/material.dart';

class MapsPermissionGrantde extends StatelessWidget {
  const MapsPermissionGrantde({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: const [
          MapHome(),
          Positioned(top: 0, right: 0, child: ListFoliosHome()),
          Positioned(top: 0, left: 0, child: ProfileHome()),
          Positioned(top: 60, right: 10, child: ChangeMapHome()),
          Positioned(bottom: 0, left: 0, right: 0, child: CardHome()),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ShowErrorHome(),
          )
        ],
      ),
    );
  }
}
