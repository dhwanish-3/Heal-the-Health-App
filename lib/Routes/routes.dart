import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/doctor/doctor_home.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboard:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnBoardingPage());
      case RouteNames.landing:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LandingPage());

      case RouteNames.patientlogin:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RouteNames.patientsignup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());
      case RouteNames.patientform:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UserFormFillScreen());
      case RouteNames.doctorhome:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DoctorHome());
      case RouteNames.doctorlogin:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DoctorLogIn());
      case RouteNames.doctorsignup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DoctorSignUp());
      case RouteNames.doctortuserform:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DoctorFormFillScreen());

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
