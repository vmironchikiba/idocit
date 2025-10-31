import 'dart:async';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GifBuilder extends StatefulWidget {
  final GifController? controller;
  final ImageProvider provider;
  final int frameRate;
  final FilterQuality filterQuality;
  final Widget? onLoading;
  final ValueChanged<Object?>? onError;

  const GifBuilder({
    Key? key,
    this.controller,
    required this.provider,
    this.frameRate = 30,
    this.filterQuality = FilterQuality.low,
    this.onLoading,
    this.onError,
  }) : super(key: key);

  GifBuilder.asset(
    String asset, {
    Key? key,
    this.controller,
    this.frameRate = 30,
    this.filterQuality = FilterQuality.low,
    this.onLoading,
    this.onError,
    String? package,
    AssetBundle? bundle,
  }) : provider = AssetImage(asset, package: package, bundle: bundle),
       super(key: key);

  GifBuilder.network(
    String url, {
    Key? key,
    this.controller,
    this.frameRate = 30,
    this.filterQuality = FilterQuality.low,
    this.onLoading,
    this.onError,
    Map<String, String>? headers,
  }) : provider = NetworkImage(url, headers: headers),
       super(key: key);

  GifBuilder.memory(
    Uint8List bytes, {
    Key? key,
    this.controller,
    this.frameRate = 30,
    this.filterQuality = FilterQuality.low,
    this.onLoading,
    this.onError,
  }) : provider = MemoryImage(bytes),
       super(key: key);

  static final cachedGIFs = <String, List<GifFrameItem>>{};

  static List<GifFrameItem> getCachedGIF(ImageProvider provider) {
    final key = GifBuilder.getImageKey(provider);
    if (GifBuilder.cachedGIFs.containsKey(key)) {
      return GifBuilder.cachedGIFs[key]!;
    }

    return [];
  }

  static Future<void> precacheGIF(ImageProvider provider, {int? frameRate, ValueChanged<Object?>? onError}) async {
    try {
      final key = GifBuilder.getImageKey(provider);
      Uint8List? data;

      if (GifBuilder.cachedGIFs.containsKey(key)) {
        return;
      }

      /// Convert gif-s to bytes
      if (provider is AssetImage) {
        final imageKey = await provider.obtainKey(const ImageConfiguration());
        final bytes = await imageKey.bundle.load(imageKey.name);
        data = bytes.buffer.asUint8List();
      }

      if (provider is NetworkImage) {
        final uri = Uri.parse(provider.url);
        final response = await http.get(uri, headers: provider.headers);
        data = response.bodyBytes;
      }

      if (provider is FileImage) {
        data = await provider.file.readAsBytes();
      }

      if (provider is MemoryImage) {
        data = provider.bytes;
      }

      if (data == null) {
        return;
      }

      /// Render gif-s
      final frames = <GifFrameItem>[];
      final codec = await instantiateImageCodec(data, allowUpscaling: false);
      for (int i = 0; i < codec.frameCount; i++) {
        final frameInfo = await codec.getNextFrame();
        Duration duration = frameInfo.duration;

        if (frameRate != null) {
          duration = Duration(milliseconds: (1000 / frameRate).ceil());
        }

        frames.add(
          GifFrameItem(
            imageInfo: ImageInfo(image: frameInfo.image),
            duration: duration,
          ),
        );
      }

      GifBuilder.cachedGIFs.putIfAbsent(key, () => frames);
    } catch (e) {
      if (onError == null) {
        rethrow;
      } else {
        onError.call(e);
      }
    }
  }

  static String getImageKey(ImageProvider provider) {
    if (provider is AssetImage) {
      return provider.assetName;
    }

    if (provider is NetworkImage) {
      return provider.url;
    }

    if (provider is MemoryImage) {
      return provider.bytes.toString();
    }

    return '';
  }

  @override
  State<GifBuilder> createState() => _GifBuilderState();
}

class _GifBuilderState extends State<GifBuilder> {
  late final GifController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? GifController();
    _controller.addListener(_listener);
    Future.delayed(Duration.zero, _loadImage);
  }

  @override
  void didUpdateWidget(covariant GifBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.provider != widget.provider) {
      _loadImage(updateFrames: true);
    }
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }

  FutureOr _loadImage({bool updateFrames = false}) async {
    await GifBuilder.precacheGIF(widget.provider, frameRate: widget.frameRate, onError: widget.onError);
    _controller.configure(GifBuilder.getCachedGIF(widget.provider), updateFrames: updateFrames);
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.status == GifAnimationStatus.loading) {
      return SizedBox(child: widget.onLoading);
    }

    return RawImage(image: _controller.currentFrame.imageInfo.image, filterQuality: widget.filterQuality);
  }
}

enum GifAnimationStatus { loading, playing, stopped, paused, reversing }

class GifController extends ChangeNotifier {
  final bool autoPlay;
  final VoidCallback? onFinish;
  final VoidCallback? onStart;
  final ValueChanged<int>? onFrame;
  final bool isLoop;

  GifController({
    this.autoPlay = true,
    this.onFinish,
    this.onStart,
    this.onFrame,
    this.isLoop = true,
    bool isInverted = false,
  }) : _isInverted = isInverted;

  final _frames = <GifFrameItem>[];
  int _currentIndex = 0;
  bool _isInverted;

  GifAnimationStatus status = GifAnimationStatus.loading;
  GifFrameItem get currentFrame => _frames[_currentIndex];

  void _run() {
    switch (status) {
      case GifAnimationStatus.playing:
      case GifAnimationStatus.reversing:
        _runNextFrame();
        break;

      case GifAnimationStatus.stopped:
        onFinish?.call();
        _currentIndex = 0;
        break;

      case GifAnimationStatus.loading:
      case GifAnimationStatus.paused:
    }
  }

  void _runNextFrame() async {
    await Future.delayed(_frames[_currentIndex].duration);

    if (status == GifAnimationStatus.reversing) {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else if (isLoop) {
        _currentIndex = _frames.length - 1;
      } else {
        status = GifAnimationStatus.stopped;
      }
    } else {
      if (_currentIndex < _frames.length - 1) {
        _currentIndex++;
      } else if (isLoop) {
        _currentIndex = 0;
      } else {
        status = GifAnimationStatus.stopped;
      }
    }

    onFrame?.call(_currentIndex);
    notifyListeners();
    _run();
  }

  void play({int? initialFrame, bool? isInverted}) {
    if (status == GifAnimationStatus.loading) return;
    _isInverted = isInverted ?? _isInverted;

    if (status == GifAnimationStatus.stopped || status == GifAnimationStatus.paused) {
      status = _isInverted ? GifAnimationStatus.reversing : GifAnimationStatus.playing;

      final isValidInitialFrame = initialFrame != null && initialFrame > 0 && initialFrame < _frames.length - 1;

      if (isValidInitialFrame) {
        _currentIndex = initialFrame;
      } else {
        _currentIndex = status == GifAnimationStatus.reversing ? _frames.length - 1 : 0;
      }
      onStart?.call();
      _run();
    } else {
      status = _isInverted ? GifAnimationStatus.reversing : GifAnimationStatus.playing;
    }
  }

  void stop() {
    status = GifAnimationStatus.stopped;
  }

  void pause() {
    status = GifAnimationStatus.paused;
  }

  void seek(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void configure(List<GifFrameItem> frames, {bool updateFrames = false}) {
    _frames.addAll(frames);
    if (!updateFrames) {
      status = GifAnimationStatus.stopped;
      if (autoPlay) {
        play();
      }
      notifyListeners();
    }
  }
}

class GifFrameItem {
  final ImageInfo imageInfo;
  final Duration duration;

  GifFrameItem({required this.imageInfo, required this.duration});
}
