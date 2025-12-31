import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MiniPlayer {
  static OverlayEntry? _overlay;
  static VideoPlayerController? _controller;

  static void mostrarVideo(BuildContext context, String videoUrl) {
    if (_overlay != null) return;

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize().then((_) {
        _controller!.play();
        _overlay!.markNeedsBuild();
      });

    _overlay = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 20,
        right: 20,
        width: 200,
        height: 120,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _controller!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio:
                            _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
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
