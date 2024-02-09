import 'dart:io';

import 'package:application_a/features/home/view/home_page.dart';
import 'package:application_a/features/login/bloc/login_bloc.dart';
import 'package:application_a/features/login/view/login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() {
    if (Platform.isAndroid) {
      // Android-specific code
      return PageTransition<void>(
        type: PageTransitionType.rightToLeft,
        child: const LoginPage(),
      );
    } else {
      // iOS-specific code
      return MaterialPageRoute<void>(
        builder: (_) => const LoginPage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      context.read<LoginBloc>().add(
            LoginSubmited(),
          );
    }

    return Scaffold(
      key: const Key('LoginPage'),
      appBar: LoginHeader(appBar: AppBar()),
      // resizeToAvoidBottomInset: false,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.token != '') {
            Navigator.pushAndRemoveUntil<void>(
              context,
              HomePage.route(),
              (route) => false,
            );
          }

          if (state.errorMessage != '') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
            context.read<LoginBloc>().add(
                  RemoveErrorMessage(),
                );
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '0927043617',
                  labelText: 'เบอร์โทรศัพท์',
                ),
                onChanged: (value) {
                  context.read<LoginBloc>().add(
                        ChangePhone(
                          phone: value,
                        ),
                      );
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: '',
                  labelText: 'รหัสผ่าน',
                ),
                onChanged: (value) {
                  context.read<LoginBloc>().add(
                        ChangePassword(
                          password: value,
                        ),
                      );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  onSubmit();
                },
                child: const Text('เข้าสู่ระบบ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
