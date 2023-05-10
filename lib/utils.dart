import 'package:flutter/material.dart';
import 'package:toto_android/board.dart';
import 'package:toto_android/colors.dart';
import 'textstyles.dart';
import 'package:flutter_svg/svg.dart';

class TotoUtils {
  static Padding getHeader(
      BuildContext context, String destinationName, StatefulWidget sw) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: const Icon(
              Icons.keyboard_backspace_sharp,
              color: TotoColors.primary,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardPage(),
              ),
            ),
          ),
          SvgPicture.asset('assets/logo.svg', height: 20),
          InkWell(
            child: Text(
              destinationName,
              style: TotoTextStyles.labelMedium(context),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => sw,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Positioned buildAccessButton(
      BuildContext context, String text, Function function) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: MaterialButton(
          onPressed: () => null,
          color: TotoColors.primary,
          child: Text(
            text,
            style: TotoTextStyles.labelLarge(context),
          ),
        ),
      ),
    );
  }
}
