import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:walkscape_characters/classes/class_sprite_generic.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';
import 'package:walkscape_characters/providers.dart';
import 'package:walkscape_characters/vars.dart';
import 'package:image/image.dart' as img;

/// Initializes all of the providers with default settings
void initProviders(WidgetRef ref) {
  final body = PfpManager().optionsBody.firstWhere((option) => !option.name.contains('ex_'));
  ref.read(providerChosenBody.notifier).init(
    defaultChoice: body,
    optionList: PfpManager().optionsBody,
    canBeNulled: false,
    type: LayerType.body,
    label: 'Body',
    layer: layerBody,
    colorProviderList: [providerColorSkin],
  );
  ref.read(providerChosenBackground.notifier).init(
      defaultChoice: null,
      optionList: PfpManager().optionsBackground,
      canBeNulled: true,
      type: LayerType.background,
      label: 'Background',
      layer: -1,
      colorProviderList: [providerColorBackground]);
  ref.read(providerChosenBackAccessory.notifier).init(
      defaultChoice: null,
      optionList: PfpManager().optionsBackAccessory,
      canBeNulled: true,
      type: LayerType.backAccessory,
      label: 'Back Accessory',
      layer: layerBackAccessory,
      colorProviderList: []);
  ref.read(providerChosenNose.notifier).init(
      defaultChoice: body.noseOptions.firstWhere((option) => !option.name.contains('ex_')),
      optionList: body.noseOptions,
      canBeNulled: false,
      type: LayerType.nose,
      label: 'Nose',
      layer: layerNose,
      colorProviderList: []);
  ref.read(providerChosenHair.notifier).init(
    defaultChoice: body.hairOptions.firstWhere((option) => !option.name.contains('ex_')),
    optionList: body.hairOptions,
    canBeNulled: false,
    type: LayerType.hair,
    label: 'Hair',
    layer: layerHair,
    colorProviderList: [providerColorHair],
  );
  ref.read(providerChosenFace.notifier).init(
        defaultChoice: body.faceOptions.firstWhere((option) => !option.name.contains('ex_')),
        optionList: body.faceOptions,
        canBeNulled: false,
        type: LayerType.face,
        label: 'Face',
        layer: layerFace,
        colorProviderList: [providerColorEyes, providerColorFacialHair, providerColorEyebrows],
        chosenVariantPath: body.faceOptions.first.variants.values.first,
      );
  ref.read(providerChosenOutfit.notifier).init(
    defaultChoice: body.outfitOptions.firstWhere((option) => !option.name.contains('ex_')),
    optionList: body.outfitOptions,
    canBeNulled: false,
    type: LayerType.outfit,
    label: 'Outfit',
    layer: layerOutfit,
    colorProviderList: [],
  );
  ref.read(providerChosenFaceAccessory.notifier).init(
    defaultChoice: null,
    optionList: body.faceAccessoryOptions,
    canBeNulled: true,
    type: LayerType.faceAccessory,
    label: 'Face Accessory',
    layer: layerFaceAccessory,
    colorProviderList: [],
  );
  ref.read(providerChosenEyes.notifier).init(
    defaultChoice: null,
    optionList: body.eyeOptions,
    canBeNulled: true,
    type: LayerType.eyes,
    label: 'Eyes / Eye Accessory',
    layer: layerEyes,
    colorProviderList: [],
  );
  ref.read(providerChosenHeadwear.notifier).init(
    defaultChoice: null,
    optionList: body.headwearOptions,
    canBeNulled: true,
    type: LayerType.headwear,
    label: 'Headwear',
    layer: layerHeadwear,
    colorProviderList: [],
  );
  ref.read(providerChosenFacepaint.notifier).init(
    defaultChoice: null,
    optionList: body.facepaintOptions,
    canBeNulled: true,
    type: LayerType.facepaint,
    label: 'Face paint',
    layer: layerFacepaint,
    colorProviderList: [providerColorFacepaint],
  );
  ref.read(providerColorBackground.notifier).init(
        defaultPalette: 'red',
        changePalette: 'red',
        typeList: [
          LayerType.background,
        ],
        colorMap: colorOptionsBackground,
        label: 'Background color',
      );
  ref.read(providerColorSkin.notifier).init(
        defaultPalette: 'light',
        changePalette: 'light',
        typeList: [LayerType.body, LayerType.face, LayerType.nose],
        colorMap: colorOptionsSkin,
        label: 'Skin color',
      );
  ref.read(providerColorHair.notifier).init(
        defaultPalette: 'darkest brown',
        changePalette: 'darkest brown',
        typeList: [LayerType.hair, LayerType.headwear],
        colorMap: colorOptionsHair,
        label: 'Hair color',
      );
  ref.read(providerColorFacialHair.notifier).init(
        defaultPalette: 'darker brown',
        changePalette: 'darker brown',
        typeList: [LayerType.face],
        colorMap: colorOptionsFacialHair,
        label: 'Facial hair color',
      );
  ref.read(providerColorEyebrows.notifier).init(
        defaultPalette: 'dark',
        changePalette: 'dark',
        typeList: [LayerType.face],
        colorMap: colorOptionsEyebrowns,
        label: 'Eyebrow color',
      );
  ref.read(providerColorEyes.notifier).init(
        defaultPalette: 'black',
        changePalette: 'black',
        typeList: [LayerType.iris],
        colorMap: colorOptionsEyes,
        label: 'Eye color',
      );
  ref.read(providerColorFacepaint.notifier).init(
        defaultPalette: 'red',
        changePalette: 'red',
        typeList: [LayerType.facepaint],
        colorMap: colorOptionsFacepaint,
        label: 'Face paint color',
      );
}

/// Returns all subfolders from a certain path
List<String> getSubFolders(String path, List<String> imagePaths) {
  final List<String> returnList = [];
  for (var imagePath in imagePaths) {
    if (imagePath.startsWith(path)) {
      var pathToAdd = imagePath.replaceAll(path, '');
      if (pathToAdd.contains('/')) {
        pathToAdd = pathToAdd.split('/')[0];
        if (!returnList.contains(pathToAdd)) {
          returnList.add(pathToAdd);
        }
      }
    }
  }
  return returnList;
}

/// Returns all files in certain path
List<String> getFiles(String path, List<String> imagePaths) {
  final List<String> returnList = [];
  for (var imagePath in imagePaths) {
    if (imagePath.startsWith(path)) {
      var pathToAdd = imagePath.replaceAll(path, '');
      if (!pathToAdd.contains('/')) {
        pathToAdd = pathToAdd.split('/')[0];
        if (!returnList.contains(pathToAdd)) {
          returnList.add(pathToAdd);
        }
      }
    }
  }
  return returnList;
}

/// A function that switches the image color.
Future<Uint8List> switchColorPalette({required String imagePath, required List<Color> existingColors, required List<Color> changeColors}) async {
  late Uint8List imageBytes;

  await rootBundle.load(imagePath).then((data) => imageBytes = data.buffer.asUint8List());

  // Decode the bytes to [Image] type

  final image = img.decodeImage(imageBytes);

  // Convert the [Image] to RGBA formatted pixels
  final pixels = image!.getBytes(order: img.ChannelOrder.rgba);

  // Get the Pixel Length
  final int length = pixels.lengthInBytes;

  for (var i = 0; i < length; i += 4) {
    for (var c = 0; c < existingColors.length; c++) {
      var color = existingColors[c];
      var changeColor = changeColors[c];
      if (pixels[i] == color.red && pixels[i + 1] == color.green && pixels[i + 2] == color.blue) {
        pixels[i] = changeColor.red;
        pixels[i + 1] = changeColor.green;
        pixels[i + 2] = changeColor.blue;
        break;
      }
    }
  }
  return img.encodePng(image);
}

/// A function that paints the facepaint over the face
Future<Uint8List> switchColorPaletteFacepaint(WidgetRef ref) async {
  late Uint8List faceBytes;
  late Uint8List facepaintBytes;
  late Uint8List noseBytes;
  final face = ref.read(providerChosenFace).chosenOption! as SpriteGeneric;
  final facepaint = ref.read(providerChosenFacepaint).chosenOption! as SpriteGeneric;
  final nose = ref.read(providerChosenNose).chosenOption! as SpriteGeneric;
  await rootBundle.load(facepaint.spritePath).then((data) => facepaintBytes = data.buffer.asUint8List());
  await rootBundle.load(face.spritePath).then((data) => faceBytes = data.buffer.asUint8List());
  await rootBundle.load(nose.spritePath).then((data) => noseBytes = data.buffer.asUint8List());

  // Decode the bytes to [Image] type
  final faceImage = img.decodeImage(faceBytes);
  final facepaintImage = img.decodeImage(facepaintBytes);
  final noseImage = img.decodeImage(noseBytes);

  // Convert the [Image] to RGBA formatted pixels
  final facePixels = faceImage!.getBytes(order: img.ChannelOrder.rgba);
  final facepaintPixels = facepaintImage!.getBytes(order: img.ChannelOrder.rgba);
  final nosePixels = noseImage!.getBytes(order: img.ChannelOrder.rgba);

  // Get default skin palette
  final skinPalette = colorOptionsSkin[ref.read(providerColorSkin).defaultPalette];

  // Get currently chosen facepaint palette
  final facepaintPalette = colorOptionsFacepaint[ref.read(providerColorFacepaint).changePalette];

  // Get the Pixel Length
  final int pixelLength = facepaintPixels.lengthInBytes;

  /// Go through the facepaint layer. Where ever there is color, recolor based of the skin layer
  if (skinPalette != null && facepaintPalette != null) {
    for (var i = 0; i < pixelLength; i += 4) {
      var didChange = false;
      // If the pixel isn't transparent
      if (facepaintPixels[i + 3] != 0) {
        // Recolor based on the skin color
        for (var c = 0; c < skinPalette.length; c++) {
          final color = skinPalette[c];
          // print('face: ${facePixels[i]}, palette: ${color.red}');
          /// Check the face & nose for the color
          if ((facePixels[i] == color.red && facePixels[i + 1] == color.green && facePixels[i + 2] == color.blue) ||
              (nosePixels[i] == color.red && nosePixels[i + 1] == color.green && nosePixels[i + 2] == color.blue)) {
            facepaintPixels[i] = facepaintPalette[c].red;
            facepaintPixels[i + 1] = facepaintPalette[c].green;
            facepaintPixels[i + 2] = facepaintPalette[c].blue;
            didChange = true;
            break;
          }
        }
        // If the color didn't change, make the pixel transparent
        if (!didChange) {
          // Change the alpha to 0
          facepaintPixels[i + 3] = 0;
        }
      }
    }
  }
  return img.encodePng(facepaintImage);
}

Size getSpriteSize(BuildContext context) {
  return ResponsiveBreakpoints.of(context).isDesktop ? const Size(128, 128) : const Size(64, 64);
}

/// Option list for sprites
List<Widget> getOptionList({
  required BuildContext context,
  required WidgetRef ref,
  required StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass> provider,
}) {
  final returnList = <Widget>[];
  for (var option in ref.read(provider).list) {
    returnList.add(Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            Image.asset(
              option.spritePath,
              width: getSpriteSize(context).width,
              height: getSpriteSize(context).height,
              filterQuality: FilterQuality.none,
              scale: 0.1,
            ),
            Padding(
              padding: EdgeInsets.only(left: ResponsiveBreakpoints.of(context).isDesktop ? 30 : 10),
              child: Text(option.name),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FilledButton(
                  onPressed: () {
                    ref.read(provider.notifier).change(option, ref);
                    Navigator.pop(context);
                  },
                  child: const Text('Choose')),
            )
          ],
        ),
      ),
    ));
  }
  return returnList;
}

/// Option list for colors
List<Widget> getColorList({
  required BuildContext context,
  required WidgetRef ref,
  required StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass> provider,
}) {
  final returnList = <Widget>[];
  for (var colorEntry in ref.read(provider).colorMap.entries) {
    returnList.add(Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  for (var color in colorEntry.value)
                    Container(
                      width: ResponsiveBreakpoints.of(context).isDesktop ? 24 : 16,
                      height: ResponsiveBreakpoints.of(context).isDesktop ? 24 : 16,
                      decoration: BoxDecoration(color: color),
                    )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: ResponsiveBreakpoints.of(context).isDesktop ? 30 : 10),
              child: Text(colorEntry.key),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FilledButton(
                  onPressed: () {
                    ref.read(provider.notifier).change(colorEntry.key, ref);
                    Navigator.pop(context);
                  },
                  child: const Text('Choose')),
            )
          ],
        ),
      ),
    ));
  }
  return returnList;
}

/// Option list for variants
List<Widget> getVariantList({
  required BuildContext context,
  required WidgetRef ref,
  required StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass> provider,
}) {
  final returnList = <Widget>[];
  for (var variantEntry in (ref.read(provider).chosenOption as SpriteGeneric).variants.entries) {
    returnList.add(Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            Image.asset(
              variantEntry.value,
              width: getSpriteSize(context).width,
              height: getSpriteSize(context).height,
              filterQuality: FilterQuality.none,
              scale: 0.1,
            ),
            Padding(
              padding: EdgeInsets.only(left: ResponsiveBreakpoints.of(context).isDesktop ? 30 : 10),
              child: Text(variantEntry.key),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FilledButton(
                  onPressed: () {
                    ref.read(provider.notifier).changeVariant(variantEntry.value);
                    Navigator.pop(context);
                  },
                  child: const Text('Choose')),
            )
          ],
        ),
      ),
    ));
  }
  // Add default if this isn't a face
  if (ref.read(provider).type != LayerType.face) {
    returnList.add(Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            Image.asset(
              ref.read(provider).chosenOption!.spritePath,
              width: getSpriteSize(context).width,
              height: getSpriteSize(context).height,
              filterQuality: FilterQuality.none,
              scale: 0.1,
            ),
            Padding(
              padding: EdgeInsets.only(left: ResponsiveBreakpoints.of(context).isDesktop ? 30 : 10),
              child: const Text('default'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FilledButton(
                  onPressed: () {
                    ref.read(provider.notifier).changeVariant(null);
                    Navigator.pop(context);
                  },
                  child: const Text('Choose')),
            )
          ],
        ),
      ),
    ));
  }
  return returnList;
}

/// Opens choice sheet
void openChoiceSheet({
  required BuildContext context,
  required WidgetRef ref,
  StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>? optionProvider,
  StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>? colorProvider,
  bool? variant,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: variant != true
            ? Column(
                children: optionProvider != null
                    ? getOptionList(context: context, ref: ref, provider: optionProvider)
                    : getColorList(context: context, ref: ref, provider: colorProvider!),
              )
            : Column(
                children: getVariantList(context: context, ref: ref, provider: optionProvider!),
              ),
      );
    },
  );
}

/// Sorts two string by names
int sortByNames(String a, String b) {
  if (a.length > b.length) {
    return 1;
  }
  return a.toLowerCase().compareTo(b.toLowerCase());
}
