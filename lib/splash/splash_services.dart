import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/doctor/doctor_home.dart';

class SplashServices {
  List<Disease>? medicalConditionsList;
  patientHome(BuildContext context, AuthNotifier authNotifier) async {
    await AuthService().initializePatient(authNotifier);
    authNotifier.setisDoctor(false);
    // await UserShared()
    //     .getDiaryFormFirebase(authNotifier.patientDetails!.uid ?? '');
    if (context.mounted) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomePageDhwanish()));
    }
  }

  doctorHome(BuildContext context, AuthNotifier authNotifier) async {
    await AuthService().initializeDoctor(authNotifier);
    authNotifier.setisDoctor(true);
    if (context.mounted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const DoctorHome()));
    }
  }

  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    Future<String> getUserData() => UserShared().getUser();
    goToHome(BuildContext context, authNotifier) async {
      String user = await getUserData();
      if (user == '"doctor"') {
        doctorHome(context, authNotifier);
      } else {
        patientHome(context, authNotifier);
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
      goToHome(context, authNotifier);
    } else {
      goToOnboard();
    }
  }
}
