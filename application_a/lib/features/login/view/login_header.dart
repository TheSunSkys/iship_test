import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget implements PreferredSizeWidget {
  const LoginHeader({super.key, required this.appBar});

  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const Text(
        'เข้าสู่ระบบ',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
