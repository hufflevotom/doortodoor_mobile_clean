import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/folios/folios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardHome extends StatelessWidget {
  const CardHome({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>().state;
    final folios = authBloc.folios;

    if (folios!.isEmpty) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (context) => FolioItem(folio: folios.first),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Item(
                text: 'Doc. Identidad:',
                data: folios.first.detailClient?.dni.toString() ?? ' --- ',
              ),
              const SizedBox(height: 10),
              Item(
                text: 'Nombre:',
                data: folios.first.detailClient?.nombre.toString() ?? ' --- ',
              ),
              const SizedBox(height: 10),
              Item(
                text: 'Teléfono:',
                data: folios.first.detailClient?.telefono.toString() ?? ' --- ',
              ),
              const SizedBox(height: 10),
              Item(
                text: 'Distrito:',
                data: folios.first.detailDelivery?.deliveryLocation?.distrito
                        .toString() ??
                    ' --- ',
              ),
              const SizedBox(height: 10),
              Item(
                text: 'Dirección:',
                data:
                    folios.first.detailClient?.direccion.toString() ?? ' --- ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.text,
    required this.data,
  });
  final String text;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            data,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
