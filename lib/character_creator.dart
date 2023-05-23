import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:walkscape_characters/change_between_views.dart';
import 'package:walkscape_characters/character_image.dart';
import 'package:walkscape_characters/option_interface.dart';
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

  List<OptionInterface> _getSelectedSprites() {
    final returnList = [
      PfpManager().chosenBody,
      PfpManager().chosenFace,
      PfpManager().chosenNose,
      PfpManager().chosenHair,
      PfpManager().chosenOutfit,
    ];
    PfpManager().chosenBackAccessory != null ? returnList.add(PfpManager().chosenBackAccessory!) : null;
    PfpManager().chosenFaceAccessory != null ? returnList.add(PfpManager().chosenFaceAccessory!) : null;
    PfpManager().chosenEye != null ? returnList.add(PfpManager().chosenEye!) : null;
    return returnList;
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
      // Hair randomisation
      var previousHair = PfpManager().chosenHair;
      !PfpManager().lockedOptions['hair']!
          ? PfpManager().chosenHair = PfpManager().chosenBody.hairOptions[Random().nextInt(PfpManager().chosenBody.hairOptions.length)]
          : null;
      _randomizeVariant(PfpManager().chosenHair, previousHair, 'hairVariant');

      // Nose randomisation
      var previousNose = PfpManager().chosenOutfit;
      !PfpManager().lockedOptions['nose']!
          ? PfpManager().chosenNose = PfpManager().chosenBody.noseOptions[Random().nextInt(PfpManager().chosenBody.noseOptions.length)]
          : null;
      _randomizeVariant(PfpManager().chosenNose, previousNose, 'noseVariant');

      // Outfit randomisation
      var previousOutfit = PfpManager().chosenOutfit;
      !PfpManager().lockedOptions['outfit']!
          ? PfpManager().chosenOutfit = PfpManager().chosenBody.outfitOptions[Random().nextInt(PfpManager().chosenBody.outfitOptions.length)]
          : null;
      _randomizeVariant(PfpManager().chosenOutfit, previousOutfit, 'outfitVariant');

      // Back accessory randomisation
      var previousBackAccessory = PfpManager().chosenBackAccessory;
      if (!PfpManager().lockedOptions['backAccessory']!) {
        if (Random().nextInt(5) == 0) {
          PfpManager().chosenBackAccessory = PfpManager().optionsBackAccessory[Random().nextInt(PfpManager().optionsBackAccessory.length)];
        } else {
          PfpManager().chosenBackAccessory = null;
        }
      }
      _randomizeVariant(PfpManager().chosenBackAccessory, previousBackAccessory, 'backAccessoryVariant');

      // Face accessory randomisation
      var previousFaceAccessory = PfpManager().chosenFaceAccessory;
      if (!PfpManager().lockedOptions['faceAccessory']!) {
        if (Random().nextInt(5) == 0) {
          PfpManager().chosenFaceAccessory = PfpManager().chosenBody.faceAccessoryOptions[Random().nextInt(PfpManager().chosenBody.faceAccessoryOptions.length)];
        } else {
          PfpManager().chosenFaceAccessory = null;
        }
      }
      _randomizeVariant(PfpManager().chosenFaceAccessory, previousFaceAccessory, 'faceAccessoryVariant');

      // Eye / eye accessory randomisation
      var previousEye = PfpManager().chosenEye;
      if (!PfpManager().lockedOptions['eyes']!) {
        if (Random().nextInt(5) == 0) {
          PfpManager().chosenEye = PfpManager().chosenBody.eyeOptions[Random().nextInt(PfpManager().chosenBody.eyeOptions.length)];
        } else {
          PfpManager().chosenEye = null;
        }
      }
      _randomizeVariant(PfpManager().chosenFaceAccessory, previousEye, 'eyesVariant');

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

  void _randomizeVariant(SpriteGeneric? sprite, SpriteGeneric? previousSprite, String variantLockKey) {
    if (previousSprite != null) {
      previousSprite.chosenVariant = null;
    }

    if (sprite != null) {
      if (sprite.variants.isNotEmpty && !PfpManager().lockedOptions[variantLockKey]!) {
        sprite.chosenVariant = sprite.variants.keys.toList()[Random().nextInt(sprite.variants.length)];
        if (Random().nextInt(sprite.variants.length + 1) == 0) {
          sprite.chosenVariant = null;
        }
      }
    }
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
                                    PfpManager().chosenFaceAccessory = null;
                                    PfpManager().chosenEye = null;
                                    setState(() {});
                                  },
                                  canBeNull: false,
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
                                  canBeNull: false,
                                ),
                                OptionPicker(
                                  label: 'Nose',
                                  selectedOption: PfpManager().chosenNose,
                                  optionList: PfpManager().chosenBody.noseOptions,
                                  lockKey: 'nose',
                                  onSelect: (option) {
                                    PfpManager().chosenNose.chosenVariant = null;
                                    PfpManager().chosenNose = option as SpriteGeneric;
                                    setState(() {});
                                  },
                                  variantLockKey: 'noseVariant',
                                  canBeNull: false,
                                ),
                                OptionPicker(
                                  label: 'Hair style',
                                  selectedOption: PfpManager().chosenHair,
                                  optionList: PfpManager().chosenBody.hairOptions,
                                  lockKey: 'hair',
                                  onSelect: (option) {
                                    PfpManager().chosenHair.chosenVariant = null;
                                    PfpManager().chosenHair = option as SpriteGeneric;
                                    setState(() {});
                                  },
                                  variantLockKey: 'hairVariant',
                                  canBeNull: false,
                                ),
                                OptionPicker(
                                  label: 'Outfit',
                                  selectedOption: PfpManager().chosenOutfit,
                                  optionList: PfpManager().chosenBody.outfitOptions,
                                  lockKey: 'outfit',
                                  onSelect: (option) {
                                    PfpManager().chosenOutfit.chosenVariant = null;
                                    PfpManager().chosenOutfit = option as SpriteGeneric;
                                    setState(() {});
                                  },
                                  variantLockKey: 'outfitVariant',
                                  onVariantSelect: (option) {
                                    if (option == 'none') {
                                      PfpManager().chosenOutfit.chosenVariant = null;
                                    } else {
                                      PfpManager().chosenOutfit.chosenVariant = option;
                                    }
                                    setState(() {});
                                  },
                                  canBeNull: false,
                                ),
                                OptionPicker(
                                  label: 'Back accessory',
                                  selectedOption: PfpManager().chosenBackAccessory,
                                  optionList: PfpManager().optionsBackAccessory,
                                  lockKey: 'backAccessory',
                                  onSelect: (option) {
                                    if (PfpManager().chosenBackAccessory != null) {
                                      PfpManager().chosenBackAccessory!.chosenVariant = null;
                                    }
                                    if (option != null) {
                                      if (option != 'none') {
                                        PfpManager().chosenBackAccessory = option as SpriteGeneric;
                                      } else {
                                        PfpManager().chosenBackAccessory = null;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  variantLockKey: 'backAccessoryVariant',
                                  canBeNull: true,
                                ),
                                OptionPicker(
                                  label: 'Face accessory',
                                  selectedOption: PfpManager().chosenFaceAccessory,
                                  optionList: PfpManager().chosenBody.faceAccessoryOptions,
                                  lockKey: 'faceAccessory',
                                  onSelect: (option) {
                                    if (PfpManager().chosenFaceAccessory != null) {
                                      PfpManager().chosenFaceAccessory!.chosenVariant = null;
                                    }
                                    if (option != null) {
                                      if (option != 'none') {
                                        PfpManager().chosenFaceAccessory = option as SpriteGeneric;
                                      } else {
                                        PfpManager().chosenFaceAccessory = null;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  variantLockKey: 'faceAccessoryVariant',
                                  canBeNull: true,
                                ),
                                OptionPicker(
                                  label: 'Eyes / Eye accessory',
                                  selectedOption: PfpManager().chosenEye,
                                  optionList: PfpManager().chosenBody.eyeOptions,
                                  lockKey: 'eyes',
                                  onSelect: (option) {
                                    if (PfpManager().chosenEye != null) {
                                      PfpManager().chosenEye!.chosenVariant = null;
                                    }
                                    if (option != null) {
                                      if (option != 'none') {
                                        PfpManager().chosenEye = option as SpriteGeneric;
                                      } else {
                                        PfpManager().chosenEye = null;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  variantLockKey: 'eyesVariant',
                                  canBeNull: true,
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
                                  canBeNull: false,
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
                                  canBeNull: false,
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
                                  canBeNull: false,
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
                                  canBeNull: false,
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
                                  canBeNull: false,
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
                                  canBeNull: false,
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
                                        selectedSprites: _getSelectedSprites(),
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
                                        SizedBox(
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
                                        selectedSprites: _getSelectedSprites(),
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
                                                const Icon(
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
