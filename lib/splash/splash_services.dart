import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/doctor/doctor_home.dart';

class SplashServices {
  List<Disease>? medicalConditionsList;
  patientHome(BuildContext context, AuthNotifier authNotifier) {
    AuthService().initializePatient(authNotifier);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const HomePageDhwanish()));
  }

  doctorHome(BuildContext context, AuthNotifier authNotifier) {
    AuthService().initializeDoctor(authNotifier);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const DoctorHome()));
  }

  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    Future<String> getUserData() => UserShared().getUser();
    print('print before got to home');
    goToHome(BuildContext context, AuthNotifier) async {
      String user = await getUserData();
      print('before gotohome');
      debugPrint(user);
      if (user == 'doctor') {
        doctorHome(context, authNotifier);
      } else {
        patientHome(context, authNotifier);
      }
    }

    print('print before gotoonboard');
    goToOnboard() {
      print('before goto onboard');
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OnBoardingPage()));
    }

    print('print before getMedicals');
    getMedicalConditions() async {
      medicalConditionsList = await Medicals().MedicalConditionsList;
      authNotifier.setDiseases(medicalConditionsList);
    }

    print('print before get await medical condition');
    await getMedicalConditions();
    if (user != null) {
      goToHome(context, authNotifier);
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
}
