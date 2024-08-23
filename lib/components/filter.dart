import 'package:flutter/material.dart';
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/controller/rover.dart';
import 'package:mars_rover/src/utils.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? _selectedCamera;
  DateTime? _selectedDate;

  final List<List<String>> _cameraTypes = [
    ["FHAZ", "Front Hazard Avoidance Camera"],
    ["RHAZ", "Rear Hazard Avoidance Camera"],
    ["MAST", "Mast Camera", "✔", "", ""],
    ["CHEMCAM", "Chemistry and Camera Complex"],
    ["MAHLI", "Mars Hand Lens Imager"],
    ["MARDI", "Mars Descent Imager"],
    ["NAVCAM", "Navigation Camera"],
    ["PANCAM", "Panoramic Camera"],
    ["MINITES", "Miniature Thermal Emission Spectrometer (Mini-TES)"],
  ];
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800, 8, 6),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _applyFilter() {
    debugPrint('Selected Camera: $_selectedCamera');
    debugPrint('Selected Date: $_selectedDate');

    RoverController.instance.fetchRover(
        dateFormaterForRequest(_selectedDate), _selectedCamera ?? "all");
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
                width: media.width - 185,
                onSelected: (value) {
                  setState(() {
                    _selectedCamera = value;
                  });
                },
                menuHeight: 400,
                hintText: "Camera Type (all)",
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
                dropdownMenuEntries:
                    _cameraTypes.map<DropdownMenuEntry<String>>((List value) {
                  return DropdownMenuEntry<String>(
                    value: value[0],
                    label: value[1],
                  );
                }).toList(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(55),
                    backgroundColor: kWhiteColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(kDefaultSpace)))),
                onPressed: () => _selectDate(context),
                child: Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : dateFormater(_selectedDate!),
                  style: const TextStyle(color: kBlackColor),
                ),
              ),
            ],
          ),
          kSizedBox,
          kSizedBox,
          ElevatedButton(
            onPressed: _applyFilter,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromHeight(55),
              backgroundColor: kGreyColor,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(kDefaultSpace))),
            ),
            child: const Text(
              'Apply Filter',
              style: TextStyle(color: kWhiteColor),
            ),
          )
        ],
      ),
    );
  }
}
