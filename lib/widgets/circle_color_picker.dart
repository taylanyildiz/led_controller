import 'dart:math';
import 'package:flutter/material.dart';

class CircleColorPicker extends StatefulWidget {
  const CircleColorPicker({
    Key? key,
    required this.onChange,
    Size? size,
    double? strokeWidth,
    Color? initialColor,
    Color? changedColor,
    this.child,
  })  : size = size ?? const Size(200.0, 200.0),
        strokeWidth = strokeWidth ?? 30.0,
        initialColor = initialColor ?? Colors.orange,
        changedColor = changedColor ?? Colors.orange,
        super(key: key);

  /// Circle picker size
  /// default value is Size(200.0,200.0) [200x200]
  final Size size;

  /// Circle picker stroke width.
  /// default value is 30.0 [double].
  final double strokeWidth;

  /// Initial Color of selector on circle color picker.
  /// default value is Colors.[orange];
  final Color initialColor;

  /// On change [Color] returns.
  final Function(Color color) onChange;

  /// Center of circle picker color child [Widget].
  final Widget? child;

  /// [Color] of change
  final Color changedColor;

  @override
  State<CircleColorPicker> createState() => _CircleColorPickerState();
}

class _CircleColorPickerState extends State<CircleColorPicker>
    with TickerProviderStateMixin {
  late AnimationController _hueController;
  late AnimationController _scaleController;
  late Animation<Offset> _offset;

  @override
  void initState() {
    final minSize = min(circleWidth, circleHeight);
    _hueController = AnimationController(
      vsync: this,
      value: initialHue * pi / 180,
      lowerBound: 0,
      upperBound: 2 * pi,
    )..addListener(_hueListener);
    _scaleController = AnimationController(
      vsync: this,
      value: .8,
      lowerBound: 0.7,
      upperBound: 0.8,
      duration: const Duration(milliseconds: 50),
    );
    _offset = _CircleTween((minSize - strokeWidth) / 2).animate(_hueController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CircleColorPicker oldWidget) {
    if (oldWidget.changedColor != widget.changedColor) {
      _hueController.value = changedHue * pi / 180;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _hueListener() {
    final color = _onChangeColor;
    widget.onChange.call(color);
  }

  double get circleWidth => widget.size.width;

  double get circleHeight => widget.size.height;

  double get strokeWidth => widget.strokeWidth;

  Color get initialColor => widget.initialColor;

  Color get changedColor => widget.initialColor;

  double get initialHue => HSLColor.fromColor(initialColor).hue;

  double get changedHue => HSLColor.fromColor(changedColor).hue;

  Color get _onChangeColor {
    final hue = _hueController.value * (180 / pi);
    return HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
  }

  void _onDragStart(DragStartDetails details) {
    _scaleController.reverse();
    _updatePosition(details.localPosition);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _updatePosition(details.localPosition);
  }

  void _onDragEnd(_) {
    _scaleController.forward();
  }

  void _updatePosition(Offset position) {
    final radians = atan2(
      position.dy - circleHeight / 2,
      position.dx - circleWidth / 2,
    );
    _hueController.value = radians % (2 * pi);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onPanStart: _onDragStart,
          onPanUpdate: _onDragUpdate,
          onPanEnd: _onDragEnd,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            width: circleWidth,
            height: circleHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildCirclePainter,
                _buildSelector,
              ],
            ),
          ),
        ),
        _buildCenterChild,
      ],
    );
  }

  Widget get _buildCirclePainter {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _CircleColorPainter(
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }

  Widget get _buildSelector {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) {
        return Positioned(
          top: _offset.value.dy,
          left: _offset.value.dx,
          child: child!,
        );
      },
      child: AnimatedBuilder(
        animation: _hueController,
        builder: (context, child) {
          return ScaleTransition(
            scale: _scaleController,
            child: Container(
              width: strokeWidth,
              height: strokeWidth,
              decoration: BoxDecoration(
                color: _onChangeColor,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(1.0, 1.0),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _buildCenterChild {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circleHeight - strokeWidth * 2),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: widget.child,
      ),
    );
  }
}

/// Custom painter of circle color picker.
class _CircleColorPainter extends CustomPainter {
  _CircleColorPainter({
    required this.strokeWidth,
  });

  /// storeke width of cirlce color picker
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = size.center(Offset.zero);
    double radius = min(size.width, size.height) / 2 - strokeWidth / 2;

    final hueGradientShader = SweepGradient(
      colors: [
        const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
        const HSVColor.fromAHSV(1.0, 51.0, 1.0, 1.0).toColor(),
        const HSVColor.fromAHSV(1.0, 102.0, 1.0, 1.0).toColor(),
        const HSVColor.fromAHSV(1.0, 153.0, 1.0, 1.0).toColor(),
        const HSVColor.fromAHSV(1.0, 204.0, 1.0, 1.0).toColor(),
        const HSVColor.fromAHSV(1.0, 255.0, 1.0, 1.0).toColor(),
        const HSVColor.fromAHSV(1.0, 306.0, 1.0, 1.0).toColor(),
        const HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0).toColor(),
      ],
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    final paint = Paint()
      ..shader = hueGradientShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _CircleTween extends Tween<Offset> {
  _CircleTween(this.radius) : super(begin: _begin(radius), end: _end(radius));
  final double radius;

  static _begin(radius) {
    return _radiansToOffset(0, radius);
  }

  static _end(radius) {
    return _radiansToOffset(2 * pi, radius);
  }

  @override
  Offset lerp(double t) => _radiansToOffset(t, radius);

  static Offset _radiansToOffset(double radians, double radius) {
    return Offset(
      radius + (radius * cos(radians)),
      radius + (radius * sin(radians)),
    );
  }
}
