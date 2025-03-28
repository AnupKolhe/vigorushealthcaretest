import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddMedicineModel {
  final String? medinamce;
  final int? compartmentNum;
  final int? colorIndex;
  final Color? selectedColor;
  final String? medicinceType;
  final String? medicinceQuantity;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? frequency;
  final String? timesDay;
  final List<String>? foodTime;

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
    required this.foodTime,
  });

  // From JSON
  factory AddMedicineModel.fromJson(Map<String, dynamic> json) {
    return AddMedicineModel(
      medinamce: json['medinamce'],
      compartmentNum: json['compartmentNum'],
      colorIndex: json['colorIndex'],
      // selectedColor: json['selectedColor'] != null
      //     ? Color(int.parse(
      //         json['selectedColor'])) // Assuming color is stored as int
      //     : null,
      medicinceType: json['medicinceType'],
      medicinceQuantity: json['medicinceQuantity'],
      startDate: (json['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (json['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      frequency: json['frequency'],
      timesDay: json['timesDay'],
      foodTime: (json['foodTime'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
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
