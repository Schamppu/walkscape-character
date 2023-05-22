import 'package:flutter/material.dart';

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
    return SegmentedButton<String>(
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
    );
  }
}
