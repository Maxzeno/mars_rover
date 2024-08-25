import 'package:flutter/material.dart';
import 'package:mars_rover/src/constant.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const MyButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(55),
        backgroundColor: kGreyColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kDefaultSpace))),
      ),
      child: Text(
        text,
        style: const TextStyle(color: kWhiteColor),
      ),
    );
  }
}
