import 'package:flutter/material.dart';

class SliderLineHoriz extends StatefulWidget {
  const SliderLineHoriz({
    Key? key,
    double? initialValue,
    required this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
  })  : initialValue = initialValue ?? 0.0,
        super(key: key);

  /// Listen change value
  /// return value. [int].
  final Function(int value) onChanged;

  /// Initial value.
  /// default value is 0.0
  final double initialValue;

  /// Prefix icon.
  final Widget? prefixIcon;

  /// Suffix icon.
  final Widget? suffixIcon;

  @override
  State<SliderLineHoriz> createState() => _SliderLineHorizState();
}

class _SliderLineHorizState extends State<SliderLineHoriz> {
  late double value;

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  Widget? get prefix => widget.prefixIcon;

  Widget? get suffix => widget.suffixIcon;

  void _onChanged(double value) {
    this.value = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(),
      child: Row(
        children: [
          prefix ?? const SizedBox(),
          Expanded(
            child: Slider(
              onChanged: _onChanged,
              value: value,
              min: 0.0,
              max: value,
            ),
          ),
          suffix ?? const SizedBox(),
        ],
      ),
    );
  }
}
