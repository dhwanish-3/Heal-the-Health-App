import 'package:heal_the_health_app/constants/imports.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ''});

  // collection reference
  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('Patients');
  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('Doctors');

  Future<void> updatePatientData(
      String name,
      String nickName,
      String imageUrl,
      String dob,
      int height,
      int weight,
      bool smoker,
      bool alcoholic,
      bool physicallyActive,
      bool pwd,
      int percentageDisability,
      List<int> medicalConditions,
      List<String> doctorsVisited,
      String phone,
      int age,
      List<String> detailsofVisit) async {
    return await patientCollection.doc(uid).update({
      'name': name,
      'nickName': nickName,
      'imageUrl': imageUrl,
      'dob': dob,
      'height': height,
      'weight': weight,
      'isSmoker': smoker,
      'isAlcoholic': alcoholic,
      'isPhysicallyActive': physicallyActive,
      'isPWD': pwd,
      'percentageofDisability': percentageDisability,
      'medicalConditions': medicalConditions,
      'doctorsVisited': doctorsVisited,
      'phoneNumber': phone,
      'age': age,
      'detailsofVisit': detailsofVisit
    });
  }

  Future<void> updateDoctorData(
      String name,
      String imageUrl,
      String qualification,
      String hospitalName,
      int experience,
      String specialization,
      List<String> patients) async {
    return await doctorCollection.doc(uid).update({
      'name': name,
      'imageUrl': imageUrl,
      'qualification': qualification,
      'hospitalName': hospitalName,
      'experience': experience,
      'specialization': specialization,
      'patients': patients
    });
  }
}
