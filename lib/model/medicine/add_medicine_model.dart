import 'dart:ui';

class AddMedicineModel {
  String? medinamce;
  int? compartmentNum;
  int? colorIndex;
  Color? selectedColor;
  String? medicinceType;
  String? medicinceQuantity;
  DateTime? startDate;
  DateTime? endDate;
  String? frequency;
  String? timesDay;
  Set<String>? foodTime;

  // Constructor
  AddMedicineModel({
    this.medinamce,
    this.compartmentNum,
    this.colorIndex,
    this.selectedColor,
    this.medicinceType,
    this.medicinceQuantity,
    this.startDate,
    this.endDate,
    this.frequency,
    this.timesDay,
    this.foodTime,
  });

  // From JSON
  factory AddMedicineModel.fromJson(Map<String, dynamic> json) {
    return AddMedicineModel(
      medinamce: json['medinamce'],
      compartmentNum: json['compartmentNum'],
      colorIndex: json['colorIndex'],
      selectedColor: json['selectedColor'] != null
          ? Color(int.parse(
              json['selectedColor'])) // Assuming color is stored as int
          : null,
      medicinceType: json['medicinceType'],
      medicinceQuantity: json['medicinceQuantity'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      frequency: json['frequency'],
      timesDay: json['timesDay'],
      foodTime: json['foodTime'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'medinamce': medinamce,
      'compartmentNum': compartmentNum,
      'colorIndex': colorIndex,
      'selectedColor': selectedColor?.toString(),
      'medicinceType': medicinceType,
      'medicinceQuantity': medicinceQuantity,
      'startDate': startDate,
      'endDate': endDate,
      'frequency': frequency,
      'timesDay': timesDay,
      'foodTime': foodTime,
    };
  }
}
