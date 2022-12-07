import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //video Controller
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/Student.mp4',
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);
    _playVideo();
  }

  void _playVideo() async {
    //Playing video
    _controller.play();
    //add delay till video is complice
    await Future.delayed(const Duration(seconds: 5));
    //Navigating to home screen
    Navigator.pushNamed(context, '/type_user');
  }

  @override
  void dipose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
    );
  }
}
