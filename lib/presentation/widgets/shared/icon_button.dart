import 'package:flutter/material.dart';
import 'package:movie_avilatek_app/config/theme/app_theme.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
  });

// Instance of iconButton created for code reuse in the appbars

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                //colors tacken from the apptheme colorList
                colorList[0],
                colorList[1],
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
