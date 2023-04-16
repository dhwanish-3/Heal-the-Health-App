import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/doctor/doctor_page0.dart';
import 'package:heal_the_health_app/home/doctor/doctor_profile.dart';
import 'package:heal_the_health_app/home/oops.dart';

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
    return Scaffold(
        body: [
          const DoctorPage0(),
          const ListofPatients(),
          const ListModels(),
          const DoctorProfile()
        ][_currentIndex],
        floatingActionButton: FloatingActionButton.large(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const OOPs()));
            },
            child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/chatbot.png'))))),
        bottomNavigationBar: _buildGnav(context));
  }

  Widget _buildGnav(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 500;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40 * fem))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
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
            tabBackgroundColor: Colors.green.withOpacity(0.3),
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
                icon: LineIcons.syringe,
                text: 'Tests',
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
