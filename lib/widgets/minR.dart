import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MiniPlayer {
  static OverlayEntry? _overlay;
  static YoutubePlayerController? _controller;

  static void mostrar(BuildContext context, String videoId) {
    if (_overlay != null) return;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _overlay = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 20,
        right: 20,
        width: 200,
        height: 120,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: false,
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  color: Colors.white,
                  onPressed: cerrar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }
  static void cerrar() {
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    _overlay?.remove();
    _overlay = null;
  }
}
