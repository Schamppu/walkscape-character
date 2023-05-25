import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:walkscape_characters/character_image.dart';
import 'package:walkscape_characters/classes/class_sprite_generic.dart';
import 'package:walkscape_characters/option_picker/option_picker_card.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';
import 'package:walkscape_characters/providers.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:universal_html/html.dart' as html;

double getCardWidth() {
  return 270.0;
}

class PageCharacterCreator extends ConsumerWidget {
  PageCharacterCreator({super.key, required this.title});
  final String title;
  final _controller = WidgetsToImageController();
  final chosenView = 0;

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
    var bytes = await _controller.capture();

    if (bytes != null) {
      download(bytes, downloadName: 'ws_character.png');
    }
  }

  List<StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>> _getSelectedSprites() {
    return PfpManager().optionProviders;
  }

  /// Randomizes all of the options
  void _randomize(WidgetRef ref) {
    for (var provider in PfpManager().optionProviders) {
      ref.read(provider.notifier).randomize(ref);
    }
  }

  void _randomizeVariant(SpriteGeneric? sprite, SpriteGeneric? previousSprite, String variantLockKey) {
    if (previousSprite != null && !PfpManager().lockedOptions[variantLockKey]!) {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
              title,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      padding: ResponsiveBreakpoints.of(context).isDesktop ? null : const EdgeInsets.symmetric(vertical: 140),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var provider in PfpManager().optionProviders)
                            OptionPickerCard(
                              provider: provider,
                              label: ref.read(provider).label,
                              width: getCardWidth(),
                              optionLockKey: ref.read(provider).type,
                            )
                        ],
                      ),
                    ),
                  ),
                  // Desktop view
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
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: FilledButton(
                                      onPressed: () {
                                        _randomize(ref);
                                      },
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
                                ),
                              ],
                            ),
                          ),
                        )
                      // Mobile view
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
                                Expanded(
                                  child: SizedBox(
                                    height: 128,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            FilledButton(
                                                onPressed: () {
                                                  _randomize(ref);
                                                },
                                                style: ElevatedButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.zero),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
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
                                      ],
                                    ),
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
