import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/oops.dart';

class HomePageDhwanish extends StatefulWidget {
  const HomePageDhwanish({super.key});

  @override
  State<HomePageDhwanish> createState() => _HomePageDhwanishState();
}

class _HomePageDhwanishState extends State<HomePageDhwanish> {
  @override
  void initState() {
    AuthNotifier authNotifier;
    Future.delayed(Duration.zero).then((value) async {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);

      await AuthService().initializePatient(authNotifier);
    });
    super.initState();
  }

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
    return Scaffold(
        // backgroundColor: Colors.blue,
        body: [
          const UserPage0(),
          const MedicalRecords(),
          const ListModels(),
          const DiaryScreen(),
          const UserProfile()
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
