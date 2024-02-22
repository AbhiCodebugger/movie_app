import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/domain/entity/trailer_entity.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayerScreen extends StatefulWidget {
  final TrailerEntity trailerEntity;

  const MoviePlayerScreen({
    required this.trailerEntity,
    super.key,
  });

  @override
  State<MoviePlayerScreen> createState() => _MoviePlayerScreenState();
}

class _MoviePlayerScreenState extends State<MoviePlayerScreen> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.trailerEntity.key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.orange,
            onReady: () {
              _controller.play();
            },
            onEnded: (data) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
