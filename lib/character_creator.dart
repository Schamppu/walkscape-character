import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
                              OptionPicker(
                                label: 'Body type',
                                selectedOption: PfpManager().chosenBody,
                                optionList: PfpManager().optionsBody,
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
                                onSelect: (option) {
                                  PfpManager().chosenNose = option as SpriteGeneric;
                                  setState(() {});
                                },
                              ),
                              OptionPicker(
                                label: 'Hair style',
                                selectedOption: PfpManager().chosenHair,
                                optionList: PfpManager().chosenBody.hairOptions,
                                onSelect: (option) {
                                  PfpManager().chosenHair = option as SpriteGeneric;
                                  setState(() {});
                                },
                              ),
                              OptionPicker(
                                label: 'Outfit',
                                selectedOption: PfpManager().chosenOutfit,
                                optionList: PfpManager().chosenBody.outfitOptions,
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
                              OptionPicker(
                                label: 'Background color',
                                colorList: colorOptionsBackground,
                                selectedColor: PfpManager().colorBg,
                                onSelect: (option) {
                                  PfpManager().colorBg = option as String;
                                  setState(() {});
                                },
                              ),
                              OptionPicker(
                                label: 'Skin color',
                                colorList: colorOptionsSkin,
                                selectedColor: PfpManager().colorSkin,
                                onSelect: (option) {
                                  PfpManager().colorSkin = option as String;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: SizedBox(
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
