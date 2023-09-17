import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/patient/upcoming_appointment.dart';

class UserPage0 extends StatefulWidget {
  const UserPage0({super.key});

  @override
  State<UserPage0> createState() => _UserPage0State();
}

class _UserPage0State extends State<UserPage0> {
  double findSize(String name) {
    if (name.length <= 6) {
      return 26;
    } else {
      return 28 - (name.length - 4);
    }
  }

  DoctorUser doctor = DoctorUser();
  getDoctor(String uid) async {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(uid)
        .get()
        .then((value) {
      doctor = DoctorUser.fromMap(value.data() as Map<String, dynamic>);
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    String userName = authNotifier.patientDetails!.nickName ?? '';
    double fem = MediaQuery.of(context).size.width / 300;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment(-2.189, -2.079),
                end: Alignment(1.511, 1.278),
                colors: [
                  Color(0x9e3e96fd),
                  Color(0xa37cc1e8),
                  Color(0xff0075ff)
                ],
                stops: [0, 0, 1],
              )),
              child: Column(
                children: [
                  26.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 170,
                                width: 315,
                                decoration: const BoxDecoration(),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Hi,\n$userName !',
                                              style: TextStyle(
                                                  fontSize: findSize(userName),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              'Welcome',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        20.heightBox,
                                        AnimatedTextKit(
                                          // repeatForever: true,
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              'Hope you are\ndoing Great !',
                                              textStyle: const TextStyle(
                                                fontSize: 22,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    30.widthBox,
                                    const SizedBox(
                                      height: 200,
                                      child: Image(
                                          image: AssetImage(
                                              'images/nurse-greet.png')),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(12)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.notifications_outlined)),
                              ),
                            ]),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 340 * fem,
                        height: 28 * fem,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30 * fem),
                            gradient: const LinearGradient(
                              begin: Alignment(0, -1),
                              end: Alignment(0, 1),
                              colors: [Color(0xffb6f4da), Color(0x8e66e4f5)],
                              stops: [0, 1],
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 8,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Transform.scale(
                                  scale: 1.7,
                                  child: Image.asset(
                                      'images/Diagn_ssist_nobg.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(children: [
                UpcomingCard(),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: HealthNeeds(),
                ),
                20.heightBox,
                VxSwiper.builder(
                  enlargeCenterPage: true,
                  aspectRatio: 1,
                  autoPlay: false,
                  height: 170,
                  itemCount: 3,
                  itemBuilder: _buildListItem,
                ),
                20.heightBox,
              ]),
            ),
            _buildHealthOrg(context),
            80.heightBox,
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Material(
          color: Colors.transparent,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 0.15,
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, 1),
                  end: AlignmentDirectional(0, -1),
                  colors: [Colors.yellow, Colors.white]),
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: const Color.fromARGB(255, 226, 255, 141),
                width: 5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Image.asset(
                    'images/health4.png',
                    width: 90,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(-0.05, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 5, 0),
                              child: Text(
                                'CONSULTATION MADE SIMPLE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 5, 0),
                            child: Text(
                              'No need to remember your medical history',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (index == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Material(
          // color: Colors.transparent,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.79,
            height: MediaQuery.of(context).size.height * 0.15,
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.grey, Colors.white],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.grey[400] ?? Colors.green,
                width: 5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.05, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Image.asset(
                      'images/oldage.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(-0.05, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 5, 0),
                            child: Text(
                              'BETTER SAFE THAN SORRY',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                            child: Text(
                              'Check out age of alarm in advance',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Material(
          color: Colors.transparent,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.15,
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 199, 102),
              gradient: const LinearGradient(
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, 1),
                  end: AlignmentDirectional(0, -1),
                  colors: [Color.fromARGB(255, 244, 169, 89), Colors.white]),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: const Color.fromARGB(255, 244, 217, 182),
                width: 5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Image.asset(
                    'images/fingertips.png',
                    width: 70,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(-0.05, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 5, 0),
                              child: Text(
                                'UNDERTAKE SOPHISTICATED DISEASE CONFIRMATION TEST',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        10.heightBox,
                        const Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 5, 0),
                            child: Text(
                              'Diagnosis right at your fingertips',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildHealthOrg(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 400;
    double ffem = fem * 0.96;
    return SizedBox(
      width: 344 * fem,
      height: 170 * fem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // group50Yzk (47:27)
            margin: EdgeInsets.fromLTRB(2 * fem, 0 * fem, 123 * fem, 18 * fem),
            padding: EdgeInsets.fromLTRB(0 * fem, 1.88 * fem, 0 * fem, 1 * fem),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // simpleiconsworldhealthorganiza (47:14)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 12 * fem, 0.88 * fem),
                  width: 32 * fem,
                  height: 28.23 * fem,
                  child: Image.asset(
                    'images/simple-icons-worldhealthorganization.png',
                    width: 32 * fem,
                    height: 28.23 * fem,
                  ),
                ),
                Container(
                  // group45mMi (47:17)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 1.12 * fem, 0 * fem, 0 * fem),
                  width: 175 * fem,
                  height: 28 * fem,
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        'Health Organisations',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.2125 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            // autogroupp32pcdE (2qXNp1Y7aZPLKntaKTp32p)
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100 * fem,
                  height: 110 * fem,
                  child: Image.asset(
                    'images/logo-1.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 12 * fem,
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
                  padding: EdgeInsets.fromLTRB(
                      17 * fem, 14 * fem, 13 * fem, 9.88 * fem),
                  child: Center(
                    // layer12xqW (63:35)
                    child: SizedBox(
                      width: 70 * fem,
                      height: 76.12 * fem,
                      child: Image.asset(
                        'images/layer1-2.png',
                        width: 70 * fem,
                        height: 76.12 * fem,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12 * fem,
                ),
                SizedBox(
                  // hlogowhite159S (63:108)
                  width: 120 * fem,
                  height: 100 * fem,
                  child: Image.asset(
                    'images/h-logo-white-1.png',
                    width: 120 * fem,
                    height: 100 * fem,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
