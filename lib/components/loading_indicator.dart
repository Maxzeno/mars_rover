import 'package:flutter/material.dart';
import 'package:mars_rover/src/constant.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: kWhiteColor,
      ),
    );
  }
}
