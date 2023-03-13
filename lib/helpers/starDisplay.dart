import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final double value;
  const StarDisplay({Key key, this.value = 0.0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final starSize = 16.0;
    final halfStar = IconTheme(
      data: IconThemeData(
        size: starSize,
      ),
      child: SizedBox(
        child: Icon(Icons.star_half),
      ),
    );
    final fullStar = IconTheme(
      data: IconThemeData(
        size: starSize,
      ),
      child: SizedBox(
        child: Icon(Icons.star),
      ),
    );
    final emptyStar = IconTheme(
      data: IconThemeData(
        size: starSize,
        color: Colors.grey,
      ),
      child: SizedBox(
        child: Icon(Icons.star_border),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index + 0.5 < value) {
          return fullStar;
        } else if (index < value) {
          return halfStar;
        } else {
          return emptyStar;
        }
      }),
    );
  }
}
