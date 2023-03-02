// ignore_for_file: unused_element

import 'package:domain/domain.dart';
import 'package:doortodoor_app/app/snackbars/snackbars.dart';
import 'package:doortodoor_app/app/widgets/commons/overlay_loader.dart';
import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/folios/bloc/folios_bloc.dart';
import 'package:doortodoor_app/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportFolioView extends StatelessWidget {
  const ReportFolioView({
    super.key,
    required this.id,
  });
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoliosBloc(context.read<FoliosRepository>()),
      child: _ReportFolioView(id: id),
    );
  }
}

class _ReportFolioView extends StatefulWidget {
  const _ReportFolioView({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<_ReportFolioView> createState() => _ReportFolioViewState();
}

class _ReportFolioViewState extends State<_ReportFolioView> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar problema'),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Motivo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: TextFormField(
                  minLines: 6,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Describa el problema',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un motivo';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final user = context.read<AuthBloc>().state.user;
                      final idResponsable = user?.idResponsable ?? '0';

                      context.read<FoliosBloc>().add(
                            ReportProblem(
                              justification: _controller.text,
                              idFolio: widget.id,
                              idResponsable: idResponsable,
                            ),
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: const Text('Registrar problema'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
