// ignore_for_file: unused_element

import 'package:domain/domain.dart';
import 'package:doortodoor_app/app/snackbars/snackbars.dart';
import 'package:doortodoor_app/app/widgets/commons/overlay_loader.dart';
import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/folios/bloc/folios_bloc.dart';
import 'package:doortodoor_app/features/folios/folios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinishFolioView extends StatelessWidget {
  const FinishFolioView({
    super.key,
    required this.id,
  });
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoliosBloc(context.read<FoliosRepository>()),
      child: _FinishFolioView(id: id),
    );
  }
}

class _FinishFolioView extends StatefulWidget {
  const _FinishFolioView({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<_FinishFolioView> createState() => _FinishFolioViewState();
}

class _FinishFolioViewState extends State<_FinishFolioView> {
  String estado = '638d0c4d9a3096d13d7e2c1e';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terminar la entrega'),
      ),
      body: BlocListener<FoliosBloc, FoliosState>(
        listener: (context, state) {
          if (state is FoliosLoading) {
            OverlayLoader.show(context);
          } else {
            OverlayLoader.hide();
            if (state is FoliosError) {
              ErrorSnackbar.show(context, state.message);
            } else {
              context.read<AuthBloc>().add(RecoverSession());
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Estado de la entrega',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButton(
                value: estado,
                underline: Container(),
                isExpanded: true,
                hint: const Text('Seleccione '),
                items: const [
                  DropdownMenuItem(
                    value: '638d0c4d9a3096d13d7e2c1e',
                    child: Text('Entregado'),
                  ),
                  DropdownMenuItem(
                    value: '638d0c479a3096d13d7e2c1c',
                    child: Text('No entregado'),
                  ),
                  DropdownMenuItem(
                    value: '638d0c3e9a3096d13d7e2c1a',
                    child: Text('No cargado'),
                  ),
                ],
                onChanged: (val) {
                  setState(() {
                    estado = val.toString();
                  });
                },
              ),
              if (estado == '638d0c4d9a3096d13d7e2c1e')
                FinishDeliveredDelivered(
                  idFolio: widget.id,
                  estado: '638d0c4d9a3096d13d7e2c1e',
                ),
              if (estado == '638d0c479a3096d13d7e2c1c')
                FinishUnDeliveredDelivered(
                  idFolio: widget.id,
                  estado: '638d0c479a3096d13d7e2c1c',
                ),
              if (estado == '638d0c3e9a3096d13d7e2c1a')
                FinishUnDeliveredDelivered(
                  idFolio: widget.id,
                  estado: '638d0c3e9a3096d13d7e2c1a',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
