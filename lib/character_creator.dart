import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:walkscape_characters/change_between_views.dart';
import 'package:walkscape_characters/character_image.dart';
import 'package:walkscape_characters/option_picker.dart';
import 'package:walkscape_characters/pfp_manager.dart';
import 'package:walkscape_characters/vars.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:universal_html/html.dart' as html;

double getCardWidth() {
  return 250.0;
}

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
      !PfpManager().lockedOptions['colorHair']! ? PfpManager().colorHair = colorOptionsHair.keys.toList()[Random().nextInt(colorOptionsHair.length)] : null;
      !PfpManager().lockedOptions['colorEyebrown']!
          ? PfpManager().colorEyeBrown = colorOptionsEyebrowns.keys.toList()[Random().nextInt(colorOptionsEyebrowns.length)]
          : null;
      !PfpManager().lockedOptions['colorFacialHair']!
          ? PfpManager().colorFacialHair = colorOptionsFacialHair.keys.toList()[Random().nextInt(colorOptionsFacialHair.length)]
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          margin: const EdgeInsets.all(4.0),
          height: 30,
          child: Center(
            widthFactor: 1.0,
            child: AutoSizeText(
              widget.title,
              maxLines: 2,
            ),
          ),
        ),
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
            Expanded(
              child: Stack(
                children: [
                  chosenView == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SingleChildScrollView(
                            padding: ResponsiveBreakpoints.of(context).isDesktop ? null : const EdgeInsets.symmetric(vertical: 140),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: SingleChildScrollView(
                            padding: ResponsiveBreakpoints.of(context).isDesktop ? null : const EdgeInsets.symmetric(vertical: 140),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                OptionPicker(
                                  label: 'Hair color',
                                  colorList: colorOptionsHair,
                                  selectedColor: PfpManager().colorHair,
                                  lockKey: 'colorHair',
                                  onSelect: (option) {
                                    PfpManager().colorHair = option as String;
                                    setState(() {});
                                  },
                                ),
                                OptionPicker(
                                  label: 'Eyebrown color',
                                  colorList: colorOptionsEyebrowns,
                                  selectedColor: PfpManager().colorEyeBrown,
                                  lockKey: 'colorEyebrown',
                                  onSelect: (option) {
                                    PfpManager().colorEyeBrown = option as String;
                                    setState(() {});
                                  },
                                ),
                                OptionPicker(
                                  label: 'Facial hair color',
                                  colorList: colorOptionsFacialHair,
                                  selectedColor: PfpManager().colorFacialHair,
                                  lockKey: 'colorFacialHair',
                                  onSelect: (option) {
                                    PfpManager().colorFacialHair = option as String;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                  ResponsiveBreakpoints.of(context).isDesktop
                      ? Card(
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 256,
                                  height: 256,
                                  child: WidgetsToImage(
                                      controller: _controller,
                                      child: CharacterImage(
                                        width: 256,
                                        height: 256,
                                        selectedSprites: [
                                          PfpManager().chosenBody,
                                          PfpManager().chosenFace,
                                          PfpManager().chosenNose,
                                          PfpManager().chosenHair,
                                          PfpManager().chosenOutfit,
                                        ],
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                                  child: ChangeBetweenViewsButton(onChanged: () {
                                    setState(() {
                                      if (chosenView == 0) {
                                        chosenView = 1;
                                      } else {
                                        chosenView = 0;
                                      }
                                    });
                                  }),
                                ),
                                FilledButton(
                                    onPressed: _randomize,
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.casino),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('Randomize'),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        )
                      : Card(
                          margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 128,
                                  height: 128,
                                  child: WidgetsToImage(
                                      controller: _controller,
                                      child: CharacterImage(
                                        width: 128,
                                        height: 128,
                                        selectedSprites: [
                                          PfpManager().chosenBody,
                                          PfpManager().chosenFace,
                                          PfpManager().chosenNose,
                                          PfpManager().chosenHair,
                                          PfpManager().chosenOutfit,
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 128,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: ChangeBetweenViewsButton(onChanged: () {
                                          setState(() {
                                            if (chosenView == 0) {
                                              chosenView = 1;
                                            } else {
                                              chosenView = 0;
                                            }
                                          });
                                        }),
                                      ),
                                      FilledButton(
                                          onPressed: _randomize,
                                          style: ElevatedButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.zero),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.casino,
                                                  size: 18,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Randomize',
                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primaryContainer),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
