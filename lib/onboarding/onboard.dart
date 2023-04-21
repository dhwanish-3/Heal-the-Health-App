import 'package:heal_the_health_app/constants/imports.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});
  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: const TextStyle(fontSize: 28, fontFamily: bold),
        bodyTextStyle: const TextStyle(fontSize: 20),
        bodyPadding: const EdgeInsets.all(0).copyWith(top: 0),
        imagePadding: const EdgeInsets.all(0).copyWith(top: 0),
        pageColor: Colors.white,
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Expanded(
              child: IntroductionScreen(
                pages: [
                  PageViewModel(
                    title: 'Healthy Lifestyle',
                    body: 'Making your Health Lifestyle\n\nHassle free',
                    image: buildImage('images/health1.png'),
                    decoration: getPageDecoration(),
                  ),
                  PageViewModel(
                    title: 'Amazing Features',
                    body:
                        'Like Disease Detection\n\nAvailable right at your fingerprints',
                    image: buildImage('images/health2.png'),
                    decoration: getPageDecoration(),
                  ),
                  PageViewModel(
                    title: 'Simple UI',
                    body: 'For Enhanced User Experience',
                    image: buildImage('images/health5.png'),
                    decoration: getPageDecoration(),
                  ),
                  PageViewModel(
                    title: 'Start Your Journey',
                    body: 'Lets start a Healthy Way of Living',
                    image: buildImage('images/health4.png'),
                    decoration: getPageDecoration(),
                  ),
                ],
                done: const Text('Start',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w600)),
                onDone: () {
                  if (authNotifier.isDoctor == null ||
                      authNotifier.isDoctor == false) {
                    Navigator.pushNamed(context, RouteNames.patientsignup);
                  } else {
                    Navigator.pushNamed(context, RouteNames.doctorsignup);
                  }
                },

                // showSkipButton: true,
                // skip: const Text(
                //   'Skip',
                //   style: TextStyle(color: Colors.red),
                // ),
                // onSkip: () => goToHome(context),
                next: const Icon(Icons.arrow_forward, color: Colors.green),
                dotsDecorator: DotsDecorator(
                  color: Colors.lightBlue,
                  activeColor: Colors.green,
                  size: const Size(10, 10),
                  activeSize: const Size(22, 10),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                // skipOrBackFlex: 0,
                // nextFlex: 0,
                animationDuration: 500,
                globalBackgroundColor: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<AuthNotifier>(
                  builder: (context, value, child) => Checkbox(
                      value: authNotifier.isDoctor ?? false,
                      onChanged: (newValue) {
                        authNotifier.setisDoctor(newValue);
                        debugPrint(authNotifier.isDoctor.toString());
                      }),
                ),
                const Text('Are you a Doctor'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RoundButton(
                  title: 'Get Started',
                  onTap: () {
                    if (authNotifier.isDoctor == null ||
                        authNotifier.isDoctor == false) {
                      Navigator.pushNamed(context, RouteNames.patientsignup);
                    } else {
                      Navigator.pushNamed(context, RouteNames.doctorsignup);
                    }
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                    onPressed: () {
                      if (authNotifier.isDoctor == null ||
                          authNotifier.isDoctor == false) {
                        Navigator.pushNamed(context, RouteNames.patientlogin);
                      } else {
                        Navigator.pushNamed(context, RouteNames.doctorsignup);
                      }
                    },
                    child: const Text('Login')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
