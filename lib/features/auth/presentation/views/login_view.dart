import 'package:elmohtaref/core/components/widgets/custom_modal_hub.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/login_form.dart';
import 'widgets/welcome_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.login),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return CustomModelProgressIndecator(
            inAsyncCall: state is SendOtpLoadingState,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  WelcomeWidget(
                    text: context.loginOrRegister,
                    decription: context.loginToAccessData,
                  ),
                  LoginForm(),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
