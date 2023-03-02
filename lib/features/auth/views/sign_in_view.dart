import 'package:doortodoor_app/app/config/app_colors.dart';
import 'package:doortodoor_app/app/snackbars/error_snackbars.dart';
import 'package:doortodoor_app/app/widgets/commons/overlay_loader.dart';
import 'package:doortodoor_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:doortodoor_app/features/auth/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:doortodoor_app/features/auth/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const String route = 'sign_in';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              OverlayLoader.show(context);
            } else {
              OverlayLoader.hide();
              if (state is SignUpFailure) {
                ErrorSnackbar.show(context, state.error);
              } else {
                context.read<AuthBloc>().add(RecoverSession());
              }
            }
          },
          builder: (context, state) {
            return Container(
              color: AppColors.azul_100,
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Container(
                  width: 400,
                  height: 400,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo/logo.png',
                            width: 200,
                          ),
                          const SizedBox(height: 20),
                          const FormSignIn(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
