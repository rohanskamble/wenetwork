import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Image(

        image:AssetImage("asset/image/wenentworklogo.png",),
      ),
      )
    );
  }
}
