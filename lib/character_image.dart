import 'package:flutter/material.dart';
import 'package:walkscape_characters/option_interface.dart';
import 'package:walkscape_characters/pfp_manager.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({super.key, required this.width, required this.height, required this.selectedSprites});
  final double width;
  final double height;
  final List<OptionInterface> selectedSprites;

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
              for (var i = 0; i < 15; i++)
                for (var sprite in selectedSprites)
                  sprite.layer == i
                      ? Image.asset(
                          sprite.runtimeType == SpriteFace ? (sprite as SpriteFace).expressionOptions[PfpManager().chosenExpression]! : sprite.spritePath,
                          width: width,
                          height: height,
                          scale: 0.01,
                          filterQuality: FilterQuality.none,
                        )
                      : const SizedBox.shrink(),
            ],
          ),
        )
      ],
    );
  }
}
