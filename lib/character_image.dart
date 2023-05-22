import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:walkscape_characters/option_interface.dart';
import 'package:walkscape_characters/pfp_manager.dart';
import 'package:walkscape_characters/vars.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({super.key, required this.width, required this.height, required this.selectedSprites});
  final double width;
  final double height;
  final List<OptionInterface> selectedSprites;

  List<Color> getDefaultColor() {
    return colorOptionsSkin['light']!;
  }

  List<Color> getChangedColor() {
    return colorOptionsSkin[PfpManager().colorSkin]!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(color: colorOptionsBackground[PfpManager().colorBg]![0]),
          child: Stack(
            children: [
              for (var i = 0; i < 15; i++)
                for (var sprite in selectedSprites)
                  sprite.layer == i
                      ? FutureBuilder(
                          future: switchColorPalette(
                            imagePath: sprite.runtimeType == SpriteFace ? (sprite as SpriteFace).expressionOptions[PfpManager().chosenExpression]! : sprite.spritePath,
                            existingColors: getDefaultColor(),
                            changeColors: getChangedColor(),
                          ),
                          builder: (_, AsyncSnapshot<Uint8List> snapshot) {
                            return snapshot.hasData
                                ? Image.memory(
                                    snapshot.data!,
                                    width: width,
                                    height: height,
                                    scale: 0.1,
                                    filterQuality: FilterQuality.none,
                                  )
                                : const CircularProgressIndicator();
                          },
                        )
                      : const SizedBox.shrink(),
            ],
          ),
        )
      ],
    );
  }
}
