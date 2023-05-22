import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:walkscape_characters/option_interface.dart';
import 'package:image/image.dart' as img;
import 'package:walkscape_characters/vars.dart';

/// Manager that controls the profile picture options and loads them.
const rootFolder = 'assets/pfp/';
final List<String> imagePaths = [];

class PfpManager {
  PfpManager._privateConstructor();
  static final PfpManager _instance = PfpManager._privateConstructor();

  factory PfpManager() {
    return _instance;
  }

  final List<SpriteBody> optionsBody = [];
  late SpriteBody chosenBody;
  late SpriteFace chosenFace;
  late String chosenExpression;
  late SpriteGeneric chosenNose;
  late SpriteGeneric chosenHair;
  late SpriteGeneric chosenOutfit;
  late String colorBg;
  late String colorSkin;

  /// Loads all image paths from certain path
  Future<void> _loadAllFiles(String path) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final images = manifestMap.keys;
    for (var path in images) {
      if (path.startsWith(path)) {
        imagePaths.add(path);
      }
    }
  }

  /// Initializes the PFP options by loading them from /assets and adding them to data structures
  Future<void> initPfp() async {
    await _loadAllFiles(rootFolder);
    // Get folders containing bodies. Remove back_accessories from the list to only count for bodies.
    final bodyFolders = getSubFolders(rootFolder, imagePaths);
    bodyFolders.remove('back_accessories');
    for (var folder in bodyFolders) {
      final addedBody = SpriteBody(name: folder, spritePath: '$rootFolder$folder/bodies/body.png', layer: 0);
      optionsBody.add(addedBody);
      addedBody.init(folder);
    }
    chosenBody = optionsBody[0];
    chosenFace = chosenBody.faceOptions.first;
    chosenExpression = chosenFace.expressionOptions.keys.first;
    chosenNose = chosenBody.noseOptions.first;
    chosenHair = chosenBody.hairOptions.first;
    chosenOutfit = chosenBody.outfitOptions.first;
    // Default colors
    colorBg = colorOptionsBackground.keys.first;
    colorSkin = colorOptionsSkin.keys.first;
  }
}

class SpriteBody implements OptionInterface {
  SpriteBody({required this.name, required this.spritePath, required this.layer});
  @override
  final String name;
  @override
  final String spritePath;
  @override
  final int layer;

  String folderPath = '';
  final List<SpriteFace> faceOptions = [];
  final List<SpriteGeneric> noseOptions = [];
  final List<SpriteGeneric> hairOptions = [];
  final List<SpriteGeneric> outfitOptions = [];

  void init(String folder) {
    folderPath = folder;
    final faceFolders = getSubFolders('$rootFolder$folder/face/', imagePaths);
    for (var face in faceFolders) {
      var path = '$rootFolder$folder/face/$face/';
      var faceAdded = SpriteFace(name: face, spritePath: '', layer: 2);
      faceOptions.add(faceAdded);
      faceAdded.init(path, face);
    }
    addGeneric('$rootFolder$folder/noses/', noseOptions, 3);
    addGeneric('$rootFolder$folder/hairs/', hairOptions, 4);
    addGeneric('$rootFolder$folder/outfit/', outfitOptions, 1);
  }

  void addGeneric(String fileFolder, List<SpriteGeneric> list, int layer) {
    final files = getFiles(fileFolder, imagePaths);
    for (var option in files) {
      var path = '$fileFolder/$option';
      var optionAdded = SpriteGeneric(name: option.replaceAll('.png', ''), spritePath: path, layer: layer);
      list.add(optionAdded);
    }
  }
}

class SpriteFace implements OptionInterface {
  SpriteFace({required this.name, required this.spritePath, required this.layer});
  @override
  final String name;
  @override
  final String spritePath;
  @override
  final int layer;

  String folderPath = '';
  final Map<String, String> expressionOptions = {};
  void init(String folder, String face) {
    folderPath = folder;
    var expressions = getFiles(folder, imagePaths);
    for (var expression in expressions) {
      expressionOptions.addAll({expression.replaceAll('.png', ''): folder + expression});
      //expressionOptions.addAll({expression.replaceAll('.png', ''): SpriteFace(name: face, spritePath: folder + expression, layer: 1)});
    }
  }
}

class SpriteGeneric implements OptionInterface {
  SpriteGeneric({required this.name, required this.spritePath, required this.layer});
  @override
  final String name;
  @override
  final String spritePath;
  @override
  final int layer;
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
