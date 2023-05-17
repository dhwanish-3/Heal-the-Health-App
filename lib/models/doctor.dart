import 'dart:convert';

import 'package:heal_the_health_app/constants/imports.dart';

class DoctorUser {
  String uid = '';
  String name = '';
  String imageUrl =
      'https://w7.pngwing.com/pngs/913/922/png-transparent-physician-doctor-of-medicine-computer-icons-user-doktor-cartoon-text-monochrome-dentistry-thumbnail.png';
  String emailid = '';
  String password = '';
  String specialization = '';
  String hospitalName = '';
  int experience = 0;
  String qualification = '';
  List<String>? patients = [];
  List<String>? schedule = [];
  List<Appointment>? upcoming = [];
  List<Appointment>? completed = [];
  List<Appointment>? cancelled = [];
  DoctorUser();
  DoctorUser.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    imageUrl = data['imageUrl'];
    emailid = data['emailid'];
    password = data['password'];
    specialization = data['specialization'];
    name = data['name'];
    hospitalName = data['hospitalName'];
    qualification = data['qualification'];
    experience = data['experience'];
    patients = data['patients'] is Iterable ? List.from(data['patients']) : [];
    schedule = data['schedule'] is Iterable ? List.from(data['schedule']) : [];
    upcoming = data['upcoming'] is Iterable
        ? List.from(data['upcoming']
            .map((data) => Appointment.fromMap(jsonDecode(data))))
        : [];
    cancelled = data['cancelled'] is Iterable
        ? List.from(data['cancelled']
            .map((data) => Appointment.fromMap(jsonDecode(data))))
        : [];
    completed = data['completed'] is Iterable
        ? List.from(data['completed']
            .map((data) => Appointment.fromMap(jsonDecode(data))))
        : [];
  }
  List<String> getJson(List<Appointment> appointment) {
    List<String> json = [];
    for (var custom in appointment) {
      json.add(jsonEncode(custom.toMap()));
    }
    return json;
  }

  Map<String, dynamic> toMap() {
    // List<Map> convertPatientsToMap({List<PatientUser>? customPatients}) {
    //   List<Map> patients = [];
    //   for (var customPatient in customPatients!) {
    //     Map step = customPatient.toMap();
    //     patients.add(step);
    //   }
    //   return patients;
    // }

    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'emailid': emailid,
      'name': name,
      'password': password,
      'specialization': specialization,
      'qualification': qualification,
      'hospitalName': hospitalName,
      'experience': experience,
      'patients': patients,
      'schedule': schedule,
      'upcoming': getJson(upcoming ?? []),
      'completed': getJson(completed ?? []),
      'cancelled': getJson(cancelled ?? []),
    };
  }

  Future<DoctorUser> getDoctor(String uid) async {
    DoctorUser doctor = DoctorUser();
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(uid)
        .get()
        .then((value) {
      doctor = DoctorUser.fromMap(value.data() as Map<String, dynamic>);
    });
    return doctor;
  }
}
