import 'package:application_a/features/login/bloc/login_bloc.dart';
import 'package:application_a/features/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key, required this.appBar});

  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    void onLogout() {
      context.read<LoginBloc>().add(
            RemoveToken(),
          );

      Navigator.pushAndRemoveUntil<void>(
        context,
        LoginPage.route(),
        (route) => false,
      );
    }

    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const Text(
        'รายการพัสดุ',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: onLogout,
          color: Colors.white,
        ),
      ],
      backgroundColor: Colors.black,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
