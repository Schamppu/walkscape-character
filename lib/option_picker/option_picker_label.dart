import 'package:flutter/material.dart';
import 'package:walkscape_characters/managers/pfp_manager.dart';

class OptionPickerLabel extends StatefulWidget {
  const OptionPickerLabel({super.key, required this.label, this.lockKey});
  final String label;
  final LayerType? lockKey;

  @override
  State<OptionPickerLabel> createState() => _OptionPickerLabelState();
}

class _OptionPickerLabelState extends State<OptionPickerLabel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Rendering the label of the option
        const SizedBox(
          height: 40,
        ),
        Positioned.fill(
            child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    PfpManager().lockedOptions[widget.lockKey!] = !PfpManager().lockedOptions[widget.lockKey]!;
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
                      )),
          ],
        )),
        Positioned.fill(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            width: 40,
          ),
          Text(widget.label),
        ])),
      ],
    );
  }
}
