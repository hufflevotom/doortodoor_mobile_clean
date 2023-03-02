import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/folios/bloc/folios_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinishUnDeliveredDelivered extends StatefulWidget {
  const FinishUnDeliveredDelivered({
    super.key,
    required this.idFolio,
    required this.estado,
  });
  final String idFolio;
  final String estado;

  @override
  State<FinishUnDeliveredDelivered> createState() =>
      _FinishUnDeliveredDeliveredState();
}

class _FinishUnDeliveredDeliveredState
    extends State<FinishUnDeliveredDelivered> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Justificación de entrega',
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
                      FinishDeliveryWithJustification(
                        justification: _controller.text,
                        idFolio: widget.idFolio,
                        idResponsable: idResponsable,
                        estado: widget.estado,
                      ),
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            child: const Text('Finalizar la entrega'),
          ),
        ),
      ],
    );
  }
}
