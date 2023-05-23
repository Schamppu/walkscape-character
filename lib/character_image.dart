import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:walkscape_characters/option_interface.dart';
import 'package:walkscape_characters/pfp_manager.dart';
import 'package:walkscape_characters/vars.dart';

class CharacterImage extends StatelessWidget {
  CharacterImage({super.key, required this.width, required this.height, required this.selectedSprites});
  final double width;
  final double height;
  final List<OptionInterface> selectedSprites;
  bool loading = true;

  List<Color> getDefaultColor(OptionInterface sprite) {
    if (sprite.runtimeType == SpriteBody || sprite.runtimeType == SpriteFace) {
      return colorOptionsSkin['light']! + colorOptionsFacialHair['darker brown']! + colorOptionsEyebrowns['dark']!;
    }
    if (sprite.runtimeType == SpriteGeneric) {
      if ((sprite as SpriteGeneric).type == 'nose') {
        return colorOptionsSkin['light']!;
      }
      if (sprite.type == 'hair') {
        return colorOptionsHair['darkest brown']!;
      }
    }
    return [];
  }

  List<Color> getChangedColor(OptionInterface sprite) {
    if (sprite.runtimeType == SpriteBody || sprite.runtimeType == SpriteFace) {
      return colorOptionsSkin[PfpManager().colorSkin]! + colorOptionsFacialHair[PfpManager().colorFacialHair]! + colorOptionsEyebrowns[PfpManager().colorEyeBrown]!;
    }
    if (sprite.runtimeType == SpriteGeneric) {
      if ((sprite as SpriteGeneric).type == 'nose') {
        return colorOptionsSkin[PfpManager().colorSkin]!;
      }
      if (sprite.type == 'hair') {
        return colorOptionsHair[PfpManager().colorHair]!;
      }
    }
    return [];
  }

  List<Widget> getSprites() {
    var returnList = <Widget>[];
    for (var i = 0; i < 15; i++) {
      for (var sprite in selectedSprites) {
        if (sprite.layer == i) {
          returnList.add(Stack(
            children: [
              // The default sprite of this layer
              buildSprite(sprite.runtimeType == SpriteFace ? (sprite as SpriteFace).expressionOptions[PfpManager().chosenExpression]! : sprite.spritePath,
                  getDefaultColor(sprite), getChangedColor(sprite), width, height),
              // The iris layer
              (sprite.runtimeType == SpriteFace && PfpManager().chosenExpression != 'sad' && PfpManager().chosenExpression != 'laughing')
                  ? buildSprite(PfpManager().chosenBody.irisPath, colorOptionsEyes['black']!, colorOptionsEyes[PfpManager().colorEyes]!, width, height)
                  : const SizedBox.shrink(),
            ],
          ));
        }
      }
      // Check for the supplementary sprites
      for (var sprite in selectedSprites) {
        if (sprite.runtimeType == SpriteGeneric) {
          var layer = (sprite as SpriteGeneric).supplementaryLayer;
          var path = sprite.supplementaryPath;
          if (layer == i && path != null) {
            returnList.add(buildSprite(path, getDefaultColor(sprite), getChangedColor(sprite), width, height));
          }
        }
      }
    }
    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(color: colorOptionsBackground[PfpManager().colorBg]![0]),
          child: Stack(children: getSprites()),
        )
      ],
    );
  }
}

Widget buildSprite(String path, List<Color> defaultColor, List<Color> changeColor, double width, double height) {
  return FutureBuilder(
    future: switchColorPalette(
      imagePath: path,
      existingColors: defaultColor,
      changeColors: changeColor,
    ),
    builder: (_, AsyncSnapshot<Uint8List> snapshot) {
      return snapshot.hasData
          ? Image.memory(
              snapshot.data!,
              width: width,
              height: height,
              scale: 0.1,
              filterQuality: FilterQuality.none,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                return child;
              },
            )
          : const SizedBox.shrink();
    },
  );
}
