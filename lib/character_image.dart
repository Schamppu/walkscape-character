import 'package:flutter/material.dart';
import 'package:walkscape_characters/pfp_manager.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(color: Colors.amber[300]),
          child: Stack(
            children: [
              Image.asset(
                PfpManager().chosenBody.spritePath,
                width: width,
                height: height,
                scale: 0.01,
                filterQuality: FilterQuality.none,
              ),
            ],
          ),
        )
      ],
    );
  }
}
