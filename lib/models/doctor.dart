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
    };
  }
}
