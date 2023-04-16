import 'package:heal_the_health_app/constants/imports.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:ui';

class CVD extends StatefulWidget {
  const CVD({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<CVD> {
  @override
  Widget build(BuildContext context) {
    final myFormKey = GlobalKey<FormState>();

    double acc = 100;
    int result = 0;

    final BPHighController = TextEditingController();
    final BPLowController = TextEditingController();
    final CholestrolController = TextEditingController();
    final GlucoseController = TextEditingController();

    const apiUrl = 'http://34.131.127.115:8080/cvd';
    final array = [
      0,
      0,
      0,
      0.0,
      // PatientUser().age,
      // PatientUser().gender,
      // PatientUser().height,
      // PatientUser().weight,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      // (PatientUser().isSmoker) ?? 0,
      // (PatientUser().isAlcoholic) ?? 0,
      // (PatientUser().isPhysicalActive) ?? 0,
    ];

    Map<String, dynamic> data = {"data": array};

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CVD Predictor'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: myFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: BPHighController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your systolic blood pressure';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Systolic Blood Pressure',
                              hintText: 'Enter your systolic blood pressure',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: BPLowController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your diastolic blood pressure';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Diastolic Blood Pressure',
                              hintText: 'Enter your diastolic blood pressure',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: CholestrolController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter cholesterol level';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Cholesterol',
                              hintText: 'Enter your cholesterol',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: GlucoseController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your systolic blood pressure';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Systolic Blood Pressure',
                              hintText: 'Enter your systolic blood pressure',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),

                  // child: RoundButton(
                  // title: 'Submit',
                  // onPressed: () {
                  // if (_myFormKey.currentState!.validate()) {
                  // array[4] =
                  // int.parse(_systolicBloodPressureController.text);
                  // array[5] =
                  // int.parse(_diastolicBloodPressureController.text);
                  // debugPrint(array.toString());
                  // } else {

                  // Utils()
                  // .toastMessage('Please complete all the fields');
                  // }
                  // }),

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () async {
                      if (myFormKey.currentState!.validate()) {
                        array[4] = int.parse(BPHighController.text);
                        array[5] = int.parse(BPLowController.text);
                        array[6] = int.parse(CholestrolController.text);
                        array[7] = int.parse(GlucoseController.text);

                        array[0] = 20228;
                        array[1] = 1;
                        array[2] = 156;
                        array[3] = 85.0;

                        array[8] = 0;
                        array[9] = 0;
                        array[10] = 1;

                        debugPrint(array.toString());

                        final response = await http
                            .post(Uri.parse(apiUrl),
                                headers: {'Content-Type': 'application/json'},
                                body: json.encode(data))
                            .then((value) {
                          debugPrint('response${value.body}');
                          return value;
                        });

                        if (response.statusCode == 200) {
                          // success, parse response data
                          debugPrint(response.body);
                          if (response.body[8] == '.') {
                            acc = double.parse(response.body.substring(7, 11));
                            result = int.parse(response.body[21]);
                          } else {
                            acc = double.parse(response.body.substring(7, 9));
                            result = int.parse(response.body[19]);
                          }

                          if (result == 1) {
                            print("$acc% chance you have a CVD");
                            // Navigator.pushNamed(context, '/Insurance');
                          } else {
                            print("$acc% chance you don't diabetes");
                          }

                          return json.decode(response.body);
                        } else {
                          // error handling
                          throw Exception(
                              'Failed to post data: ${response.statusCode}');
                        }
                      } else {
                        Utils().toastMessage('Please complete all the fields');
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
