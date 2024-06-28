import 'package:flappy_bird/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyLoading extends StatefulWidget {
  @override
  _MyLoadingState createState() => _MyLoadingState();
}

class _MyLoadingState extends State<MyLoading> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Image.asset(
          'lib/images/loading.png', // Change this to the path of your image
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        // Positioned widget for the second image
        Positioned(
        bottom: 0, // Adjust the position as needed
        left: 0,
    right: 0,
    child: Center(
    child: Image.asset(
    'lib/images/loadingVideo.gif', // Change this to the path of your image
    fit: BoxFit.cover,
    height: 100,
        )
    )
        )
      ],
    );
  }
  void initState() {
    super.initState();

    // Add a delay of 10 seconds and then navigate to the homepage
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace Homepage with your actual homepage widget
      );
    });
  }
}
