import 'dart:convert';

import 'package:heal_the_health_app/constants/imports.dart';

class DoctorUser {
  String uid = '';
  String name = '';
  String imageUrl = '';
  String emailid = '';
  String password = '';
  String specialization = 'General Practitioner';
  String hospitalName = 'KMCT Hospital, Kozhikode';
  int experience = 0;
  String qualification = 'MBBS';
  List<String>? patients = [];
  List<String>? schedule = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
  ];
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
      'upcoming': Appointment().getJson(upcoming ?? []),
      'completed': Appointment().getJson(completed ?? []),
      'cancelled': Appointment().getJson(cancelled ?? []),
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
