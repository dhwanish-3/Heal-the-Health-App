import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/chatbot/chatbot_main.dart';

class HomePageDhwanish extends StatefulWidget {
  const HomePageDhwanish({super.key});

  @override
  State<HomePageDhwanish> createState() => _HomePageDhwanishState();
}

class _HomePageDhwanishState extends State<HomePageDhwanish> {
  // @override
  // void initState() {
  //   AuthNotifier authNotifier;
  //   Future.delayed(Duration.zero).then((value) async {
  //     authNotifier = Provider.of<AuthNotifier>(context, listen: false);

  // await AuthService().initializePatient(authNotifier);
  //   });
  //   super.initState();
  // }

  logout() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    debugPrint('logout');

    AuthService().signOutPatient(authNotifier, context);
    Navigator.pushNamed(context, RouteNames.patientlogin);
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    double fem = MediaQuery.of(context).size.width / 300;
    return WillPopScope(
      onWillPop: () async {
        final val = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(25),
                actionsPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                title: const Text('Alert'),
                content: const Text('Do you want to Exit the App'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('No')),
                  ElevatedButton(
                      onPressed: () {
                        SystemNavigator.pop();
                        // Navigator.of(context).pop(true);
                      },
                      child: const Text('Yes'))
                ],
              );
            });
        if (val != null) {
          return Future.value(val);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
          body: [
            const UserPage0(),
            const MedicalRecords(),
            const ListModels(),
            const DiaryMain(),
            const UserProfile()
          ][_currentIndex],
          floatingActionButton: _currentIndex == 3
              ? Container()
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatBotScreen()));
                  },
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.transparent,
                    elevation: 10,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 77, 250, 204),
                            Color.fromARGB(255, 71, 200, 255),
                            Color.fromARGB(255, 30, 255, 150),
                          ],
                          stops: [0, 0, 1],
                        ),
                      ),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('images/chatbot_nobg.png')),
                        ),
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: _buildGnav(context)),
    );
  }

  Widget _buildGnav(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 500;
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40 * fem))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
        child: GNav(
            rippleColor: Colors.blue,
            hoverColor: Colors.blue,
            haptic: true,
            tabBorderRadius: 28,
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 400),
            gap: 4,
            color: Colors.grey[800],
            activeColor: Colors.blue,
            iconSize: 28,
            tabBackgroundColor:
                const Color.fromARGB(255, 104, 255, 172).withOpacity(0.3),
            padding: const EdgeInsets.all(16),
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.medicalNotes,
                text: 'Records',
              ),
              GButton(
                icon: LineIcons.doctor,
                text: 'Tests',
              ),
              GButton(
                icon: LineIcons.book,
                text: 'Diary',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ]),
      ),
    );
  }
}
