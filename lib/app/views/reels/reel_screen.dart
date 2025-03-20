import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/views/reels/reel_controller.dart';
import 'package:video_player/video_player.dart';

class ReelScreen extends StatelessWidget {
  const ReelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReelController>(
        init: ReelController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Reels'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => controller.uploadVideo(),
                ),
              ],
            ),
            body: GetBuilder<ReelController>(
              id: 'videoList',
              builder: (controller) {
                if (controller.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.videoUrls.isEmpty) {
                  return Center(child: Text('No videos available'));
                }

                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller.videoUrls.length,
                  key:
                      ValueKey('reels-pageview-${controller.videoUrls.length}'),
                  itemBuilder: (context, index) {
                    return VideoPlayerItem(
                      key: ValueKey('video-${controller.videoUrls[index]}'),
                      videoUrl: controller.videoUrls[index],
                      index: index,
                    );
                  },
                );
              },
            ),
          );
        });
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final int index;

  const VideoPlayerItem({
    super.key,
    required this.videoUrl,
    required this.index,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _videoPlayerController;
  bool _isInitialized = false;
  bool _isDisposed = false;

  // Keep widget alive when scrolling
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      // Add value listener only once
      _videoPlayerController.addListener(() {
        if (!mounted || _isDisposed) return;
      });

      await _videoPlayerController.initialize();

      if (_isDisposed) return;

      await _videoPlayerController.setLooping(true);

      // Check if widget is still mounted before updating state
      if (!mounted || _isDisposed) return;

      // Auto-play when ready
      if (_videoPlayerController.value.isInitialized) {
        _videoPlayerController.play();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      }
    } catch (e) {
      print('Error initializing video ${widget.index}: $e');
      // Prevent state updates if already disposed
      if (!mounted || _isDisposed) return;
      setState(() {
        _isInitialized = false;
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    print('Disposed video player for index ${widget.index}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    if (!_isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () {
        if (_videoPlayerController.value.isPlaying) {
          _videoPlayerController.pause();
        } else {
          _videoPlayerController.play();
        }
        // Only refresh this widget, not the whole list
        if (mounted) setState(() {});
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black, // Ensure black background
        child: Stack(
          children: [
            // Video with center crop to fill the screen
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    height: _videoPlayerController.value.size.height,
                    width: _videoPlayerController.value.size.width,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                ),
              ),
            ),
            // Play/pause overlay
            Positioned(
              bottom: 20,
              right: 20,
              child: _videoPlayerController.value.isPlaying
                  ? Container() // Hide when playing
                  : Icon(
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
