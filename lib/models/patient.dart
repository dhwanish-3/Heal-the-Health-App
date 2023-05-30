import 'dart:convert';

import 'package:heal_the_health_app/constants/imports.dart';

class PatientUser {
  String? uid = '';
  String? imageUrl =
      'https://w7.pngwing.com/pngs/722/101/png-transparent-computer-icons-user-profile-circle-abstract-miscellaneous-rim-account-thumbnail.png';
  String emailid = '';
  String password = '';
  String? phoneNumber = '';
  String? name = 'User';
  String? nickName = 'Nick';
  String? birthDate = '2002-10-11';
  int? age = 20;
  int? gender = 2;
  int? height = 150;
  int? weight = 50;
  bool? isSmoker = false;
  bool? isAlcoholic = false;
  bool? isPhysicallyActive = false;
  bool? isPWD = false;
  int? percentageofDisability = 0;
  List<int>? medicalConditions = [];
  List<String>? doctorsVisited = [];
  List<String>? detailsofVisit = [];
  List<String>? diary = [];
  List<Appointment>? upcoming = [];
  List<Appointment>? completed = [];
  List<Appointment>? cancelled = [];

  PatientUser();

  PatientUser.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    //debugPrint(uid);
    imageUrl = data['imageUrl'];
    //debugPrint(imageUrl);
    emailid = data['emailid'];
    //debugPrint(emailid);
    name = data['name'];
    //debugPrint(name);
    password = data['password'];
    //debugPrint(password);
    phoneNumber = data['phoneNumber'];
    //debugPrint(phoneNumber);
    nickName = data['nickName'];
    //debugPrint(nickName);
    age = data['age'];
    //debugPrint(age.toString());
    gender = data['gender'];
    //debugPrint(gender.toString());
    height = data['height'];
    //debugPrint(height.toString());
    weight = data['weight'];
    //debugPrint(weight.toString());
    isSmoker = data['isSmoker'];
    //debugPrint(isSmoker.toString());
    isAlcoholic = data['isAlcoholic'];
    //debugPrint('alco$isAlcoholic');
    isPhysicallyActive = data['isPhysicallyActive'];
    //debugPrint(isPhysicallyActive.toString());
    isPWD = data['isPWD'];
    //debugPrint('chal$isPWD');
    percentageofDisability = data['percentageofDisability'];
    //debugPrint(percentageofDisability.toString());
    medicalConditions = data['medicalConditions'] is Iterable
        ? List.from(data['medicalConditions'])
        : null;
    //debugPrint(medicalConditions.toString());
    doctorsVisited = data['doctorsVisited'] is Iterable
        ? List.from(data['doctorsVisited'])
        : null;
    detailsofVisit = data['detailsofVisit'] is Iterable
        ? List.from(data['detailsofVisit'])
        : null;
    diary = data['diary'] is Iterable ? List.from(data['diary']) : null;
    //debugPrint(doctorsVisited.toString());
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
    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'emailid': emailid,
      'name': name,
      'password': password,
      'phoneNumber': phoneNumber,
      'nickName': nickName,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'isSmoker': isSmoker,
      'isAlcoholic': isAlcoholic,
      'isPhysicallyActive': isPhysicallyActive,
      'isPWD': isPWD,
      'percentageofDisability': percentageofDisability,
      'medicalConditions': medicalConditions,
      'doctorsVisited': doctorsVisited,
      'detailsofVisit': detailsofVisit,
      'diary': diary,
      'upcoming': getJson(upcoming ?? []),
      'completed': getJson(completed ?? []),
      'cancelled': getJson(cancelled ?? []),
    };
  }

  Future<PatientUser> getPatient(String uid) async {
    PatientUser patient = PatientUser();
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(uid)
        .get()
        .then((value) {
      patient = PatientUser.fromMap(value.data() as Map<String, dynamic>);
    });
    return patient;
  }
}
