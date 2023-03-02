// ignore_for_file: unused_local_variable

import 'package:domain/domain.dart';
import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/app/utils/functions.dart';
import 'package:doortodoor_app/app/widgets/views/info_all.dart';
import 'package:doortodoor_app/features/folios/views/report_folio_view.dart';
import 'package:doortodoor_app/features/folios/views/views.dart';
import 'package:flutter/material.dart';

class FolioItem extends StatelessWidget {
  const FolioItem({super.key, required this.folio});
  final Folios folio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Folio'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    InfoAll(
                      icon: Icons.card_giftcard_outlined,
                      text: 'Información del folio',
                      child: InfoFolio(folio: folio),
                    ),
                    const SizedBox(height: 30),
                    InfoAll(
                      icon: Icons.account_circle_outlined,
                      text: 'Datos del Cliente',
                      child: InfoClient(folio: folio),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              width: MediaQuery.of(context).size.width - 160,
              left: 80,
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.verde_100,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () async {
                    final phone =
                        folio.detailClient?.telefono!.split('/').first;
                    if (phone != '') {
                      await makePhoneCall(phone!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No se puede realizar la llamada'),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.call_end_outlined),
                      SizedBox(width: 10),
                      Text('Llamar'),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 90,
              width: MediaQuery.of(context).size.width - 160,
              left: 80,
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.azul_100,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () => Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinishFolioView(id: folio.id!),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check_circle_outline_rounded),
                      SizedBox(width: 10),
                      Text('Terminar la entrega'),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              width: MediaQuery.of(context).size.width - 160,
              left: 80,
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.rojo_100,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () => Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportFolioView(id: folio.id!),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error_outline_rounded),
                      SizedBox(width: 10),
                      Text('Reportar problema'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoFolio extends StatelessWidget {
  const InfoFolio({super.key, required this.folio});
  final Folios folio;

  @override
  Widget build(BuildContext context) {
    final inicio = folio.detailDelivery?.visitingHours?.inicioVisita
            .toString()
            .padLeft(4, '0') ??
        ' --- ';

    final fin = folio.detailDelivery?.visitingHours?.finvisita
            .toString()
            .padLeft(4, '0') ??
        ' --- ';

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Descripción:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                folio.detailRequest?.descripcionPedido.toString() ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fecha:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                folio.detailDelivery?.fechaEntrega?.split('T').first ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Local:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                folio.localSourcing?.localAbastecimiento ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inicio',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                '${inicio.substring(0, 2)}:${inicio.substring(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fin:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                '${fin.substring(0, 2)}:${fin.substring(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class InfoClient extends StatelessWidget {
  const InfoClient({super.key, required this.folio});
  final Folios folio;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Doc. Identidad:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                folio.detailClient?.dni ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nombre:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                folio.detailClient?.nombre ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Teléfono:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                folio.detailClient?.telefono ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Distrito: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                folio.detailDelivery?.deliveryLocation?.distrito ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dirección:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                folio.detailClient?.direccion ?? ' --- ',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
