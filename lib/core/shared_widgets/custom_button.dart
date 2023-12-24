import 'package:flutter/material.dart';

class CustomButton extends ElevatedButton {
  CustomButton({
    super.key,
    required Widget child,
    bool disabled = false,
    required VoidCallback? onPressed,
    Color? color,
    Color? textColor,
    Size? maximumSize,
    Size? minimumSize,
  }) : super(
          onPressed: onPressed,
          child: DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 14),
            child: child,
          ),
          style: ElevatedButton.styleFrom(
              maximumSize: maximumSize,
              minimumSize: minimumSize,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              elevation: 0,
              backgroundColor: color,
              foregroundColor: textColor,
              disabledBackgroundColor: Colors.grey,
              disabledForegroundColor: Colors.white),
        );
}
