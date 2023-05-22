import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:walkscape_characters/option_interface.dart';
import 'package:walkscape_characters/pfp_manager.dart';
import 'package:walkscape_characters/vars.dart';

class OptionPicker extends StatelessWidget {
  const OptionPicker(
      {super.key, this.selectedOption, this.optionList, required this.onSelect, required this.label, this.onExpressionSelect, this.colorList, this.selectedColor});
  final String label;
  final OptionInterface? selectedOption;
  final List<OptionInterface>? optionList;
  final Function(dynamic option) onSelect;
  final Function(String option)? onExpressionSelect;
  final Map<String, List<Color>>? colorList;
  final String? selectedColor;

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
              child: colorList.isNull
                  ? Column(
                      children: [
                        for (var option in optionList!)
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
                                      onSelect(option);
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
                        for (var colorEntry in colorList!.entries)
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
                                      onSelect(colorEntry.key);
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
    if (colorList.isNull) {
      var index = optionList!.indexOf(selectedOption!);
      if (index == 0) {
        index = optionList!.length - 1;
      } else {
        index--;
      }
      returnValue = optionList![index];
    } else {
      var index = colorList!.keys.toList().indexOf(selectedColor!);
      if (index == 0) {
        index = colorList!.length - 1;
      } else {
        index--;
      }
      returnValue = colorList!.keys.toList()[index];
    }
    return returnValue;
  }

  /// Returns the next option in list
  dynamic _getNext() {
    dynamic returnValue;
    if (colorList.isNull) {
      var index = optionList!.indexOf(selectedOption!);
      if (index >= optionList!.length - 1) {
        index = 0;
      } else {
        index++;
      }
      returnValue = optionList![index];
    } else {
      var index = colorList!.keys.toList().indexOf(selectedColor!);
      if (index >= colorList!.length - 1) {
        index = 0;
      } else {
        index++;
      }
      returnValue = colorList!.keys.toList()[index];
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
                SizedBox(width: 200, child: Center(child: Text(label))),
                const Divider(),
                ElevatedButton(onPressed: () => _openSelectionSheet(context), child: colorList.isNull ? Text(selectedOption!.name) : Text(selectedColor!)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          onSelect(_getPrevious());
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Theme.of(context).primaryColor,
                        )),
                    IconButton(
                        onPressed: () {
                          onSelect(_getNext());
                        },
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          color: Theme.of(context).primaryColor,
                        )),
                  ],
                ),
                selectedOption.runtimeType == SpriteFace
                    ? Column(
                        children: [
                          const Divider(),
                          DropdownButton<String>(
                            value: PfpManager().chosenExpression,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? value) {
                              if (value != null && onExpressionSelect != null) {
                                onExpressionSelect!(value);
                              }
                            },
                            items: (selectedOption as SpriteFace).expressionOptions.keys.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
