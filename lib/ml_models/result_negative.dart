import 'package:heal_the_health_app/constants/imports.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Negative extends StatefulWidget {
  double accuracy;
  int age;
  Negative({super.key, required this.accuracy, required this.age});

  @override
  _State createState() => _State();
}

class _State extends State<Negative> {
  @override
  Widget build(BuildContext context) {
    double accuracy = widget.accuracy / 100;
    return Scaffold(
      backgroundColor: const Color(0xC3FFFFFF),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.31,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Image.asset(
                  'images/sick.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1.09),
              child: Material(
                color: Colors.transparent,
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    color: const Color(0xAE101213),
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(
                      color: const Color(0xFF101213),
                    ),
                  ),
                  // child: ClipRRect(
                  //   borderRadius: const BorderRadius.only(
                  //     bottomLeft: Radius.circular(0),
                  //     bottomRight: Radius.circular(0),
                  //     topLeft: Radius.circular(40),
                  //     topRight: Radius.circular(40),
                  //   ),
                  //   child: Image.network(
                  //     '',
                  //     width: double.infinity,
                  //     height: double.infinity,
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -0.47),
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Color(0xC3FFFFFF),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                      spreadRadius: 20,
                    )
                  ],
                  shape: BoxShape.circle,
                ),
                child: CircularPercentIndicator(
                  percent: accuracy,
                  radius: 65,
                  lineWidth: 24,
                  animation: true,
                  animationDuration: 2000,
                  progressColor: const Color(0xFFF80005),
                  backgroundColor: const Color(0xFFF1F4F8),
                  center: Text("${widget.accuracy}%",
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(0, -0.14),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Text(
                  'Our analysis indicates a high risk that ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.yellow,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(0, -0.06),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: Text(
                  'YOU HAVE THE DISEASE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFFE0E3E7),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0.62),
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 0, 0),
                                    child: Text(
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
            Align(
              alignment: const AlignmentDirectional(0, 0.2),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddDoctors())),
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
                                    'Schedule a visit ',
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
            const Align(
              alignment: AlignmentDirectional(0, 0.95),
              child: Text(
                'Please note that the information from this tool is only for educational purposes and isn’t a qualified medical opinion. This information shouldn’t be considered a doctor or other healthcare provider’s advice or opinion about your actual health. You should get help from a healthcare provider for your symptoms. If you’re having a health emergency, you should call the local emergency number right away for help.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xF9FFFFFF),
                  fontSize: 9,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
      // body: Text('neg'),
    );
  }
}
