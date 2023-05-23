import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChangeBetweenViewsButton extends StatefulWidget {
  const ChangeBetweenViewsButton({super.key, required this.onChanged});
  final VoidCallback onChanged;

  @override
  State<ChangeBetweenViewsButton> createState() => _ChangeBetweenViewsButtonState();
}

class _ChangeBetweenViewsButtonState extends State<ChangeBetweenViewsButton> {
  var selection = 'options';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isDesktop
        ? SegmentedButton<String>(
            segments: const <ButtonSegment<String>>[
              ButtonSegment<String>(value: 'options', label: Text('Options'), icon: Icon(Icons.settings)),
              ButtonSegment<String>(value: 'colors', label: Text('Colors'), icon: Icon(Icons.palette)),
            ],
            selected: <String>{selection},
            onSelectionChanged: (Set<String> newSelection) {
              if (selection != newSelection.first) {
                widget.onChanged();
              }
              setState(() {
                selection = newSelection.first;
              });
            },
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                  title: const Text('Options'),
                  selected: selection == 'options',
                  selectedColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  contentPadding: const EdgeInsets.only(left: 10),
                  minVerticalPadding: 2,
                  visualDensity: const VisualDensity(vertical: -2.5),
                  onTap: () {
                    setState(() {
                      if (selection != 'options') {
                        widget.onChanged();
                      }
                      selection = 'options';
                    });
                  },
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.palette,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                  title: const Text('Colors'),
                  selected: selection == 'colors',
                  selectedColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  contentPadding: const EdgeInsets.only(left: 10),
                  minVerticalPadding: 2,
                  visualDensity: const VisualDensity(vertical: -2.5),
                  onTap: () {
                    setState(() {
                      if (selection != 'colors') {
                        widget.onChanged();
                      }
                      selection = 'colors';
                    });
                  },
                ),
              ],
            ),
          );
  }
}
