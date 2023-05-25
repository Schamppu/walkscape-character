import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkscape_characters/classes/class_sprite_body.dart';
import 'package:walkscape_characters/classes/class_sprite_generic.dart';
import 'package:walkscape_characters/functions.dart';
import 'package:walkscape_characters/providers.dart';
import 'package:walkscape_characters/vars.dart';

/// Manager that controls the profile picture options and loads them.
final List<String> imagePaths = [];

enum LayerType {
  background,
  body,
  hair,
  nose,
  backAccessory,
  eyes,
  outfit,
  face,
  faceAccessory,
  iris,
}

class PfpManager {
  PfpManager._privateConstructor();
  static final PfpManager _instance = PfpManager._privateConstructor();

  factory PfpManager() {
    return _instance;
  }

  final List<SpriteGeneric> optionsBackground = [];
  final List<SpriteBody> optionsBody = [];
  final List<SpriteGeneric> optionsBackAccessory = [];

  /// Whether or not the app has already been initialized
  var initialized = false;

  /// List of all option providers
  final List<StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>> optionProviders = [
    providerChosenBackground,
    providerChosenBody,
    providerChosenHair,
    providerChosenNose,
    providerChosenFace,
    providerChosenOutfit,
    providerChosenBackAccessory,
    providerChosenFaceAccessory,
    providerChosenEyes,
  ];

  /// List of all color providers
  final List<StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>> colorProviders = [
    providerColorBackground,
    providerColorSkin,
    providerColorHair,
    providerColorFacialHair,
    providerColorEyebrows,
    providerColorEyes,
  ];

  /// The lock options for locking randomization options
  Map<LayerType, bool> lockedOptions = {
    LayerType.background: false,
    LayerType.body: false,
    LayerType.hair: false,
    LayerType.face: false,
    LayerType.nose: false,
    LayerType.outfit: false,
    LayerType.backAccessory: false,
    LayerType.faceAccessory: false,
    LayerType.eyes: false,
  };

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
    bodyFolders.remove('backgrounds');
    // Add back accessories to their corresponding data structure
    addGeneric('${rootFolder}back_accessories/', optionsBackAccessory, layerBackAccessory, null, 'backAccessories');
    // Add backgrounds to their corresponding data structure
    addGeneric('${rootFolder}backgrounds/', optionsBackground, -1, null, 'background');
    optionsBackground.clear(); // TODO: Take this away so backgrounds can be used
    for (var folder in bodyFolders) {
      final addedBody = SpriteBody(name: folder, spritePath: '$rootFolder$folder/bodies/body.png', layer: layerBody);
      optionsBody.add(addedBody);
      addedBody.init(folder);
    }
  }
}

/// Adds a SpriteGeneric sprite layer
void addGeneric(String fileFolder, List<SpriteGeneric> list, int layer, int? supplementaryLayer, String type) {
  final files = getFiles(fileFolder, imagePaths);
  for (var option in files) {
    var path = '$fileFolder$option';
    var name = option.replaceAll('.png', '');
    if (!name.contains('_var') && !name.contains('_supp')) {
      var optionAdded = SpriteGeneric(name: option.replaceAll('.png', ''), spritePath: path, layer: layer, supplementaryLayer: supplementaryLayer, type: type);
      list.add(optionAdded);
    }
  }
  addVariants(fileFolder, list);
  addSupplementaries(fileFolder, list);
}

/// Add variants to sprites
void addVariants(String fileFolder, List<SpriteGeneric> list) {
  final files = getFiles(fileFolder, imagePaths);
  for (var option in files) {
    var path = '$fileFolder$option';
    var optionName = option.replaceAll('.png', '');
    // Get variants
    if (optionName.contains('_var')) {
      var index = list.indexWhere((sprite) => sprite.name.contains(option.split('_var')[0]));
      if (index != -1) {
        list[index].variants.addAll({'variant ${list[index].variants.length + 1}': path});
      }
    }
  }
}

/// Add variants to sprites
void addSupplementaries(String fileFolder, List<SpriteGeneric> list) {
  final files = getFiles(fileFolder, imagePaths);
  for (var option in files) {
    var path = '$fileFolder$option';
    var optionName = option.replaceAll('.png', '');
    // Get variants
    if (optionName.contains('_supp')) {
      var index = list.indexWhere((sprite) => sprite.name.contains(option.split('_supp')[0]));
      if (index != -1) {
        list[index].supplementaryPath = path;
      }
    }
  }
}
