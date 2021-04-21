import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidesBar extends StatelessWidget {
  final AnimationController animController;
  final int position, index;

  const SlidesBar(
      {Key key,
      @required this.animController,
      @required this.position,
      @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 1.5,
      ),
      child: LayoutBuilder(builder: (context, edges) {
        return Stack(
          children: <Widget>[
            barContainer(
                double.infinity,
                position < index
                    ? Colors.white
                    : Colors.white.withOpacity(0.5)),
            position == index
                ? AnimatedBuilder(
                    animation: animController,
                    builder: (context, child) {
                      return barContainer(
                        edges.maxWidth * animController.value,
                        Colors.white,
                      );
                    },
                  )
                : SizedBox.shrink()
          ],
        );
      }),
    ));
  }

  Container barContainer(double width, Color color) {
    return Container(
      height: 3,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
