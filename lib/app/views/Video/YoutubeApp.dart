import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyecto_prueba_1/app/controllers/LrsController.dart';
import 'package:proyecto_prueba_1/app/utils/LrsUtils.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeApp extends StatefulWidget {
  const YoutubeApp({Key? key}) : super(key: key);

  @override
  State<YoutubeApp> createState() => _YoutubeAppState();
}

class _YoutubeAppState extends State<YoutubeApp> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );
    _controller.loadVideo("https://www.youtube.com/watch?v=KR1LmjNT8FM");
    //Stream para capturar cuando se pausa o reproduce el video
    _controller.stream.listen((event) {
      eventCapturer(event);
    });
  }

  void eventCapturer(controller) {
    switch (controller.playerState) {
      case PlayerState.playing:
        pausePlay("Play", "WatchTemplateVideo", _controller);
        break;
      case PlayerState.ended:
        pausePlay("Finish", "WatchTemplateVideo", _controller);
        break;
      case PlayerState.paused:
        pausePlay("Pause", "WatchTemplateVideo", _controller);
        break;
      default:
        break;
    }
  }

  void pausePlay(
      String verb, String activity, YoutubePlayerController controller) async {
    String url = "";
    await controller.videoUrl.then((value) => url = value);
    LrsController.captureRecordResult(
        LrsUtils().buildVerb("en-US", verb),
        LrsUtils.templateAgentInstance(),
        LrsUtils().buildActivity(activity),
        controller,
        url);
  }

  Widget oneVideo(BuildContext context, double heigth, double width) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: heigth,
          width: width,
          child: YoutubePlayer(
            controller: _controller,
            backgroundColor: Colors.black,
          ),
        ),
      ],
    ));
  }

  Row optionButtons(BuildContext context) {
    return Row(
      children: [
        YoutubeValueBuilder(
          builder: (context, value) {
            return IconButton(
              icon: Icon(
                value.playerState == PlayerState.playing
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: () {
                if (value.playerState == PlayerState.playing) {
                  context.ytController.pauseVideo();
                  pausePlay(
                      "Pause", "WatchTemplateVideo", context.ytController);
                } else {
                  context.ytController.playVideo();
                  pausePlay("Play", "WatchTemplateVideo", context.ytController);
                }
              },
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.of(context).size.height * 0.7;
    double width = MediaQuery.of(context).size.width * 0.7;
    return YoutubePlayerScaffold(
        controller: _controller,
        builder: (context, player) {
          return Column(
            children: [oneVideo(context, heigth, width)],
          );
        });
  }
}
