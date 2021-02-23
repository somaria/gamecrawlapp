import 'package:flutter/material.dart';
import 'package:gamecrawlapp/models/post.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final Post post = Get.arguments['post'];

  @override
  void initState() {
    // TODO: implement initState
    runYoutubePlayer();
    super.initState();
    print(post.ytTitle);
    print(post.username);
    print(post.ytid);
    print(post.ytDescription);
    print(post.ytChannelTitle);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  YoutubePlayerController _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: post.ytid,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          controlsVisibleAtStart: true,
          isLive: true,
          mute: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Gamecrawl"),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                player,
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.ytTitle,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        post.ytChannelTitle,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        post.ytDescription,
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
