import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/chatbot/chatbot_main.dart';
import 'package:heal_the_health_app/home/doctor/doctor_page0.dart';
import 'package:heal_the_health_app/home/doctor/doctor_profile.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 300;
    return WillPopScope(
      onWillPop: () async {
        final val = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text('Do you want to Exit the App'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('No')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
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
            const DoctorPage0(),
            const ListofPatients(),
            const DoctorProfile()
          ][_currentIndex],
          floatingActionButton: FloatingActionButton.large(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatBotScreen()));
              },
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 255, 162, 155),
                        Color.fromARGB(255, 255, 200, 35),
                        Color.fromARGB(255, 255, 154, 3)
                      ], stops: <double>[
                        0,
                        0,
                        1
                      ]),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/chatbot_nobg.png'))))),
          bottomNavigationBar: _buildGnav(context)),
    );
  }

  final String svgIconPath = 'path/to/svg/icon.svg';

  Widget _buildGnav(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 500;
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40 * fem))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0),
        child: GNav(
            rippleColor: const Color.fromARGB(255, 255, 244, 125),
            hoverColor: const Color.fromARGB(184, 247, 255, 15),
            haptic: true,
            tabBorderRadius: 28,
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 400),
            gap: 4,
            color: Colors.black,
            activeColor: const Color.fromARGB(255, 255, 165, 29),
            iconSize: 28,
            tabBackgroundColor:
                const Color.fromARGB(255, 246, 255, 0).withOpacity(0.3),
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
                icon: LineIcons.doctor,
                text: 'Patients',
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
