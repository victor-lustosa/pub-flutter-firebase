import 'package:flutter/material.dart';
import '../configs/app_configs.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget(this.list, this.callback, this.name, {super.key});

  final Function(String) callback;
  final List<String> list;
  final String name;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String _listSelected = '';
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      elevation: 16,
      underline: const SizedBox(),
      iconSize: 32,
      iconEnabledColor: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      items: widget.list.map<DropdownMenuItem<String>>(
        (String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 22),
              child: SizedBox(
                width: 294,
                height: 44,
                child: Text(
                  val,
                  style: AppFonts.titleOptionsDropdown,
                ),
              ),
            ),
          );
        },
      ).toList(),
      hint: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 25),
            child: Text(
              widget.name,
            ),
          ),
        ],
      ),
      style: AppFonts.titleLabelDropdown,
      onChanged: (newValue) {
        _dropDownItemSelected(newValue!);
        setState(
          () {
            _listSelected = newValue;
          },
        );
      },
      value: isSelected ? _listSelected : null,
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(
      () {
        _listSelected = novoItem;
        isSelected = true;
        widget.callback(_listSelected);
      },
    );
  }
}
