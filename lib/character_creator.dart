import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:walkscape_characters/character_image.dart';
import 'package:walkscape_characters/option_picker.dart';
import 'package:walkscape_characters/pfp_manager.dart';
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
        actions: [ElevatedButton(onPressed: _saveImage, child: const Text('Save as .png'))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetsToImage(
                controller: _controller,
                child: CharacterImage(
                  width: 128,
                  height: 128,
                  selectedSprites: [
                    PfpManager().chosenBody,
                  ],
                )),
            OptionPicker(
              selectedOption: PfpManager().chosenBody,
              optionList: PfpManager().optionsBody,
              onSelect: (option) {
                print('test');
                PfpManager().chosenBody = option as SpriteBody;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
