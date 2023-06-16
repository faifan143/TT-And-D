import 'package:driver/core/constants/AppColors.dart';
import 'package:driver/core/constants/appTheme.dart';
import 'package:flutter/material.dart';

class ReUsableButton extends StatelessWidget {
  ReUsableButton({
    Key? key,
    this.onPressed,
    this.text,
    this.radius,
    this.height,
    this.colour,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String? text;
  double? height = 20;
  double? radius = 20;
  Color? colour;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 4,
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius!),
            color: colour ?? AppColors.buttonColor),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: height!),
        child: Text(
          text!,
          textAlign: TextAlign.center,
          style: arabicTheme.textTheme.bodyText1!
              .copyWith(color: Colors.white)
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
