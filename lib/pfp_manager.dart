import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:walkscape_characters/option_interface.dart';

/// Manager that controls the profile picture options and loads them.
class PfpManager {
  PfpManager._privateConstructor();
  static final PfpManager _instance = PfpManager._privateConstructor();

  factory PfpManager() {
    return _instance;
  }

  final List<String> imagePaths = [];
  final List<SpriteBody> optionsBody = [];
  late SpriteBody chosenBody;

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

  /// Returns all subfolders from a certain path
  List<String> _getSubFolders(String path) {
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

  /// Initializes the PFP options by loading them from /assets and adding them to data structures
  Future<void> initPfp() async {
    final rootFolder = 'assets/pfp/';
    await _loadAllFiles(rootFolder);
    // Get folders containing bodies. Remove back_accessories from the list to only count for bodies.
    final bodyFolders = _getSubFolders(rootFolder);
    bodyFolders.remove('back_accessories');
    for (var folder in bodyFolders) {
      optionsBody.add(SpriteBody(name: folder, spritePath: '$rootFolder$folder/bodies/body.png', layer: 0));
    }
    chosenBody = optionsBody[0];
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
}
