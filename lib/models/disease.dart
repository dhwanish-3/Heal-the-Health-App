import 'package:heal_the_health_app/constants/imports.dart';

class Disease {
  String? disease;
  String? type;
  String? discription = '';
  List<String>? doctors = [];
  int? index = 0;
  List<String>? precautions = [];
  List<Symptom>? symptoms = [];
  Disease(
      {this.disease,
      this.type,
      this.discription,
      this.index,
      this.precautions,
      this.symptoms,
      this.doctors});

  Disease.fromMap(Map<String, dynamic> data) {
    disease = data['disease'];
    type = data['type'];
    discription = data['discription'];
    doctors = data['doctors'] is Iterable ? List.from(data['doctors']) : [];
    index = data['index'];
    precautions =
        data['precautions'] is Iterable ? List.from(data['precautions']) : [];
    symptoms = data['symptoms'] is Iterable ? List.from(data['symptoms']) : [];
  }

  Map<String, dynamic> toMap() {
    return {
      'disease': disease,
      'type': type,
      'discription': discription,
      'doctors': doctors,
      'index': index,
      'precautions': precautions,
      'symptoms': symptoms
    };
  }
}
