import 'package:heal_the_health_app/constants/imports.dart';

class UserPage0 extends StatefulWidget {
  const UserPage0({super.key});

  @override
  State<UserPage0> createState() => _UserPage0State();
}

class _UserPage0State extends State<UserPage0> {
  double findSize(String name) {
    if (name.length <= 6) {
      return 28;
    } else {
      return 28 - (name.length - 4);
    }
  }

  // @override
  // void initState() {
  //   AuthNotifier authNotifier;
  //   UserShared userShared;
  //   Future.delayed(Duration.zero).then((value) {
  //     authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  //     userShared = Provider.of<UserShared>(context, listen: false);
  //     // AuthService().initializePatient(authNotifier);
  //     // setState(() {});
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    String userName = authNotifier.patientDetails!.nickName ?? '';
    double fem = MediaQuery.of(context).size.width / 300;
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 380,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment(-2.189, -2.079),
                end: Alignment(1.511, 1.278),
                colors: [
                  Color(0x9e3e96fd),
                  Color(0xa37cc1e8),
                  Color(0xff0075ff)
                ],
                stops: <double>[0, 0, 1],
              )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(12)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.notifications_outlined)),
                              ),
                            ]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 250,
                              width: 350,
                              decoration: const BoxDecoration(),
                              child: Row(
                                children: [
                                  Column(
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
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      20.heightBox,
                                      AnimatedTextKit(
                                        // repeatForever: true,
                                        animatedTexts: [
                                          TyperAnimatedText(
                                            'Hope you are\ndoing Great ! ',
                                            textStyle: const TextStyle(
                                              fontSize: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Image(
                                      image:
                                          AssetImage('images/nurse-greet.png')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
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
                            borderRadius: BorderRadius.circular(30 * fem),
                            gradient: const LinearGradient(
                              begin: Alignment(0, -1),
                              end: Alignment(0, 1),
                              colors: <Color>[
                                Color(0xffb6f4da),
                                Color(0x8e66e4f5)
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: HealthNeeds(),
                ),
                20.heightBox,
                VxSwiper.builder(
                  enlargeCenterPage: true,
                  aspectRatio: 1,
                  autoPlay: false,
                  height: 190,
                  itemCount: 3,
                  itemBuilder: _buildListItem,
                ),
                20.heightBox,
              ]),
            ),
            _buildHealthOrg(context),
            80.heightBox
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
              // boxShadow: const [
              //   BoxShadow(
              //     blurRadius: 4,
              //     color: Color(0x33000000),
              //     offset: Offset(0, 2),
              //   )
              // ],
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
                              'Diagnosis at your fingertips',
                              textAlign: TextAlign.center,
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
              // boxShadow: const [
              //   BoxShadow(
              //     blurRadius: 4,
              //     color: Color.fromARGB(51, 244, 18, 18),
              //     offset: Offset(0, 2),
              //   )
              // ],
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
                      children: [
                        18.heightBox,
                        const Expanded(
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
                        const Expanded(
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
              // boxShadow: const [
              //   BoxShadow(
              //     blurRadius: 4,
              //     color: Color.fromARGB(51, 241, 118, 118),
              //     offset: Offset(0, 2),
              //   )
              // ],
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
                              'Your medical history at your fingertips',
                              textAlign: TextAlign.center,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100 * fem,
                  height: 120 * fem,
                  child: Image.asset(
                    'images/logo-1.png',
                    fit: BoxFit.cover,
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
