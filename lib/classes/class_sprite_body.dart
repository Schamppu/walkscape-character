import 'package:walkscape_characters/classes/class_sprite_generic.dart';
import 'package:walkscape_characters/classes/option_interface.dart';
import 'package:walkscape_characters/functions.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';
import 'package:walkscape_characters/vars.dart';

/// Body layer sprite. Also controls the options, as they are dependent on the body.
class SpriteBody implements OptionInterface {
  SpriteBody({required this.name, required this.spritePath, required this.layer});
  @override
  final String name;
  @override
  final String spritePath;
  @override
  final int layer;

  String folderPath = '';
  final List<SpriteGeneric> faceOptions = [];
  final List<SpriteGeneric> noseOptions = [];
  final List<SpriteGeneric> hairOptions = [];
  final List<SpriteGeneric> outfitOptions = [];
  final List<SpriteGeneric> eyeOptions = [];
  final List<SpriteGeneric> faceAccessoryOptions = [];
  String irisPath = '';

  void init(String folder) {
    folderPath = folder;
    final faceFolders = getSubFolders('$rootFolder$folder/face/', imagePaths);
    // Add faces
    for (var face in faceFolders) {
      var path = '$rootFolder$folder/face/$face/';
      var faceAdded = SpriteGeneric(name: face, spritePath: '$rootFolder$folder/face/$face/normal.png', layer: layerFace, type: 'face');
      faceOptions.add(faceAdded);
      folderPath = folder;
      var expressions = getFiles(path, imagePaths);
      for (var expression in expressions) {
        faceAdded.variants.addAll({expression.replaceAll('.png', ''): path + expression});
      }
    }
    // Add other generic things
    addGeneric('$rootFolder$folder/noses/', noseOptions, layerNose, null, 'nose');
    addGeneric('$rootFolder$folder/hairs/', hairOptions, layerNose, layerHairSupp, 'hair');
    addGeneric('$rootFolder$folder/outfit/', outfitOptions, layerOutfit, null, 'outfit');
    addGeneric('$rootFolder$folder/eyes/', eyeOptions, layerEyes, null, 'eyes');
    addGeneric('$rootFolder$folder/face_accessories/', faceAccessoryOptions, layerFaceAccessory, null, 'faceAccessory');
    faceOptions.sort(sortByNames);
    noseOptions.sort(sortByNames);
    hairOptions.sort(sortByNames);
    outfitOptions.sort(sortByNames);
    eyeOptions.sort(sortByNames);
    faceAccessoryOptions.sort(sortByNames);
    irisPath = '$rootFolder$folder/iris/iris.png';
    for (var nose in noseOptions) {
      print(nose.spritePath);
    }
  }

  int sortByNames(OptionInterface a, OptionInterface b) {
    if (a.name.length > b.name.length) {
      return 1;
    }
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }
}
