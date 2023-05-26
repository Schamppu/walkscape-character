import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkscape_characters/classes/class_sprite_body.dart';
import 'package:walkscape_characters/classes/class_sprite_generic.dart';
import 'package:walkscape_characters/classes/option_interface.dart';
import 'package:walkscape_characters/functions.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';
import 'package:walkscape_characters/providers.dart';
import 'package:walkscape_characters/vars.dart';
import 'package:blur/blur.dart';

/// Draws the character image
class CharacterImage extends ConsumerWidget {
  const CharacterImage({super.key, required this.width, required this.height, required this.selectedSprites});
  final double width;
  final double height;
  final List<StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>> selectedSprites;

  /// Gets supplementary layer providers
  StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>? _getSupplementaryProvider(int layer, LayerType type) {
    if (layer == layerHairSupp && type == LayerType.hair) {
      return providerChosenHair;
    }
    if (layer == layerHeadwearSupp && type == LayerType.headwear) {
      return providerChosenHeadwear;
    }
    return null;
  }

  /// Builds a list of SpriteBuilder widgets
  List<Widget> getSprites(BuildContext context, WidgetRef ref) {
    final returnList = <Widget>[];
    for (var i = 0; i < 15; i++) {
      for (var spriteProvider in selectedSprites) {
        if (i == ref.read(spriteProvider).layer) {
          returnList.add(SpriteBuilder(
            spriteProvider: spriteProvider,
            width: width,
            height: height,
            supplementary: false,
          ));
        }
        // If it's a generic layer, check for supplementary layers
        final provider = _getSupplementaryProvider(i, ref.read(spriteProvider).type);
        if (provider != null) {
          returnList.add(SpriteBuilder(spriteProvider: provider, width: width, height: height, supplementary: true));
        }
        // If it's the face layer, also draw the face paint layer over it
        if (i == layerFace) {
          returnList.add(FacepaintBuilder(
            width: width,
            height: height,
          ));
        }
      }
    }
    return returnList;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              BackgroundImage(width: width, height: height),
              Stack(children: getSprites(context, ref)),
            ],
          ),
        )
      ],
    );
  }
}

/// Draws the background to the sprite
class BackgroundImage extends ConsumerWidget {
  const BackgroundImage({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(providerChosenBackground).chosenOption;
    ref.watch(providerColorBackground).changePalette;
    final bg = ref.read(providerChosenBackground).chosenOption;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: colorOptionsBackground[ref.read(providerColorBackground).changePalette]![0]),
      child: bg != null
          ? Stack(
              children: [
                // Background image
                Image.asset(
                  bg.spritePath,
                  width: width,
                  height: height,
                ).blurred(blur: 2, colorOpacity: 0.0),
                // Background gradient
                Container(
                  width: width * 2,
                  height: height * 2,
                  decoration: const BoxDecoration(gradient: RadialGradient(colors: [Colors.transparent, Colors.black54], radius: 0.7)),
                )
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

/// Returns the default color
List<Color> getDefaultColor(StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass> provider, WidgetRef ref) {
  final List<Color> returnList = [];
  for (var colorProvider in PfpManager().colorProviders) {
    if (ref.read(colorProvider).typeList.contains(ref.read(provider).type)) {
      returnList.addAll(ref.read(colorProvider).colorMap[ref.read(colorProvider).defaultPalette]!);
    }
  }
  return returnList;
}

/// Returns the changed color
List<Color> getChangedColor(StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass> provider, WidgetRef ref) {
  final List<Color> returnList = [];
  for (var colorProvider in PfpManager().colorProviders) {
    if (ref.read(colorProvider).typeList.contains(ref.read(provider).type)) {
      returnList.addAll(ref.read(colorProvider).colorMap[ref.read(colorProvider).changePalette]!);
    }
  }
  return returnList;
}

/// Builds a sprite with palette swapping
class SpriteBuilder extends ConsumerWidget {
  const SpriteBuilder({super.key, required this.spriteProvider, required this.width, required this.height, required this.supplementary});
  final double width;
  final double height;
  final StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass> spriteProvider;
  final bool supplementary;

  /// Returns the path of the sprite
  String? _getSpritePath(OptionInterface sprite, WidgetRef ref) {
    if (supplementary) {
      ref.watch(spriteProvider).chosenOption;
      var path = (sprite as SpriteGeneric).spritePath;
      if (ref.read(spriteProvider).chosenVariantPath != null) {
        path = ref.read(spriteProvider).chosenVariantPath!;
      }
      var index = imagePaths.indexWhere((element) => path.replaceAll('.png', '') == element.replaceAll('_bck.png', ''));
      if (index != -1) {
        return imagePaths[index];
      }
    } else {
      if (ref.read(spriteProvider).chosenVariantPath != null) {
        return ref.read(spriteProvider).chosenVariantPath!;
      }
      return sprite.spritePath;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Find the providers that are related to this sprite, and watch them
    for (var colorProvider in PfpManager().colorProviders) {
      if (ref.read(colorProvider).typeList.contains(ref.read(spriteProvider).type)) {
        ref.watch(colorProvider);
      }
    }
    final sprite = ref.watch(spriteProvider).chosenOption;
    // If this is the hair layer also watch if headwear changes
    if (ref.read(spriteProvider).type == LayerType.hair) {
      ref.watch(providerChosenHeadwear).chosenOption;
    }
    final List<Color> defaultColor = getDefaultColor(spriteProvider, ref);
    final List<Color> changeColor = getChangedColor(spriteProvider, ref);
    return (sprite != null &&
            _getSpritePath(sprite, ref) != null &&
            !(ref.read(spriteProvider).type == LayerType.hair && ref.read(providerChosenHeadwear).chosenOption != null))
        ? Stack(
            children: [
              // Sprite
              FutureBuilder(
                future: switchColorPalette(
                  imagePath: _getSpritePath(sprite, ref)!,
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
              ),
              sprite.layer == layerFace
                  ? IrisBuilder(
                      width: width,
                      height: height,
                    )
                  : const SizedBox.shrink(),
            ],
          )
        : const SizedBox.shrink();
  }
}

/// Builds the iris layer
class IrisBuilder extends ConsumerWidget {
  const IrisBuilder({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sprite = ref.watch(providerChosenFace).chosenOption;
    ref.watch(providerColorEyes).changePalette;
    return
        // Iris for the face layer
        sprite!.layer == layerFace
            ? SizedBox(
                child: (!ref.watch(providerChosenFace).chosenVariantPath!.contains('laughing') && !ref.watch(providerChosenFace).chosenVariantPath!.contains('sad'))
                    ? FutureBuilder(
                        future: switchColorPalette(
                          imagePath: (ref.read(providerChosenBody).chosenOption as SpriteBody).irisPath,
                          existingColors: colorOptionsEyes[ref.read(providerColorEyes).defaultPalette]!,
                          changeColors: colorOptionsEyes[ref.read(providerColorEyes).changePalette]!,
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
                      )
                    : const SizedBox.shrink(),
              )
            : const SizedBox.shrink();
  }
}

/// Paints the facepaint over the face
class FacepaintBuilder extends ConsumerWidget {
  const FacepaintBuilder({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Watch the options if they change
    final facepaint = ref.watch(providerChosenFacepaint).chosenOption;
    ref.watch(providerChosenFace).chosenOption;
    ref.watch(providerColorFacepaint).changePalette;
    return SizedBox(
      child: facepaint != null
          ? FutureBuilder(
              future: switchColorPaletteFacepaint(ref),
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
            )
          : const SizedBox.shrink(),
    );
  }
}
