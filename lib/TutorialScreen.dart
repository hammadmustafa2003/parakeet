import 'package:flutter/material.dart';
import 'package:parakeet/tutorialTopics.dart';
import 'package:video_player/video_player.dart';
import 'models/learner.dart';

class TutorialScreen extends StatefulWidget {
  final String topic;
  final Learner learner;
  TutorialScreen({required this.topic, required this.learner});

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        setState(() {});
      });

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                //TODO: Add profile page
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TutorialTopicPage(learner: widget.learner,)),
                );
              },
            ),

            Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/icon.png',
                    fit: BoxFit.contain,
                    height: 30,
                  ),
                  const Padding(
                      padding: EdgeInsets.only (right: 6, top: 10),
                      // padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'arekeet',
                        style: TextStyle( color: Colors.blue, fontSize: 30, fontFamily: 'font1') ,
                      )
                  )
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.person_rounded,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                //TODO: Add profile page
              },
            ),
          ]
        ),
      ),

      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          AspectRatio(
            aspectRatio: 16/9,
            child:
            _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : const Center(child: CircularProgressIndicator()),
          ),
          VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                playedColor: Colors.red,
                bufferedColor: Colors.grey,
                backgroundColor: Colors.black,
              ),
          ),
          Center(
            child: TextButton(
              onPressed: _controller.value.isPlaying
                  ? _controller.pause
                  : _controller.play,
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
          Padding(
            padding : const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              widget.topic,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ]
      ),
    );
  }


}
