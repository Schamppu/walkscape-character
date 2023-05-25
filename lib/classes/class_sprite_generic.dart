import 'package:walkscape_characters/classes/option_interface.dart';

/// A generic layer sprite
class SpriteGeneric implements OptionInterface {
  SpriteGeneric({required this.name, required this.spritePath, required this.layer, this.supplementaryLayer, required this.type});
  @override
  final String name;
  @override
  final String spritePath;
  @override
  final int layer;

  /// For supplementary sprites that should be drawn to other layers
  String? supplementaryPath;

  Map<String, String> variants = {};
  String? chosenVariant;

  /// The layer index of the supplementary layers
  final int? supplementaryLayer;

  final String type;
}
