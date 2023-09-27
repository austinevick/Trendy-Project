import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;
  final double? textSize;
  final Color? textColor;
  final BorderSide? borderSide;
  final AlignmentGeometry textAlign;
  final double? radius;
  final bool isLoading;

  const CustomButton(
      {Key? key,
      this.onPressed,
      this.textColor,
      this.text,
      this.color,
      this.child,
      this.width = double.infinity,
      this.height,
      this.borderSide,
      this.radius = 50,
      this.isLoading = false,
      this.textSize,
      this.textAlign = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading ? true : false,
      child: SizedBox(
        height: height ?? 54,
        width: width,
        child: MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          onPressed: onPressed,
          color: color,
          disabledColor: Colors.grey,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: borderSide ?? BorderSide.none),
          child: child ??
              Align(
                alignment: textAlign,
                child: Text(text!,
                    style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: textSize ?? 17,
                        fontWeight: FontWeight.w600)),
              ),
        ),
      ),
    );
  }
}
