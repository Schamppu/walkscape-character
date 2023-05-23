import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:walkscape_characters/change_between_views.dart';
import 'package:walkscape_characters/character_image.dart';
import 'package:walkscape_characters/option_picker.dart';
import 'package:walkscape_characters/pfp_manager.dart';
import 'package:walkscape_characters/vars.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:universal_html/html.dart' as html;

class PageCharacterCreator extends StatefulWidget {
  const PageCharacterCreator({super.key, required this.title});
  final String title;

  @override
  State<PageCharacterCreator> createState() => _PageCharacterCreatorState();
}

class _PageCharacterCreatorState extends State<PageCharacterCreator> {
  final WidgetsToImageController _controller = WidgetsToImageController();
  var chosenView = 0;
  Uint8List? bytes;

  /// Downloads a file from a list of bytes
  void download(Uint8List bytes, {required String downloadName}) {
    final base64 = base64Encode(bytes);
    final anchor = html.AnchorElement(href: 'data:image/png;base64,$base64')..target = 'blank';
    anchor.download = downloadName;
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }

  /// Saves the image to local system
  Future<void> _saveImage() async {
    bytes = await _controller.capture();

    if (bytes != null) {
      download(bytes!, downloadName: 'ws_character.png');
    }
  }

  /// Randomizes all of the options
  void _randomize() {
    setState(() {
      !PfpManager().lockedOptions['body']! ? PfpManager().chosenBody = PfpManager().optionsBody[Random().nextInt(PfpManager().optionsBody.length)] : null;
      !PfpManager().lockedOptions['face']!
          ? PfpManager().chosenFace = PfpManager().chosenBody.faceOptions[Random().nextInt(PfpManager().chosenBody.faceOptions.length)]
          : null;
      !PfpManager().lockedOptions['expression']!
          ? PfpManager().chosenExpression = PfpManager().chosenFace.expressionOptions.keys.toList()[Random().nextInt(PfpManager().chosenFace.expressionOptions.length)]
          : null;
      !PfpManager().lockedOptions['hair']!
          ? PfpManager().chosenHair = PfpManager().chosenBody.hairOptions[Random().nextInt(PfpManager().chosenBody.hairOptions.length)]
          : null;
      !PfpManager().lockedOptions['nose']!
          ? PfpManager().chosenNose = PfpManager().chosenBody.noseOptions[Random().nextInt(PfpManager().chosenBody.noseOptions.length)]
          : null;
      !PfpManager().lockedOptions['outfit']!
          ? PfpManager().chosenOutfit = PfpManager().chosenBody.outfitOptions[Random().nextInt(PfpManager().chosenBody.outfitOptions.length)]
          : null;
      !PfpManager().lockedOptions['colorBG']! ? PfpManager().colorBg = colorOptionsBackground.keys.toList()[Random().nextInt(colorOptionsBackground.length)] : null;
      !PfpManager().lockedOptions['colorSkin']! ? PfpManager().colorSkin = colorOptionsSkin.keys.toList()[Random().nextInt(colorOptionsSkin.length)] : null;
      !PfpManager().lockedOptions['colorEyes']! ? PfpManager().colorEyes = colorOptionsEyes.keys.toList()[Random().nextInt(colorOptionsEyes.length)] : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: ElevatedButton(onPressed: _saveImage, child: const Text('Save as .png')),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Center(child: ChangeBetweenViewsButton(onChanged: () {
                setState(() {
                  if (chosenView == 0) {
                    chosenView = 1;
                  } else {
                    chosenView = 0;
                  }
                });
              })),
            ),
            Expanded(
              child: Stack(
                children: [
                  chosenView == 0
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 170),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: _randomize,
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [Icon(Icons.casino), Text('Randomize')],
                                  )),
                              OptionPicker(
                                label: 'Body type',
                                selectedOption: PfpManager().chosenBody,
                                optionList: PfpManager().optionsBody,
                                lockKey: 'body',
                                onSelect: (option) {
                                  PfpManager().chosenBody = option as SpriteBody;
                                  PfpManager().chosenFace = PfpManager().chosenBody.faceOptions.first;
                                  PfpManager().chosenNose = PfpManager().chosenBody.noseOptions.first;
                                  PfpManager().chosenHair = PfpManager().chosenBody.hairOptions.first;
                                  PfpManager().chosenOutfit = PfpManager().chosenBody.outfitOptions.first;
                                  setState(() {});
                                },
                              ),
                              OptionPicker(
                                label: 'Face',
                                selectedOption: PfpManager().chosenFace,
                                optionList: PfpManager().chosenBody.faceOptions,
                                lockKey: 'face',
                                onSelect: (option) {
                                  PfpManager().chosenFace = option as SpriteFace;
                                  setState(() {});
                                },
                                onExpressionSelect: (option) {
                                  PfpManager().chosenExpression = option;
                                  setState(() {});
                                },
                              ),
                              OptionPicker(
                                label: 'Nose',
                                selectedOption: PfpManager().chosenNose,
                                optionList: PfpManager().chosenBody.noseOptions,
                                lockKey: 'nose',
                                onSelect: (option) {
                                  PfpManager().chosenNose = option as SpriteGeneric;
                                  setState(() {});
                                },
                              ),
                              OptionPicker(
                                label: 'Hair style',
                                selectedOption: PfpManager().chosenHair,
                                optionList: PfpManager().chosenBody.hairOptions,
                                lockKey: 'hair',
                                onSelect: (option) {
                                  PfpManager().chosenHair = option as SpriteGeneric;
                                  setState(() {});
                                },
                              ),
                              OptionPicker(
                                label: 'Outfit',
                                selectedOption: PfpManager().chosenOutfit,
                                optionList: PfpManager().chosenBody.outfitOptions,
                                lockKey: 'outfit',
                                onSelect: (option) {
                                  PfpManager().chosenOutfit = option as SpriteGeneric;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 170),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: _randomize,
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [Icon(Icons.casino), Text('Randomize')],
                                  )),
                              OptionPicker(
                                label: 'Background color',
                                colorList: colorOptionsBackground,
                                selectedColor: PfpManager().colorBg,
                                lockKey: 'colorBG',
                                onSelect: (option) {
                                  PfpManager().colorBg = option as String;
                                  setState(() {});
                                },
                              ),
                              OptionPicker(
                                label: 'Skin color',
                                colorList: colorOptionsSkin,
                                selectedColor: PfpManager().colorSkin,
                                lockKey: 'colorSkin',
                                onSelect: (option) {
                                  PfpManager().colorSkin = option as String;
                                  setState(() {});
                                },
                              ),
                              OptionPicker(
                                label: 'Eye color',
                                colorList: colorOptionsEyes,
                                selectedColor: PfpManager().colorEyes,
                                lockKey: 'colorEyes',
                                onSelect: (option) {
                                  PfpManager().colorEyes = option as String;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                  Row(
                    mainAxisAlignment: ResponsiveBreakpoints.of(context).isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: ResponsiveBreakpoints.of(context).isDesktop ? const EdgeInsets.only(left: 25) : const EdgeInsets.all(0),
                        child: SizedBox(
                          width: ResponsiveBreakpoints.of(context).isDesktop ? 256 : 128,
                          height: ResponsiveBreakpoints.of(context).isDesktop ? 256 : 128,
                          child: WidgetsToImage(
                              controller: _controller,
                              child: CharacterImage(
                                width: ResponsiveBreakpoints.of(context).isDesktop ? 256 : 128,
                                height: ResponsiveBreakpoints.of(context).isDesktop ? 256 : 128,
                                selectedSprites: [
                                  PfpManager().chosenBody,
                                  PfpManager().chosenFace,
                                  PfpManager().chosenNose,
                                  PfpManager().chosenHair,
                                  PfpManager().chosenOutfit,
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
