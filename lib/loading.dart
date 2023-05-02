import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(240, 255, 255, 1),
      child: const Center(
        child: SpinKitThreeBounce(
          color: Colors.blue,
          size: 70.0,
        ),
      ),
    );
  }
}