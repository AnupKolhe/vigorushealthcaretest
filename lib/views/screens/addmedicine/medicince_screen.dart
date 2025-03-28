import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vigorushealthcaretest/model/medicine/add_medicine_model.dart';

import '../../../common/constant/app_string.dart';
import '../../../common/constant/color_string.dart';
import '../../../common/constant/path_string.dart';
import '../../../common/services/auth_service.dart';

class MedicinceScreen extends StatefulWidget {
  const MedicinceScreen({super.key});

  @override
  State<MedicinceScreen> createState() => _MedicinceScreenState();
}

class _MedicinceScreenState extends State<MedicinceScreen> {
  TextEditingController medicince = TextEditingController();

  int selectedCompartment = 1;
  int selectedColorIndex = 0;
  String selMediType = AppString.tabletTxt;
  int quantity = 1;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));
  String firstDay = 'Today';
  String endDay = 'End Day';
  String frequency = "Everyday";
  int timesPerDay = 1;
  Set<String> selectedOptions = {"Before Food"};
  int quantityIndex = 0;
  Color selectedColor = Colors.primaries[0];
  AuthService authService = AuthService();
  String quantityValue = '';

  Future<void> addMedicince() async {
    String medicinceName = medicince.text;

    if (medicinceName.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Kindly enter medicine name ')));
      return;
    }
    AddMedicineModel addMedicineModel = AddMedicineModel(
        medinamce: medicinceName,
        compartmentNum: selectedCompartment,
        colorIndex: selectedColorIndex,
        selectedColor: selectedColor,
        medicinceType: selMediType,
        medicinceQuantity: quantityValue,
        startDate: startDate,
        endDate: endDate,
        frequency: frequency,
        foodTime: selectedOptions.toList());

    try {
      await authService.uploadMedicalReport(addMedicineModel);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Medicine added successfully!')),
      );
      Navigator.pushNamed(context, PathString.homeScreen);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add medicine: $e')),
      );
    }
  }

  @override
  void dispose() {
    medicince.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> userSelectype = (selMediType == AppString.tabletTxt ||
            selMediType == AppString.capsuleTxt)
        ? AppString.pillOptions
        : AppString.liquidOptions;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Medicine"),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: medicince,
                onChanged: (value) {
                  medicince.text = value;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search Medicine Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {
                      print("Voice Icon Pressed");
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              showText('Compartment'),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    10,
                    (index) => GestureDetector(
                      onTap: () =>
                          setState(() => selectedCompartment = index + 1),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedCompartment == index + 1
                              ? ColorString.highLightBg
                              : Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: selectedCompartment == index + 1
                                  ? ColorString.highLightBor
                                  : ColorString.borderGrey,
                              width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                          "${index + 1}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Color
              showText('Color'),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      7,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColorIndex = index;
                                selectedColor = Colors.primaries[index];
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.primaries[index],
                                border: Border.all(
                                  color: selectedColorIndex == index
                                      ? Colors
                                          .blue // Border color changes for the selected item
                                      : Colors
                                          .transparent, // Default border color
                                  width: 1.3,
                                ),
                              ),
                            ),
                          )),
                ),
              ),
              SizedBox(height: 10),

              // Type
              showText('Type'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: AppString.imgWithText.entries
                      .map((entry) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selMediType = entry.key;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  Image.asset(
                                    entry.value,
                                    width: 50,
                                    height: 70,
                                    color: selectedColor,
                                  ),
                                  Text(entry.key,
                                      style: TextStyle(
                                        color: selMediType == entry.key
                                            ? ColorString.highLightBor
                                            : ColorString.textColor,
                                      )),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 10),

              // Type
              showText('Quantity'),
              Row(
                children: [
                  Expanded(
                    flex: 2, // Takes 2 parts of the total space (2/3)
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Center(
                        child: Text(
                          userSelectype[quantityIndex],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1, // Takes 1 part of the total space (remaining 1/3)
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.remove, size: 30),
                            onPressed: () {
                              if (quantityIndex > 0) {
                                setState(() {
                                  quantityIndex--;
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add, size: 30),
                            onPressed: () {
                              if (quantityIndex < userSelectype.length - 1) {
                                setState(() {
                                  quantityIndex++;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              showText('Set Date'),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              firstDay =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                            });
                          }
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                Text(
                                  firstDay,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            )),
                      )),
                  SizedBox(width: 15),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              endDay =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                            });
                          }
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                Text(
                                  endDay,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            )),
                      )),
                ],
              ),
              SizedBox(height: 10),
              showText('Frequency of Days'),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: frequency,
                        isExpanded: true,
                        underline: SizedBox.shrink(),
                        items: ["Everyday", "Mon - Fri", "Mon - Sat", "Custom"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.padLeft(10)),
                          );
                        }).toList(),
                        onChanged: (newValue) =>
                            setState(() => frequency = newValue!),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),
              showText('How many times a Day'),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<int>(
                  value: timesPerDay,
                  isExpanded: true,
                  underline: SizedBox.shrink(),
                  items:
                      List.generate(5, (index) => index + 1).map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text("$value times"),
                    );
                  }).toList(),
                  onChanged: (newValue) =>
                      setState(() => timesPerDay = newValue!),
                ),
              ),

              //Pendig
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    ["Before Food", "After Food", "Before Sleep"].map((text) {
                  bool isSelected = selectedOptions.contains(text);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          if (selectedOptions.length > 1) {
                            selectedOptions.remove(text);
                          }
                        } else {
                          selectedOptions.add(text);
                        }
                      });
                    },
                    child: Container(
                      width: 110,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(36),
                        color: isSelected ? Colors.blue : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(),
                child: ElevatedButton(
                  onPressed: addMedicince,
                  child: Text("Add Medicine"),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Text showText(String value) {
    return Text(
      value,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
    );
  }
}
