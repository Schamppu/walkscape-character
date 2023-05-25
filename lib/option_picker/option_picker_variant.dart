import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkscape_characters/classes/class_sprite_generic.dart';
import 'package:walkscape_characters/functions.dart';
import 'package:walkscape_characters/pages/page_character_creator.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';
import 'package:walkscape_characters/providers.dart';

class OptionPickerVariant extends ConsumerWidget {
  const OptionPickerVariant({super.key, required this.provider});
  final StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass> provider;

  String _getText(WidgetRef ref) {
    if (ref.read(provider).chosenOption.runtimeType == SpriteGeneric) {
      final variants = (ref.read(provider).chosenOption as SpriteGeneric).variants;
      if (ref.read(provider).chosenVariantPath != null) {
        return variants.entries.firstWhere((entry) => entry.value == ref.read(provider).chosenVariantPath).key;
      }
    }
    return 'none';
  }

  /// Chooses the next variant
  void _previous(WidgetRef ref) {
    if (ref.read(provider).chosenOption.runtimeType == SpriteGeneric) {
      final variants = (ref.read(provider).chosenOption as SpriteGeneric).variants;
      final currentVariant = ref.read(provider).chosenVariantPath;
      var index = -1;
      if (currentVariant != null) {
        index = variants.values.toList().indexWhere((variantPath) => variantPath == currentVariant);
        if (index > 0) {
          index--;
        } else {
          if (ref.read(provider).type == LayerType.face) {
            index = variants.length - 1;
          } else {
            index = -1;
          }
        }
      } else {
        index = variants.length - 1;
      }
      if (index == -1) {
        ref.read(provider.notifier).changeVariant(null);
      } else {
        ref.read(provider.notifier).changeVariant(variants.entries.toList()[index].value);
      }
    }
  }

  /// Chooses the next variant
  void _next(WidgetRef ref) {
    if (ref.read(provider).chosenOption.runtimeType == SpriteGeneric) {
      final variants = (ref.read(provider).chosenOption as SpriteGeneric).variants;
      final currentVariant = ref.read(provider).chosenVariantPath;
      var index = -1;
      if (currentVariant != null) {
        index = variants.values.toList().indexWhere((variantPath) => variantPath == currentVariant);
        if (index < variants.length - 1) {
          index++;
        } else {
          if (ref.read(provider).type == LayerType.face) {
            index = 0;
          } else {
            index = -1;
          }
        }
      } else {
        index = 0;
      }
      if (index == -1) {
        ref.read(provider.notifier).changeVariant(null);
      } else {
        ref.read(provider.notifier).changeVariant(variants.entries.toList()[index].value);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(provider).chosenOption;
    return SizedBox(
      width: getCardWidth(),
      child: Column(
        children: [
          const Text('Variant'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              IconButton(
                  onPressed: () {
                    _previous(ref);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              // Choice selection button
              FilledButton(
                  onPressed: () {
                    openChoiceSheet(context: context, ref: ref, optionProvider: provider, variant: true);
                  },
                  child: Text(_getText(ref))),
              // Next button
              IconButton(
                  onPressed: () {
                    _next(ref);
                  },
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
