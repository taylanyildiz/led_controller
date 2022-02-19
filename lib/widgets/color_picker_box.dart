import 'package:flutter/material.dart';

class ColorPickerBox extends StatelessWidget {
  ColorPickerBox({
    Key? key,
    required this.onSelect,
    double? height,
  })  : height = height ?? 50.0,
        super(key: key);

  /// Container height. [double]
  /// default value is 50.0
  final double height;

  /// Select color returns
  final Function(Color color) onSelect;

  final colors = <Color>[
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.transparent,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: colors.length,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onSelect.call(colors[index]),
            child: Container(
              color: colors[index],
            ),
          );
        },
      ),
    );
  }
}
