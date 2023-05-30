import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/doctor/doctor_tiles.dart';
import 'package:heal_the_health_app/home/doctor/upcoming_patient.dart';

class DoctorPage0 extends StatefulWidget {
  const DoctorPage0({super.key});

  @override
  State<DoctorPage0> createState() => _DoctorPage0State();
}

class _DoctorPage0State extends State<DoctorPage0> {
  double findSize(String name) {
    if (name.length <= 6) {
      return 30;
    } else {
      return 30 - (name.length - 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    String userName = authNotifier.doctorDetails!.name;
    double fem = MediaQuery.of(context).size.width / 300;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 280,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment(-2.189, -2.079),
              end: Alignment(1.511, 1.278),
              colors: [
                Color.fromARGB(255, 255, 155, 47),
                Color.fromARGB(159, 255, 252, 98),
                Color.fromARGB(255, 255, 125, 44)
              ],
              stops: [0, 0, 1],
            )),
            child: Column(
              children: [
                28.heightBox,
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
                                          Wrap(
                                            direction: Axis.vertical,
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                width: 100,
                                                child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    Text(
                                                      'Hi,\nDr. $userName !',
                                                      style: TextStyle(
                                                          fontSize: findSize(
                                                              userName),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Text(
                                                'Welcome',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      30.heightBox,
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
                                  20.widthBox,
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
                                  color:
                                      const Color.fromARGB(255, 255, 217, 65),
                                  borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon:
                                      const Icon(Icons.notifications_outlined)),
                            ),
                          ]),
                    ],
                  ),
                ),
                Container(
                  height: 58,
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
                          // image: const DecorationImage(
                          //     image: AssetImage('images/Diagn_ssist_nobg.png')),
                          borderRadius: BorderRadius.circular(30 * fem),
                          gradient: const LinearGradient(
                            begin: Alignment(0, -1),
                            end: Alignment(0, 1),
                            colors: [
                              Color.fromARGB(255, 255, 217, 142),
                              Color.fromARGB(255, 255, 200, 2)
                            ],
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
                                child:
                                    Image.asset('images/Diagn_ssist_nobg.png'),
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                UpcomingPatient(),
                10.heightBox,
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: DoctorTiles(),
                ),
                20.heightBox,
                VxSwiper.builder(
                  enlargeCenterPage: true,
                  aspectRatio: 1,
                  autoPlay: false,
                  height: 180,
                  itemCount: 3,
                  itemBuilder: _buildListItem,
                ),
                20.heightBox,
                _buildHealthOrg(context),
                80.heightBox
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
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
              color: const Color.fromARGB(255, 167, 255, 231),
              gradient: const LinearGradient(
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, 1),
                  end: AlignmentDirectional(0, -1),
                  colors: [
                    Color.fromARGB(255, 255, 238, 87),
                    Color.fromARGB(255, 172, 241, 255)
                  ]),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: const Color.fromARGB(255, 190, 255, 235),
                width: 5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Image.asset(
                    'images/doc_appointment.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 5, 0),
                          child: Text(
                            'APPOINTMENT MANGAMENT WITH EASE',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 5, 0),
                          child: Text(
                            'Customise your schedule according to your working hours',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (index == 1) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
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
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color.fromARGB(51, 244, 18, 18),
                  offset: Offset(0, 2),
                )
              ],
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 89, 255, 145),
                  Color.fromARGB(255, 255, 213, 114)
                ],
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Image.asset(
                    'images/manage.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 25, 5, 0),
                          child: Text(
                            'HASSLE FREE CONSULTATION',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            'Easy access to patient`s medical history during checkups',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: Colors.transparent,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 0.20,
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
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color.fromARGB(51, 241, 118, 118),
                  offset: Offset(0, 2),
                )
              ],
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
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: Image.asset(
                    'images/doctor_wish.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 5, 0),
                          child: Text(
                            'KNOW YOUR PATIENT BETTER',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 5, 0),
                          child: Text(
                            'Patients medical history at your fingertips',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
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
