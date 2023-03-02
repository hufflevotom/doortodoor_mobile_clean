import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/features/auth/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormSignIn extends StatefulWidget {
  const FormSignIn({super.key});

  @override
  State<FormSignIn> createState() => _FormSignInState();
}

class _FormSignInState extends State<FormSignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: emailController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: 'Documento',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese su documento';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscureText,
            controller: passwordController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: 'Contraseña',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese su contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.azul_100,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignInBloc>().add(
                        SignUp(
                          documento: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                }
              },
              child: const Text('Ingresar'),
            ),
          ),
        ],
      ),
    );
  }
}
