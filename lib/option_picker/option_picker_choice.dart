import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walkscape_characters/functions.dart';
import 'package:walkscape_characters/pages/page_character_creator.dart';
import 'package:walkscape_characters/providers.dart';

class OptionPickerChoice extends ConsumerWidget {
  const OptionPickerChoice({super.key, required this.provider});
  final StateNotifierProvider<dynamic, dynamic> provider;

  Widget _getLabel(WidgetRef ref) {
    if (provider.runtimeType == StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>) {
      return Text(ref.read((provider as StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>)).label);
    }
    return const SizedBox.shrink();
  }

  Widget _getColor(WidgetRef ref) {
    final colorProvider = (provider as StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>);
    return (Container(
      margin: const EdgeInsets.only(right: 10),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          color: ref.read(colorProvider).colorMap[ref.read(colorProvider).changePalette]!.last,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white54)),
    ));
  }

  String _getText(WidgetRef ref) {
    if (provider.runtimeType == StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>) {
      if (ref.read((provider as StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>)).chosenOption != null) {
        return ref.read((provider as StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>)).chosenOption!.name;
      }
    }
    if (provider.runtimeType == StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>) {
      return ref.read((provider as StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>)).changePalette;
    }
    return 'none';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(provider);
    return SizedBox(
      width: getCardWidth(),
      child: Column(
        children: [
          _getLabel(ref),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              IconButton(
                  onPressed: () {
                    ref.read(provider.notifier).previous(ref);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              // Choice selection button
              (provider.runtimeType == StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>)
                  // Button for options
                  ? FilledButton(
                      onPressed: () {
                        openChoiceSheet(
                          context: context,
                          ref: ref,
                          optionProvider: (provider as StateNotifierProvider<ProviderOptionInterfaceNotifier, ProviderOptionInterfaceClass>),
                        );
                      },
                      child: Text(_getText(ref)))
                  // Button for colors
                  : OutlinedButton(
                      onPressed: () {
                        openChoiceSheet(
                          context: context,
                          ref: ref,
                          colorProvider: (provider as StateNotifierProvider<ProviderColorOptionNotifier, ProviderColorOptionClass>),
                        );
                      },
                      child: Row(
                        children: [
                          _getColor(ref),
                          Text(_getText(ref)),
                        ],
                      )),
              // Next button
              IconButton(
                  onPressed: () {
                    ref.read(provider.notifier).next(ref);
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
