import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final Widget leading;
  final void Function()? onTap;

  const DrawerTile({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16.0),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.dmSerifText(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 14,
          ),
        ),
        leading: leading,
        onTap: onTap,
      ),
    );
  }
}
