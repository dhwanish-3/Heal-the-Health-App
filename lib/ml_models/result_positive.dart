import 'dart:convert';

import 'package:heal_the_health_app/ml_models/age.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:heal_the_health_app/constants/imports.dart';
import 'package:http/http.dart' as http;

class Positive extends StatefulWidget {
  double accuracy;
  int age;

  Positive({super.key, required this.accuracy, required this.age});

  @override
  State<Positive> createState() => _PositiveState();
}

class _PositiveState extends State<Positive> {
  Future<int> sendImageURL(String imageUrl) async {
    final url = Uri.parse(
        'http://34.131.185.13:8080/x_ray'); // Replace 'API_URL' with the actual API endpoint URL

    final response = await http.post(
      url,
      body: {'image_url': imageUrl},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final result = jsonResponse['result'] as int;
      print(result);
      return result;
    } else {
      throw Exception('Failed to send image URL to the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    double accuracy = widget.accuracy / 100;
    return Scaffold(
      // key: scaffoldKey,
      backgroundColor: const Color(0xFFF1F4F8),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 270.6,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Image.asset(
                  'images/lab.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: Material(
                color: Colors.transparent,
                elevation: 20,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.68,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A4A4A),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  // child: Align(
                  //   alignment: const AlignmentDirectional(0, 0.05),
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.only(
                  //       bottomLeft: Radius.circular(0),
                  //       bottomRight: Radius.circular(0),
                  //       topLeft: Radius.circular(40),
                  //       topRight: Radius.circular(40),
                  //     ),
                  //     child: Image.network(
                  //       ,
                  //       width: double.infinity,
                  //       height: double.infinity,
                  //       fit: BoxFit.fill,
                  //     ),
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
                  color: Color(0xFFFFFFFF),
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
                child: GestureDetector(
                  onTap: () => sendImageURL(
                      'https://img.medscapestatic.com/pi/meds/ckb/04/17804tn.jpg'),
                  child: CircularPercentIndicator(
                    percent: accuracy,
                    radius: 65,
                    lineWidth: 24,
                    animation: true,
                    animationDuration: 2000,
                    progressColor: const Color(0xFF4AC435),
                    backgroundColor: const Color(0xFFF1F4F8),
                    center: Text(
                      '${widget.accuracy}%',
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(0, -0.12),
              child: Text(
                'Our assesment indicates with high assurance',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.yellow,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(0, -0.04),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: Text(
                  'YOU DO NOT HAVE THE DISEASE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0.25),
              child: Material(
                color: Colors.transparent,
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
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    gradient: const LinearGradient(
                      colors: [Color(0xFF31496C), Color(0xFFE0E3E7)],
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
                            builder: (context) => Age(
                                  age: widget.age,
                                ))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.05, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 0, 0, 0),
                            child: Image.asset(
                              'images/oldage.png',
                              width: 80,
                              height: 80,
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 5, 0),
                                  child: Text(
                                    'PREDICT AT WHAT AGE YOU MIGHT CONTRACT THE DISEASE',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFE0E3E7),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 5, 0, 0),
                                  child: Text(
                                    'Better Safe than sorry',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-0.15, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 2, 0, 0),
                                    child: Text(
                                      'check out age of alarm in advance',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                      ),
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
            Align(
              alignment: const AlignmentDirectional(0, 0.7),
              child: Material(
                color: Colors.transparent,
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
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE0E3E7), Color(0xFF31496C)],
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
                                        fontWeight: FontWeight.w600,
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
                                        fontSize: 10,
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
    );
  }
}
