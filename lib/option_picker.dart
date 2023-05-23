import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
      this.colorList,
      this.selectedColor,
      required this.lockKey});
  final String label;
  final OptionInterface? selectedOption;
  final List<OptionInterface>? optionList;
  final Function(dynamic option) onSelect;
  final Function(String option)? onExpressionSelect;
  final Map<String, List<Color>>? colorList;
  final String? selectedColor;
  final String lockKey;

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
                                ElevatedButton(
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
                                ElevatedButton(
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
                    const SizedBox(
                      width: 200,
                      height: 40,
                    ),
                    Positioned.fill(child: Center(child: Text(widget.label))),
                    Positioned(
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
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Icon(
                                    Icons.lock_open,
                                    color: Theme.of(context).primaryColor,
                                  )))
                  ],
                )),
                ElevatedButton(
                    onPressed: () => _openSelectionSheet(context), child: widget.colorList.isNull ? Text(widget.selectedOption!.name) : Text(widget.selectedColor!)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          widget.onSelect(_getPrevious());
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Theme.of(context).primaryColor,
                        )),
                    IconButton(
                        onPressed: () {
                          widget.onSelect(_getNext());
                        },
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          color: Theme.of(context).primaryColor,
                        )),
                  ],
                ),
                widget.selectedOption.runtimeType == SpriteFace
                    ? Column(
                        children: [
                          const Divider(),
                          Stack(
                            children: [
                              const SizedBox(
                                width: 200,
                                height: 40,
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: PfpManager().chosenExpression,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String? value) {
                                      if (value != null && widget.onExpressionSelect != null) {
                                        widget.onExpressionSelect!(value);
                                      }
                                    },
                                    items: (widget.selectedOption as SpriteFace).expressionOptions.keys.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          PfpManager().lockedOptions['expression'] = !PfpManager().lockedOptions['expression']!;
                                        });
                                      },
                                      icon: PfpManager().lockedOptions['expression']!
                                          ? Icon(
                                              Icons.lock,
                                              color: Theme.of(context).primaryColor,
                                            )
                                          : Icon(
                                              Icons.lock_open,
                                              color: Theme.of(context).primaryColor,
                                            )))
                            ],
                          )
                        ],
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
