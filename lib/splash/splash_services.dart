import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/doctor/doctor_home.dart';
import 'package:heal_the_health_app/ml_models/result_positive.dart';

class SplashServices {
  List<Disease>? medicalConditionsList;

  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    Future<String> getUserData() => UserShared().getUser();

    patientHome() {
      AuthService().initializePatient(authNotifier);
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomePageDhwanish()));
    }

    doctorHome() {
      AuthService().initializeDoctor(authNotifier);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const DoctorHome()));
    }

    goToHome() async {
      String user = await getUserData();
      if (user == 'doctor') {
        doctorHome();
      } else {
        patientHome();
      }
    }

    goToOnboard() {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OnBoardingPage()));
    }

    getMedicalConditions() async {
      medicalConditionsList = await Medicals().MedicalConditionsList;
      authNotifier.setDiseases(medicalConditionsList);
    }

    await getMedicalConditions();
    if (user != null) {
      goToHome();
    } else {
      goToOnboard();
    }

    // if (user != null) {
    //   Timer(const Duration(seconds: 5), () async {
    //     medicalConditionsList = await Medicals().MedicalConditionsList;
    //     await goToHome();
    //   });
    // } else {
    //   Timer(const Duration(seconds: 5), () async {
    //     medicalConditionsList = await Medicals().MedicalConditionsList;
    //     AuthNotifier authNotifier =
    //         Provider.of<AuthNotifier>(context, listen: false);
    //     authNotifier.setDiseases(medicalConditionsList);
    //     await goToOnboard();
    //   });
  }

  // getPatientData().then((value) async {
  //   debugPrint(value.toString());
  //   if (value.uid != '') {
  //     Timer(
  //         const Duration(seconds: 1),
  //         () => Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => const AppHome())));
  //   } else {
  //     Timer(
  //         const Duration(seconds: 1),
  //         () => Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => const OnBoardingPage())));
  //   }
  // }).onError((error, stackTrace) {
  //   debugPrint('checkauth$error');
  // });
  // }
  // }

  // List<Disease>? get getMedicalConditionsList {
  //   // medicalConditionsList = await Medicals().MedicalConditionsList;
  //   return medicalConditionsList;
  // }
}
