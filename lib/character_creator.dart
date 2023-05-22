import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:walkscape_characters/character_image.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:image_downloader_web/image_downloader_web.dart';

class PageCharacterCreator extends StatefulWidget {
  const PageCharacterCreator({super.key, required this.title});
  final String title;

  @override
  State<PageCharacterCreator> createState() => _PageCharacterCreatorState();
}

class _PageCharacterCreatorState extends State<PageCharacterCreator> {
  WidgetsToImageController _controller = WidgetsToImageController();
  Uint8List? bytes;

  Future<void> _saveImage() async {
    bytes = await _controller.capture();
    if (bytes != null) {
      await WebImageDownloader.downloadImageFromUInt8List(uInt8List: bytes!, name: 'walkscape_character');
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
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
