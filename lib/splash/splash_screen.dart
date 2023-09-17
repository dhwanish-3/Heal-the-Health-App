import 'package:heal_the_health_app/constants/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    UserShared userShared = Provider.of<UserShared>(context, listen: false);
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    UserShared userShared = Provider.of<UserShared>(context, listen: false);
    return const Scaffold(
      body: Center(
          child: SpinKitCubeGrid(
        color: Colors.blue,
        duration: Duration(seconds: 3),
        size: 70,
      )),
    );
  }
}
