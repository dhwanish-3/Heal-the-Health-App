import 'package:heal_the_health_app/constants/imports.dart';

class AuthNotifier with ChangeNotifier {
  User? _user;
  User? get user => _user;
  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  bool? _loading = false;
  bool? get loading => _loading;
  void setLoading(bool? loading) {
    _loading = loading;
    notifyListeners();
  }

  List<Disease>? _diseases = [];
  List<Disease>? get diseases => _diseases;
  void setDiseases(List<Disease>? diseases) {
    _diseases = diseases;
    notifyListeners();
  }

  bool? _isDoctor = false;
  bool? get isDoctor => _isDoctor;
  void setisDoctor(bool? isDoctor) {
    _isDoctor = isDoctor;
    notifyListeners();
  }

  PatientUser? _patientUser;
  PatientUser? get patientDetails => _patientUser;
  void setUserDetails(PatientUser? patientUser) {
    _patientUser = patientUser;
    notifyListeners();
  }

  DoctorUser? _doctorUser;
  DoctorUser? get doctorDetails => _doctorUser;
  void setDoctorDetails(DoctorUser? doctorUser) {
    _doctorUser = doctorUser;
    notifyListeners();
  }

  addPatient(DoctorUser doctor, String patient) {
    doctor.patients!.add(patient);
    notifyListeners();
  }

  addDoctor(PatientUser patient, String doctor) {
    patient.doctorsVisited!.add(doctor);
    notifyListeners();
  }
}
