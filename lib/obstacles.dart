import 'package:flutter/material.dart';

class Obstacles extends StatelessWidget {

  final size;

  const Obstacles({super.key, this.size});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all( width: 3, color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
