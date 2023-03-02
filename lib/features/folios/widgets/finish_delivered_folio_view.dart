import 'dart:io';
import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/folios/bloc/folios_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FinishDeliveredDelivered extends StatefulWidget {
  const FinishDeliveredDelivered({
    super.key,
    required this.idFolio,
    required this.estado,
  });
  final String idFolio;
  final String estado;

  @override
  State<FinishDeliveredDelivered> createState() =>
      _FinishDeliveredDeliveredState();
}

class _FinishDeliveredDeliveredState extends State<FinishDeliveredDelivered> {
  File? customerPhoto;
  File? guidePhoto;
  File? photoOfPlace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Evidencias de entrega',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final picker = ImagePicker();
            final pickedFile = await picker.pickImage(
              source: ImageSource.gallery,
            );
            if (pickedFile != null) {
              setState(() {
                customerPhoto = File.fromUri(Uri(path: pickedFile.path));
              });
            }
          },
          style: ElevatedButton.styleFrom(
            primary: customerPhoto != null ? Colors.green : Colors.grey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.photo),
              SizedBox(width: 10),
              Text('Foto del cliente'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final picker = ImagePicker();
            final pickedFile = await picker.pickImage(
              source: ImageSource.gallery,
            );
            if (pickedFile != null) {
              setState(() {
                guidePhoto = File.fromUri(Uri(path: pickedFile.path));
              });
            }
          },
          style: ElevatedButton.styleFrom(
            primary: guidePhoto != null ? Colors.green : Colors.grey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.photo),
              SizedBox(width: 10),
              Text('Foto de la guía'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final picker = ImagePicker();
            final pickedFile = await picker.pickImage(
              source: ImageSource.gallery,
            );
            if (pickedFile != null) {
              setState(() {
                photoOfPlace = File.fromUri(Uri(path: pickedFile.path));
              });
            }
          },
          style: ElevatedButton.styleFrom(
            primary: photoOfPlace != null ? Colors.green : Colors.grey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.photo),
              SizedBox(width: 10),
              Text('Foto del lugar'),
            ],
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            final authBloc = context.read<AuthBloc>().state;
            final idResponsable = authBloc.user!.idResponsable;

            context.read<FoliosBloc>().add(
                  FinalizeDelivery(
                    customerPhoto: customerPhoto!,
                    guidePhoto: guidePhoto!,
                    photoOfPlace: photoOfPlace!,
                    estado: widget.estado,
                    idFolio: widget.idFolio,
                    idResponsable: idResponsable!,
                  ),
                );
          },
          style: ElevatedButton.styleFrom(
            primary: photoOfPlace != null &&
                    photoOfPlace != null &&
                    photoOfPlace != null
                ? Colors.blue
                : Colors.grey,
          ),
          child: const SizedBox(
            width: double.infinity,
            child: Text(
              'Finalizar Entrega',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
