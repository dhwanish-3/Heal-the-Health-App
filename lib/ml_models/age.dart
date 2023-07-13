import 'package:heal_the_health_app/constants/imports.dart';

class Age extends StatefulWidget {
  int age;
  Age({super.key, required this.age});

  @override
  _State createState() => _State();
}

class _State extends State<Age> {
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    if (widget.age <= authNotifier.patientDetails!.age!) {
      widget.age = 80;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E3E7),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: Image.asset(
                  'images/arora.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -0.46),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    color: const Color(0x7BFFE6E6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(0, -0.5),
                    child: Text(
                      'DISEASE INCIDENCE AGE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFFFF0000),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: AlignmentDirectional(0, -0.37),
                child: Text(
                  'According to our Expert Assessment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xCA211723),
                    fontSize: 14,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0.20),
                child: Material(
                  color: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.79,
                    height: MediaQuery.of(context).size.height * 0.13,
                    constraints: const BoxConstraints(
                      maxWidth: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                          spreadRadius: 5,
                        )
                      ],
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE0E3E7), Color(0xFF4AC435)],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1),
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color(0xFFE0E3E7),
                        width: 5,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Insurance())),
                      child: Align(
                        alignment: const AlignmentDirectional(0, -0.15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: const AlignmentDirectional(-0.05, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 15, 5, 0),
                                      child: Text(
                                        'EXPLORE DIFFERENT HEALTH INSURANCE PLANS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF010307),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Healthy today, \ninsured for tomorrow',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFFE0E3E7),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.05, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 10, 0),
                                child: Image.asset(
                                  'images/rain.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: AlignmentDirectional(0, 1),
                child: Text(
                  'Please note that the information from this tool is only for educational purposes and isn’t a qualified medical opinion. This information shouldn’t be considered a doctor or other healthcare provider’s advice or opinion about your actual health. You should get help from a healthcare provider for your symptoms. If you’re having a health emergency, you should call the local emergency number right away for help.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF101213),
                    fontSize: 9,
                    height: 1,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -0.20),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xCA211723),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                        spreadRadius: 5,
                      )
                    ],
                    border: Border.all(
                      color: const Color(0xFF579D35),
                      width: 10,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.age.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFE0E3E7),
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0.6),
                child: Material(
                  color: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.79,
                    height: MediaQuery.of(context).size.height * 0.14,
                    constraints: const BoxConstraints(
                      maxWidth: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE0E3E7), Color(0xFF4AC435)],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1),
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color(0xFFE0E3E7),
                        width: 5,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddDoctors())),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.05, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 0, 0),
                              child: Image.asset(
                                'images/hosp.png',
                                width: 80,
                                height: 86,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 15, 5, 0),
                                    child: Text(
                                      'FIND HEALTHCARE CENTRES IN CLOSE PROXIMITY',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF101213),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 0, 0),
                                    child: Text(
                                      'Schedule a follow up checkup',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFFFF5963),
                                        fontSize: 14,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
