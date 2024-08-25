import 'package:flutter/material.dart';
import 'package:mars_rover/components/button.dart';
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/controller/rover.dart';

class FilterScreen extends StatefulWidget {
  final List<dynamic> cameraTypes;
  final int sol;
  const FilterScreen({super.key, required this.cameraTypes, required this.sol});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? _selectedCamera;

  void _applyFilter() {
    debugPrint('Selected Camera: $_selectedCamera');

    RoverController.instance.fetchRover(widget.sol, _selectedCamera);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(kDefaultSpace * 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownMenu(
                width: media.width - 175,
                onSelected: (value) {
                  setState(() {
                    _selectedCamera = value;
                  });
                },
                menuHeight: 400,
                hintText: "Camera Type",
                inputDecorationTheme: InputDecorationTheme(
                  errorStyle: const TextStyle(
                    color: kRedColor,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: kRedColor,
                      width: 2.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: kRedColor,
                      width: 2.0,
                    ),
                  ),
                ),
                dropdownMenuEntries: widget.cameraTypes
                    .map<DropdownMenuEntry<dynamic>>((dynamic value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),
              MyButton(onPressed: _applyFilter, text: 'Apply Filter')
            ],
          ),
          kSizedBox,
        ],
      ),
    );
  }
}
