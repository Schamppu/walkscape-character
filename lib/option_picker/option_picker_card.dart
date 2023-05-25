import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkscape_characters/classes/class_sprite_generic.dart';
import 'package:walkscape_characters/option_picker/option_picker_choice.dart';
import 'package:walkscape_characters/option_picker/option_picker_variant.dart';
import 'package:walkscape_characters/option_picker/option_picker_label.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';
import 'package:walkscape_characters/providers.dart';

/// Card for picking options
class OptionPickerCard extends ConsumerWidget {
  const OptionPickerCard({super.key, required this.provider, required this.label, required this.width, this.optionLockKey});
  final StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass> provider;
  final String label;
  final double width;
  final LayerType? optionLockKey;

  Widget _getVariantPicker(WidgetRef ref) {
    if (ref.read(provider).chosenOption.runtimeType == SpriteGeneric) {
      if ((ref.read(provider).chosenOption as SpriteGeneric).variants.isNotEmpty) {
        return OptionPickerVariant(provider: provider);
      }
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final sprite = ref.watch(provider).chosenOption;
    return Row(
      // Center the card
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Draw the card itself
        Card(
          child: SizedBox(
            // Constraint the card to the preset width
            width: width,
            child: ExpandablePanel(
              // Rendering the label
              header: OptionPickerLabel(
                label: label,
                lockKey: optionLockKey,
              ),
              collapsed: const SizedBox.shrink(),
              theme: ExpandableThemeData(
                  inkWellBorderRadius: BorderRadius.circular(10),
                  iconColor: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                      : Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
              expanded: Column(
                children: [
                  // Rendering the option
                  OptionPickerChoice(provider: provider),
                  for (var colorProvider in ref.read(provider).colorProviderList) OptionPickerChoice(provider: colorProvider),
                  _getVariantPicker(ref),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
