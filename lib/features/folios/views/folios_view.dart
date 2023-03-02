import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/folios/folios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoliosView extends StatelessWidget {
  const FoliosView({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>().state;
    final folios = authBloc.folios;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruta de entrega'),
      ),
      body: folios!.isNotEmpty
          ? SingleChildScrollView(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: folios.length,
                itemBuilder: (context, index) {
                  final folio = folios[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FolioItem(folio: folio),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.card_giftcard_outlined),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  folio.numeroFolio.toString(),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                folio.detailDelivery!.ordenEntrega.toString(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.account_circle_outlined),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  folio.detailClient!.nombre.toString(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.pin_drop_outlined),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  folio.detailDelivery!.deliveryLocation!
                                      .distrito
                                      .toString(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'No hay datos de ruta. Contáctate con el administrador',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
    );
  }
}
