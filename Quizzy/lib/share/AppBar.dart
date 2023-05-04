import 'package:flutter/material.dart';

import '../themes/app_text_styles.dart';

class AppBarOveright extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarOveright(this.title, {Key? key}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyles.titleHome),
      elevation: 0,
      leading: Icon(Icons.menu),
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.purple],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );
  }
}
