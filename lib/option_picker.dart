import 'package:flutter/material.dart';
import 'package:walkscape_characters/option_interface.dart';
import 'package:walkscape_characters/pfp_manager.dart';

class OptionPicker extends StatelessWidget {
  const OptionPicker({super.key, required this.selectedOption, required this.optionList, required this.onSelect, required this.label, this.onExpressionSelect});
  final String label;
  final OptionInterface selectedOption;
  final List<OptionInterface> optionList;
  final Function(OptionInterface option) onSelect;
  final Function(String option)? onExpressionSelect;

  void _openSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: [
                  for (var option in optionList)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(color: Colors.amber[300]),
                              child: Image.asset(
                                  option.runtimeType == SpriteFace ? (option as SpriteFace).expressionOptions[PfpManager().chosenExpression]! : option.spritePath)),
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
              ),
            ),
          ),
        );
      },
    );
  }

  /// Returns the previous option in list
  OptionInterface _getPrevious() {
    var index = optionList.indexOf(selectedOption);
    if (index == 0) {
      index = optionList.length - 1;
    } else {
      index--;
    }
    var returnValue = optionList[index];
    return returnValue;
  }

  /// Returns the next option in list
  OptionInterface _getNext() {
    var index = optionList.indexOf(selectedOption);
    if (index >= optionList.length - 1) {
      index = 0;
    } else {
      index++;
    }
    var returnValue = optionList[index];
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
                ElevatedButton(onPressed: () => _openSelectionSheet(context), child: Text(selectedOption.name)),
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
