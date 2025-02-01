import 'package:flutter/material.dart';

class LabeledSwitch extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const LabeledSwitch({
    required this.label,
    required this.initialValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _LabeledSwitchState createState() => _LabeledSwitchState();
}

class _LabeledSwitchState extends State<LabeledSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.onChanged(_value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Switch(
            value: _value,
            onChanged: (bool newValue) {
              setState(() {
                _value = newValue;
              });
              widget.onChanged(newValue);
            },
            activeColor: Colors.blueAccent,
          ),
          Text(
            widget.label,
          ),
        ],
      ),
    );
  }
}