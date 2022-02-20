import 'dart:async';
import 'dart:developer' as console;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  const LottieAnimation({
    Key? key,
    required this.source,
    bool? autoAnimate,
    this.controller,
    bool? ignoring,
  })  : autoAnimate = autoAnimate ?? false,
        ignoring = ignoring ?? true,
        super(key: key);

  /// this [LottieAnimation]
  /// auto animate false.
  final bool autoAnimate;

  /// this [controller] lottie controller.
  final LottieController? controller;

  /// The source of lottie [json].
  /// assets file path.
  final String source;

  /// [IgnorePointer] ignoring
  /// default [true].
  final bool ignoring;

  @override
  State<LottieAnimation> createState() => _L();
}

class _L extends State<LottieAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    _loadAnimation();
    _loadController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _loadAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: widget.controller?.duration,
      reverseDuration: widget.controller?.reverseDuration,
    )..addListener(_animationStatusListener);
  }

  /// Just works when auto animation false
  void _loadController() {
    widget.controller?._addListener(_start, _reset, _reverse, _anim);
  }

  void _reset() {
    if (controller.isCompleted) {
      controller.reset();
    }
  }

  Future<void> _start() async {
    if (controller.isCompleted) {
      controller.reset();
    }
    await controller.forward();
    console.log('Lottie forward');
  }

  Future<void> _reverse() async {
    await controller.reverse();
    console.log('Lottie reverse');
  }

  Future<void> _anim() async {
    await controller.forward();
    console.log("Lottie anim");
    controller.reset();
  }

  void _animationStatusListener() {
    // animation status listener
    if (controller.isCompleted) {
      widget.controller?._listenAnimationDone(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.ignoring,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Lottie.asset(
            widget.source,
            controller: controller,
            fit: BoxFit.contain,
            onLoaded: (composition) {
              if (widget.autoAnimate) {
                controller
                  ..duration = composition.duration
                  ..forward();
              } else {
                controller.duration = composition.duration;
              }
            },
          );
        },
      ),
    );
  }
}

class LottieController extends ChangeNotifier {
  LottieController({
    this.duration,
    this.reverseDuration,
  });

  /// this [lottie] animation forward duration,
  /// default value of animation lottie [json].
  final Duration? duration;

  /// this [lottie] animation reverse duration.
  /// default value of animation lottie [json].
  final Duration? reverseDuration;

  late FutureOr<void> Function() _start;
  late FutureOr<void> Function() _reverse;
  late FutureOr<void> Function() _anim;
  late VoidCallback _reset;

  bool isDone = false;

  // listen of this [widget].
  void _addListener(
    FutureOr<void> Function() _start,
    VoidCallback _reset,
    FutureOr<void> Function() _reverse,
    FutureOr<void> Function() _anim,
  ) {
    this._start = _start;
    this._reset = _reset;
    this._reverse = _reverse;
    this._anim = _anim;
  }

  void _listenAnimationDone(bool isDone) {
    this.isDone = isDone;
    notifyListeners();
  }

  /// this [lottie] animation start.
  Future<void> start() async => await _start();

  /// this [lottie] animation forward then resest
  Future<void> anim() async => await _anim();

  /// this [lottie] animation reverse.
  Future<void> reverse() async => await _reverse();

  /// this [lottie] animation stop.
  void reset() => _reset;
}
