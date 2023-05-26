import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkscape_characters/classes/class_sprite_body.dart';
import 'package:walkscape_characters/classes/class_sprite_generic.dart';
import 'package:walkscape_characters/classes/option_interface.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';

/// Class for a pfp option provider
class ProviderOptionInterfaceClass {
  const ProviderOptionInterfaceClass(
      {this.chosenOption,
      required this.list,
      required this.canBeNulled,
      required this.type,
      required this.label,
      required this.layer,
      required this.colorProviderList,
      this.chosenVariantPath});
  final OptionInterface? chosenOption;
  final List<OptionInterface> list;
  final bool canBeNulled;
  final LayerType type;
  final String label;
  final int layer;
  final List<StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>> colorProviderList;
  final String? chosenVariantPath;

  ProviderOptionInterfaceClass copyWith({
    OptionInterface? chosenOption,
    List<OptionInterface>? list,
    bool? canBeNulled,
    LayerType? type,
    String? label,
    int? layer,
    List<StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>>? colorProviderList,
    String? chosenVariantPath,
  }) {
    return ProviderOptionInterfaceClass(
      chosenOption: chosenOption,
      list: list ?? this.list,
      canBeNulled: canBeNulled ?? this.canBeNulled,
      type: type ?? this.type,
      label: label ?? this.label,
      layer: layer ?? this.layer,
      colorProviderList: colorProviderList ?? this.colorProviderList,
      chosenVariantPath: chosenVariantPath,
    );
  }
}

/// Provider notifier for a pfp option
class ProviderOptionInterfaceNotifier extends StateNotifier<ProviderOptionInterfaceClass> {
  ProviderOptionInterfaceNotifier()
      : super(const ProviderOptionInterfaceClass(
            chosenOption: null, list: [], canBeNulled: false, type: LayerType.body, label: '', layer: -1, colorProviderList: [], chosenVariantPath: null));

  /// Chooses the next option in the list
  void next(WidgetRef ref) {
    ProviderOptionInterfaceClass? changeOption;
    if (state.chosenOption != null) {
      // Get the index of the currently chosen option
      var index = state.list.indexOf(state.chosenOption!);
      if (index != -1) {
        if (index < state.list.length - 1) {
          // If it's not the last item, just pick the next one
          changeOption = state.copyWith(chosenOption: state.list[index + 1]);
        } else {
          if (state.canBeNulled == true) {
            // If the list can be nulled, null it
            changeOption = state.copyWith(chosenOption: null);
          } else {
            // Otherwise, choose the first option if the list can't be nulled
            changeOption = state.copyWith(chosenOption: state.list.first);
          }
        }
      } else {
        // If nothing was found, choose the first option
        changeOption = state.copyWith(chosenOption: state.list.first);
      }
    } else {
      // If the option is null, choose the first option in the list
      changeOption = state.copyWith(chosenOption: state.list.first);
    }
    // Also set the face expression to previous one if face is changing
    if (state.type == LayerType.face) {
      state = state.copyWith(chosenOption: changeOption.chosenOption, chosenVariantPath: (changeOption.chosenOption as SpriteGeneric).variants.values.first);
    } else {
      state = changeOption;
    }
    resetBody(ref);
  }

  /// Chooses the previous option in the list
  void previous(WidgetRef ref) {
    ProviderOptionInterfaceClass? changeOption;
    if (state.chosenOption != null) {
      // Get the index of the currently chosen option
      var index = state.list.indexOf(state.chosenOption!);
      if (index != -1) {
        if (index > 0) {
          // If it's not the first item, just pick the previous one
          changeOption = state.copyWith(chosenOption: state.list[index - 1]);
        } else {
          if (state.canBeNulled) {
            // If the list can be nulled, null it
            changeOption = state.copyWith(chosenOption: null);
          } else {
            // Otherwise, choose the last option if the list can't be nulled
            changeOption = state.copyWith(chosenOption: state.list.last);
          }
        }
      } else {
        // If nothing was found, choose the last option
        changeOption = state.copyWith(chosenOption: state.list.last);
      }
    } else {
      // If the option is null, choose the last option in the list
      changeOption = state.copyWith(chosenOption: state.list.last);
    }
    // Also set the face expression to previous one if face is changing
    if (state.type == LayerType.face) {
      state = state.copyWith(chosenOption: changeOption.chosenOption, chosenVariantPath: (changeOption.chosenOption as SpriteGeneric).variants.values.first);
    } else {
      state = changeOption;
    }
    resetBody(ref);
  }

  /// Resets to default
  void reset(WidgetRef ref) {
    var body = (ref.read(providerChosenBody).chosenOption as SpriteBody);
    if (state.chosenOption.runtimeType == SpriteGeneric) {
      // Reset everything depending on which generic sprite this is
      (state.chosenOption as SpriteGeneric).type == 'nose'
          ? state = state.copyWith(
              chosenOption: body.noseOptions.firstWhere((option) => !option.name.contains('ex_')),
              list: body.noseOptions.where((option) => !option.name.contains('ex_') || PfpManager().developer).toList(),
              chosenVariantPath: null,
            )
          : null;
      (state.chosenOption as SpriteGeneric).type == 'hair'
          ? state = state.copyWith(
              chosenOption: body.hairOptions.firstWhere((option) => !option.name.contains('ex_')),
              list: body.hairOptions.where((option) => !option.name.contains('ex_') || PfpManager().developer).toList(),
              chosenVariantPath: null,
            )
          : null;
      (state.chosenOption as SpriteGeneric).type == 'face'
          ? state = state.copyWith(
              chosenOption: body.faceOptions.firstWhere((option) => !option.name.contains('ex_')),
              list: body.faceOptions.where((option) => !option.name.contains('ex_') || PfpManager().developer).toList(),
              chosenVariantPath: body.faceOptions.first.variants.values.first,
            )
          : null;
      (state.chosenOption as SpriteGeneric).type == 'faceAccessory'
          ? state = state.copyWith(
              chosenOption: body.faceAccessoryOptions.firstWhere((option) => !option.name.contains('ex_')),
              list: body.faceAccessoryOptions.where((option) => !option.name.contains('ex_') || PfpManager().developer).toList(),
              chosenVariantPath: null,
            )
          : null;
      (state.chosenOption as SpriteGeneric).type == 'eyes'
          ? state = state.copyWith(
              chosenOption: body.eyeOptions.firstWhere((option) => !option.name.contains('ex_')),
              list: body.eyeOptions.where((option) => !option.name.contains('ex_') || PfpManager().developer).toList(),
              chosenVariantPath: null,
            )
          : null;
      (state.chosenOption as SpriteGeneric).type == 'outfit'
          ? state = state.copyWith(
              chosenOption: body.outfitOptions.firstWhere((option) => !option.name.contains('ex_')),
              list: body.outfitOptions.where((option) => !option.name.contains('ex_') || PfpManager().developer).toList(),
              chosenVariantPath: null,
            )
          : null;
      (state.chosenOption as SpriteGeneric).type == 'facepaint'
          ? state = state.copyWith(
              chosenOption: body.facepaintOptions.firstWhere((option) => !option.name.contains('ex_')),
              list: body.facepaintOptions.where((option) => !option.name.contains('ex_') || PfpManager().developer).toList(),
              chosenVariantPath: null,
            )
          : null;
    }
  }

  /// Choosen a random option
  void randomize(WidgetRef ref) {
    // Check if the option is locked
    if (!PfpManager().lockedOptions[state.type]!) {
      if (state.canBeNulled != true || Random().nextInt(state.type == LayerType.background ? 2 : 5) == 0) {
        // If not a body, just choose a new type
        if (state.type != LayerType.body && state.list.isNotEmpty) {
          state = state.copyWith(chosenOption: state.list[Random().nextInt(state.list.length)]);
        }
        // Choose variants for generic sprites
        if (state.chosenOption.runtimeType == SpriteGeneric) {
          final sprite = (state.chosenOption as SpriteGeneric);
          if (sprite.variants.isNotEmpty) {
            if (Random().nextInt(sprite.variants.length + 1) == 0 && state.type != LayerType.face) {
              state = state.copyWith(chosenOption: state.chosenOption, chosenVariantPath: null);
            } else {
              state = state.copyWith(chosenOption: state.chosenOption, chosenVariantPath: sprite.variants.values.toList()[Random().nextInt(sprite.variants.length)]);
            }
          }
        }
      } else {
        state = state.copyWith(chosenOption: null);
      }
      // Choose a random color
      for (var colorProvider in state.colorProviderList) {
        ref.read(colorProvider.notifier).randomize();
      }
    }
  }

  /// Resets all choices when body is changed
  void resetBody(WidgetRef ref) {
    // Only do the reset if this is a body sprite
    if (state.chosenOption.runtimeType == SpriteBody) {
      for (var provider in PfpManager().optionProviders) {
        ref.read(provider.notifier).reset(ref);
      }
    }
  }

  /// Change to other option
  void change(OptionInterface sprite, WidgetRef ref) {
    final changeOption = state.copyWith(chosenOption: sprite);
    if (state.type == LayerType.face) {
      state = state.copyWith(chosenOption: changeOption.chosenOption, chosenVariantPath: (changeOption.chosenOption as SpriteGeneric).variants.values.first);
    } else {
      state = changeOption;
    }
    resetBody(ref);
  }

  /// Change to other option
  void changeVariant(String? path) {
    state = state.copyWith(chosenOption: state.chosenOption, chosenVariantPath: path);
  }

  /// Nullify
  void nullify() {
    state = state.copyWith(chosenOption: null);
  }

  // Initialise the provider
  void init({
    required OptionInterface? defaultChoice,
    required List<OptionInterface> optionList,
    required bool canBeNulled,
    required LayerType type,
    required String label,
    required int layer,
    required List<StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>> colorProviderList,
    String? chosenVariantPath,
  }) {
    // Remvoes all options that have ex_ prefix in their name.
    List<OptionInterface> removeExclusives = List<OptionInterface>.from(optionList).where((option) => !option.name.contains('ex_')).toList();
    state = state.copyWith(
      chosenOption: defaultChoice,
      list: PfpManager().developer ? optionList : removeExclusives,
      canBeNulled: canBeNulled,
      type: type,
      label: label,
      layer: layer,
      colorProviderList: colorProviderList,
      chosenVariantPath: chosenVariantPath,
    );
  }
}

/// Character customisation options
final providerChosenBackground = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenHair = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenBody = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenNose = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenFace = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenOutfit = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenFaceAccessory = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenBackAccessory = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenEyes = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenHeadwear = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());
final providerChosenFacepaint = StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>((ref) => ProviderOptionInterfaceNotifier());

/// Class for a color option
class ProviderColorOptionClass {
  const ProviderColorOptionClass({required this.defaultPalette, required this.changePalette, required this.typeList, required this.colorMap, required this.label});
  final String defaultPalette;
  final String changePalette;
  final List<LayerType> typeList;
  final Map<String, List<Color>> colorMap;
  final String label;

  ProviderColorOptionClass copyWith({String? defaultPalette, String? changePalette, List<LayerType>? typeList, Map<String, List<Color>>? colorMap, String? label}) {
    return ProviderColorOptionClass(
      defaultPalette: defaultPalette ?? this.defaultPalette,
      changePalette: changePalette ?? this.changePalette,
      typeList: typeList ?? this.typeList,
      colorMap: colorMap ?? this.colorMap,
      label: label ?? this.label,
    );
  }
}

/// Provider notifier for a color option
class ProviderColorOptionNotifier extends StateNotifier<ProviderColorOptionClass> {
  ProviderColorOptionNotifier() : super(const ProviderColorOptionClass(defaultPalette: '', changePalette: '', typeList: [], colorMap: {}, label: ''));

  /// Choose the next color
  void next(WidgetRef ref) {
    var index = state.colorMap.keys.toList().indexWhere((color) => color == state.changePalette);
    if (index != -1) {
      if (index < state.colorMap.length - 1) {
        index++;
      } else {
        index = 0;
      }
    }
    state = state.copyWith(changePalette: state.colorMap.entries.toList()[index].key);
  }

  /// Choose the previous color
  void previous(WidgetRef ref) {
    var index = state.colorMap.keys.toList().indexWhere((color) => color == state.changePalette);
    if (index != -1) {
      if (index > 0) {
        index--;
      } else {
        index = state.colorMap.length - 1;
      }
    }
    state = state.copyWith(changePalette: state.colorMap.entries.toList()[index].key);
  }

  /// Change the color
  void change(String color, WidgetRef ref) {
    state = state.copyWith(changePalette: color);
  }

  /// Choosen a random option
  void randomize() {
    state = state.copyWith(changePalette: state.colorMap.entries.toList()[Random().nextInt(state.colorMap.length)].key);
  }

  /// Initialize the palette
  init({
    required String defaultPalette,
    required String changePalette,
    required List<LayerType>? typeList,
    required Map<String, List<Color>> colorMap,
    required String label,
  }) {
    state = state.copyWith(
      defaultPalette: defaultPalette,
      changePalette: changePalette,
      typeList: typeList,
      colorMap: colorMap,
      label: label,
    );
  }
}

// Color option providers
final providerColorBackground = StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>((ref) => ProviderColorOptionNotifier());
final providerColorSkin = StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>((ref) => ProviderColorOptionNotifier());
final providerColorHair = StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>((ref) => ProviderColorOptionNotifier());
final providerColorFacialHair = StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>((ref) => ProviderColorOptionNotifier());
final providerColorEyebrows = StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>((ref) => ProviderColorOptionNotifier());
final providerColorEyes = StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>((ref) => ProviderColorOptionNotifier());
final providerColorFacepaint = StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>((ref) => ProviderColorOptionNotifier());
