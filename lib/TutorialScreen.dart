import 'package:flutter/material.dart';
import 'package:parakeet/profile.dart';
import 'package:parakeet/tutorialTopics.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'models/learner.dart';
import 'services/database.dart';
import 'loading.dart';


class TutorialScreen extends StatefulWidget {
  final String topic;
  final Learner learner;
  TutorialScreen({required this.topic, required this.learner});

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  bool loading = false;
  late YoutubePlayerController _controller;
  Database db = Database();

  Future<void> getVideoId() async{
    setState(() {
      loading = true;
    });
    String retVal = await db.getTutorialLink(widget.topic);
    await db.saveTutorialHistory(widget.learner.username, widget.topic);

    _controller = YoutubePlayerController(
        initialVideoId:retVal,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          showLiveFullscreenButton: false,
        ),
    );

    if (context.mounted) {
      setState(() {
        loading = false;
      });
    }
  }
  @override
  void initState(){
    getVideoId();
    super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return loading ? Loading() :
      YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
            },
          ),
          builder: (context, player) =>
        Scaffold(
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        ProfilePage(learner: widget.learner,)),
                  );
                }
              ),
            ]
          ),
        ),

        body:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              AspectRatio(
                aspectRatio: 16/9,
                child:
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    print('Player is ready.');
                  },
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
        ),
      ),
    );
  }


}
