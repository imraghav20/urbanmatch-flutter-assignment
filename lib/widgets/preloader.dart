import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Preloader extends StatelessWidget {
  const Preloader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitPouringHourGlassRefined(
        color: Colors.deepPurple,
      ),
    );
  }
}
