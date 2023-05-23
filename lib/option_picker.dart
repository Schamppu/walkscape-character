import 'dart:js_interop';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:walkscape_characters/character_creator.dart';
import 'package:walkscape_characters/option_interface.dart';
import 'package:walkscape_characters/pfp_manager.dart';
import 'package:walkscape_characters/vars.dart';

class OptionPicker extends StatefulWidget {
  const OptionPicker(
      {super.key,
      this.selectedOption,
      this.optionList,
      required this.onSelect,
      required this.label,
      this.onExpressionSelect,
      this.onVariantSelect,
      this.colorList,
      this.selectedColor,
      required this.lockKey,
      this.variantLockKey});
  final String label;
  final OptionInterface? selectedOption;
  final List<OptionInterface>? optionList;
  final Function(dynamic option) onSelect;
  final Function(String option)? onExpressionSelect;
  final Function(String option)? onVariantSelect;
  final Map<String, List<Color>>? colorList;
  final String? selectedColor;
  final String lockKey;
  final String? variantLockKey;

  @override
  State<OptionPicker> createState() => _OptionPickerState();
}

class _OptionPickerState extends State<OptionPicker> {
  void _openSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 6, maxWidth: 800),
      builder: (context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: widget.colorList.isNull
                  ? Column(
                      children: [
                        for (var option in widget.optionList!)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(color: colorOptionsBackground[PfpManager().colorBg]![0]),
                                    child: ResponsiveBreakpoints.of(context).isDesktop
                                        ? Image.asset(
                                            option.runtimeType == SpriteFace
                                                ? (option as SpriteFace).expressionOptions[PfpManager().chosenExpression]!
                                                : option.spritePath,
                                            width: 128,
                                            height: 128,
                                            scale: 0.01,
                                            filterQuality: FilterQuality.none,
                                          )
                                        : Image.asset(
                                            option.runtimeType == SpriteFace
                                                ? (option as SpriteFace).expressionOptions[PfpManager().chosenExpression]!
                                                : option.spritePath,
                                            width: 64,
                                            height: 64,
                                            scale: 0.01,
                                            filterQuality: FilterQuality.none,
                                          )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(option.name),
                                const Spacer(),
                                FilledButton(
                                    onPressed: () {
                                      widget.onSelect(option);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Select')),
                              ],
                            ),
                          )
                      ],
                    )
                  : Column(
                      children: [
                        for (var colorEntry in widget.colorList!.entries)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                for (var color in colorEntry.value) Container(width: 20, height: 20, decoration: BoxDecoration(color: color)),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(colorEntry.key),
                                const Spacer(),
                                FilledButton(
                                    onPressed: () {
                                      widget.onSelect(colorEntry.key);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Select')),
                              ],
                            ),
                          )
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  /// Shows bottom modal sheet for different variants
  void _openVariantSelectionSheet(BuildContext context, SpriteGeneric sprite) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 6, maxWidth: 800),
      builder: (context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Column(
                  children: [
                    for (var variantEntry in sprite.variants.entries)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(color: colorOptionsBackground[PfpManager().colorBg]![0]),
                                child: ResponsiveBreakpoints.of(context).isDesktop
                                    ? Image.asset(
                                        variantEntry.value,
                                        width: 128,
                                        height: 128,
                                        scale: 0.01,
                                        filterQuality: FilterQuality.none,
                                      )
                                    : Image.asset(
                                        variantEntry.value,
                                        width: 64,
                                        height: 64,
                                        scale: 0.01,
                                        filterQuality: FilterQuality.none,
                                      )),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(variantEntry.key),
                            const Spacer(),
                            FilledButton(
                                onPressed: () {
                                  widget.onVariantSelect!(variantEntry.key);
                                  Navigator.pop(context);
                                },
                                child: const Text('Select')),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(color: colorOptionsBackground[PfpManager().colorBg]![0]),
                              child: ResponsiveBreakpoints.of(context).isDesktop
                                  ? Image.asset(
                                      sprite.spritePath,
                                      width: 128,
                                      height: 128,
                                      scale: 0.01,
                                      filterQuality: FilterQuality.none,
                                    )
                                  : Image.asset(
                                      sprite.spritePath,
                                      width: 64,
                                      height: 64,
                                      scale: 0.01,
                                      filterQuality: FilterQuality.none,
                                    )),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text('none'),
                          const Spacer(),
                          FilledButton(
                              onPressed: () {
                                widget.onVariantSelect!('none');
                                Navigator.pop(context);
                              },
                              child: const Text('Select')),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  /// Returns the previous option in list
  dynamic _getPrevious() {
    dynamic returnValue;
    if (widget.colorList.isNull) {
      var index = widget.optionList!.indexOf(widget.selectedOption!);
      if (index == 0) {
        index = widget.optionList!.length - 1;
      } else {
        index--;
      }
      returnValue = widget.optionList![index];
    } else {
      var index = widget.colorList!.keys.toList().indexOf(widget.selectedColor!);
      if (index == 0) {
        index = widget.colorList!.length - 1;
      } else {
        index--;
      }
      returnValue = widget.colorList!.keys.toList()[index];
    }
    return returnValue;
  }

  /// Returns the next option in list
  dynamic _getNext() {
    dynamic returnValue;
    if (widget.colorList.isNull) {
      var index = widget.optionList!.indexOf(widget.selectedOption!);
      if (index >= widget.optionList!.length - 1) {
        index = 0;
      } else {
        index++;
      }
      returnValue = widget.optionList![index];
    } else {
      var index = widget.colorList!.keys.toList().indexOf(widget.selectedColor!);
      if (index >= widget.colorList!.length - 1) {
        index = 0;
      } else {
        index++;
      }
      returnValue = widget.colorList!.keys.toList()[index];
    }
    return returnValue;
  }

  Widget createVariantMenu(BuildContext context) {
    var sprite = (widget.selectedOption! as SpriteGeneric);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          Text(
            'Variant',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          OutlinedButton(onPressed: () => _openVariantSelectionSheet(context, sprite), child: Text(sprite.chosenVariant ?? 'none')),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    onPressed: () {
                      var index = sprite.variants.entries.toList().indexWhere((entry) => entry.key == sprite.chosenVariant);
                      if (index != -1) {
                        if (index > 0) {
                          widget.onVariantSelect!(sprite.variants.keys.toList()[index - 1]);
                        } else {
                          widget.onVariantSelect!('none');
                        }
                      } else {
                        widget.onVariantSelect!(sprite.variants.keys.last);
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    onPressed: () {
                      var index = sprite.variants.entries.toList().indexWhere((entry) => entry.key == sprite.chosenVariant);
                      if (index != -1) {
                        if (index < sprite.variants.length - 1) {
                          widget.onVariantSelect!(sprite.variants.keys.toList()[index + 1]);
                        } else {
                          widget.onVariantSelect!('none');
                        }
                      } else {
                        widget.onVariantSelect!(sprite.variants.keys.first);
                      }
                    },
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<DropdownMenuEntry<String>> _getVariantList(SpriteGeneric sprite) {
    print('getting variants ${sprite.name}: ${sprite.variants['variant 1']}');
    var list = sprite.variants.keys.map<DropdownMenuEntry<String>>((String value) {
      return DropdownMenuEntry<String>(
        value: value,
        label: value,
        trailingIcon: Image.asset(sprite.variants[value]!),
      );
    }).toList();
    list.add(DropdownMenuEntry<String>(
      value: 'none',
      label: 'none',
      trailingIcon: Image.asset(sprite.spritePath),
    ));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                    child: Stack(
                  children: [
                    SizedBox(
                      width: getCardWidth(),
                      height: 40,
                    ),
                    Positioned.fill(child: Center(child: Text(widget.label))),
                    widget.selectedOption.runtimeType != SpriteBody
                        ? Positioned(
                            right: 0,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    PfpManager().lockedOptions[widget.lockKey] = !PfpManager().lockedOptions[widget.lockKey]!;
                                  });
                                },
                                icon: PfpManager().lockedOptions[widget.lockKey]!
                                    ? Icon(
                                        Icons.lock,
                                        color: Theme.of(context).colorScheme.primary,
                                      )
                                    : Icon(
                                        Icons.lock_open,
                                        color: Theme.of(context).colorScheme.primary,
                                      )))
                        : const SizedBox.shrink()
                  ],
                )),
                const Divider(),
                SizedBox(
                  width: getCardWidth(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            widget.onSelect(_getPrevious());
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      FilledButton(
                          onPressed: () => _openSelectionSheet(context),
                          child: widget.colorList.isNull ? Text(widget.selectedOption!.name) : Text(widget.selectedColor!)),
                      IconButton(
                          onPressed: () {
                            widget.onSelect(_getNext());
                          },
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                    ],
                  ),
                ),
                // Showing the expression selection if picking a face
                widget.selectedOption.runtimeType == SpriteFace
                    ? Column(
                        children: [
                          const Divider(),
                          Stack(
                            children: [
                              SizedBox(
                                width: getCardWidth(),
                                height: 60,
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: DropdownMenu<String>(
                                    enableSearch: false,
                                    enableFilter: false,
                                    initialSelection: PfpManager().chosenExpression,
                                    width: 130,
                                    label: Text(
                                      'Expression',
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                                    ),
                                    dropdownMenuEntries: (widget.selectedOption as SpriteFace).expressionOptions.keys.map<DropdownMenuEntry<String>>((String value) {
                                      return DropdownMenuEntry<String>(
                                        value: value,
                                        label: value,
                                      );
                                    }).toList(),
                                    onSelected: (value) {
                                      if (value != null && widget.onExpressionSelect != null) {
                                        widget.onExpressionSelect!(value);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          PfpManager().lockedOptions['expression'] = !PfpManager().lockedOptions['expression']!;
                                        });
                                      },
                                      icon: PfpManager().lockedOptions['expression']!
                                          ? Icon(
                                              Icons.lock,
                                              color: Theme.of(context).colorScheme.primary,
                                            )
                                          : Icon(
                                              Icons.lock_open,
                                              color: Theme.of(context).colorScheme.primary,
                                            )))
                            ],
                          )
                        ],
                      )
                    : const SizedBox.shrink(),

                // Showing the variant selection if there are variants for the sprite
                widget.selectedOption.runtimeType == SpriteGeneric
                    ? SizedBox(
                        child: (widget.selectedOption! as SpriteGeneric).variants.isNotEmpty
                            ? Column(
                                children: [
                                  const Divider(),
                                  Stack(
                                    children: [
                                      SizedBox(
                                        width: getCardWidth(),
                                        height: 100,
                                      ),
                                      Positioned.fill(
                                        child: Center(child: createVariantMenu(context)),
                                      ),
                                      widget.variantLockKey != null
                                          ? Positioned(
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      PfpManager().lockedOptions[widget.variantLockKey!] = !PfpManager().lockedOptions[widget.variantLockKey!]!;
                                                    });
                                                  },
                                                  icon: PfpManager().lockedOptions[widget.variantLockKey!]!
                                                      ? Icon(
                                                          Icons.lock,
                                                          color: Theme.of(context).colorScheme.primary,
                                                        )
                                                      : Icon(
                                                          Icons.lock_open,
                                                          color: Theme.of(context).colorScheme.primary,
                                                        )))
                                          : const SizedBox.shrink()
                                    ],
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
