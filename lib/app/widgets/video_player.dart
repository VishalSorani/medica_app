import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final int index;

  const VideoPlayerItem({
    super.key,
    required this.videoUrl,
    required this.index,
  });

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoPlayerController;
  bool _isInitialized = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
      print("Initializing video player for index ${widget.index}");
      await _videoPlayerController.initialize();

      if (_isDisposed) return;

      await _videoPlayerController.setLooping(true);

      if (!_isDisposed) {
        _videoPlayerController.play();
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing video ${widget.index}: $e');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _videoPlayerController.pause();
    _videoPlayerController.dispose(); // Properly disposing
    print('Disposed video player for index ${widget.index}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () {
        if (_videoPlayerController.value.isPlaying) {
          _videoPlayerController.pause();
        } else {
          _videoPlayerController.play();
        }
        setState(() {});
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoPlayerController.value.size.width,
                  height: _videoPlayerController.value.size.height,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
            ),
            if (!_videoPlayerController.value.isPlaying)
              const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
