import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/result_negative.dart';
import 'package:heal_the_health_app/ml_models/result_positive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CardioScreen extends StatefulWidget {
  const CardioScreen({super.key});

  @override
  State<CardioScreen> createState() => _CardioScreenState();
}

class _CardioScreenState extends State<CardioScreen> {
  final apiUrl = 'http://34.131.185.13:8080/cvd';
  final apiUrlAge = 'http://34.131.185.13:8080/age_cvd';
  final _systolicBloodPressureController = TextEditingController();
  final _diastolicBloodPressureController = TextEditingController();
  final _conditionList = ['Normal', 'Above Normal', 'Well Above Normal'];
  final Map<String, int> mapping = {
    'Normal': 1,
    'Above Normal': 2,
    'Well Above Normal': 3
  };
  String _selectionGlucose = 'Normal';
  String _selectionCholesterol = 'Normal';
  final _myFormKey = GlobalKey<FormState>();
  double acc = 100;
  int result = 0;

  // Future<Map<String, dynamic>> postData() async {
  //   final response = await http
  //       .post(Uri.parse(apiUrl),
  //           headers: {'Content-Type': 'application/json'},
  //           body: json.encode(data))
  //       .then((value) {
  //     debugPrint('response${value.body}');
  //     return value;
  //   });

  //   if (response.statusCode == 200) {
  //     // success, parse response data
  //     debugPrint(response.body);
  //     return json.decode(response.body);
  //   } else {
  //     // error handling
  //     throw Exception('Failed to post data: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    PatientUser patient = authNotifier.patientDetails!;
    final array = [
      patient.age,
      patient.gender,
      patient.height,
      patient.weight,
      // PatientUser().age,
      // PatientUser().gender,
      // PatientUser().height,
      // PatientUser().weight,
      0,
      0,
      0,
      0,
      patient.isSmoker == true ? 1 : 0,
      patient.isAlcoholic == true ? 1 : 0,
      patient.isPhysicallyActive == true ? 1 : 0,

      // (PatientUser().isSmoker) ?? 0,
      // (PatientUser().isAlcoholic) ?? 0,
      // (PatientUser().isPhysicalActive) ?? 0,
    ];
    final arrayAge = [
      patient.age,
      patient.gender,
      patient.height,
      patient.weight,
      0,
      0,
      0,
      0,
      patient.isSmoker == true ? 1 : 0,
      patient.isAlcoholic == true ? 1 : 0,
      patient.isPhysicallyActive == true ? 1 : 0,
    ];

    Map<String, dynamic> data = {"data": array};
    Map<String, dynamic> dataAge = {"data": arrayAge};
    return Scaffold(
      appBar: GradientAppBar(title: 'CVD Predictor'),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: _myFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextFormField(
                            controller: _systolicBloodPressureController,
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
                            controller: _diastolicBloodPressureController,
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
                          child: DropdownButtonFormField(
                              value: _selectionGlucose,
                              items: _conditionList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectionGlucose = val as String;
                                  array[6] = mapping[val] as int;
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.blue,
                              ),
                              decoration: InputDecoration(
                                  labelText: 'Glucose level',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: DropdownButtonFormField(
                            value: _selectionCholesterol,
                            items: _conditionList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectionCholesterol = val as String;
                                array[7] = mapping[val] as int;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.blue,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Cholesterol level',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ],
                    )),
                50.heightBox,
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: RoundButton(
                        title: 'Submit',
                        onTap: () async {
                          if (_myFormKey.currentState!.validate()) {
                            array[4] = int.parse(
                                _systolicBloodPressureController.text);
                            array[5] = int.parse(
                                _diastolicBloodPressureController.text);
                            array[6] = mapping[_selectionCholesterol] ?? 0;
                            array[7] = mapping[_selectionGlucose] ?? 0;
                            arrayAge[3] = int.parse(
                                _systolicBloodPressureController.text);
                            arrayAge[4] = int.parse(
                                _diastolicBloodPressureController.text);
                            arrayAge[5] = mapping[_selectionCholesterol] ?? 0;
                            arrayAge[6] = mapping[_selectionGlucose] ?? 0;

                            debugPrint(array.toString());
                            int age = 0;
                            final response = await http
                                .post(Uri.parse(apiUrl),
                                    headers: {
                                      'Content-Type': 'application/json'
                                    },
                                    body: json.encode(data))
                                .then((value) {
                              debugPrint('response${value.body}');
                              return value;
                            });

                            if (response.statusCode == 200) {
                              // success, parse response data
                              debugPrint(response.body);
                              Map<String, dynamic> body =
                                  jsonDecode(response.body);
                              acc = body['acc'];
                              result = body['result'];
                              // if (response.body[8] == '.') {
                              //   acc = double.parse(
                              //       response.body.substring(7, 11));
                              //   result = int.parse(response.body[21]);
                              // } else {
                              //   acc =
                              //       double.parse(response.body.substring(7, 9));
                              //   result = int.parse(response.body[19]);
                              // }
                              final response2 = await http
                                  .post(Uri.parse(apiUrlAge),
                                      headers: {
                                        'Content-Type': 'application/json'
                                      },
                                      body: json.encode(dataAge))
                                  .then((value) {
                                debugPrint('response ${value.body} ');
                                return value;
                              });
                              if (response2.statusCode == 200) {
                                debugPrint(response2.body);
                                age =
                                    int.parse(response2.body.substring(10, 12));
                              }

                              if (result == 1) {
                                gotoNegative(acc, age);
                                // print("$acc% chance you have a CVD");
                                // Navigator.pushNamed(context, '/Insurance');
                              } else {
                                gotoPositive(acc, age);
                                // print("$acc% chance you don't diabetes");
                              }

                              return json.decode(response.body);
                            } else {
                              // error handling
                              throw Exception(
                                  'Failed to post data: ${response.statusCode}');
                            }
                          } else {
                            Utils()
                                .toastMessage('Please complete all the fields');
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  gotoNegative(double acc, int age) {
    debugPrint('neg');
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Negative(
                  accuracy: acc,
                  age: age,
                )));
  }

  gotoPositive(double acc, int age) {
    debugPrint('pos');
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Positive(
                  accuracy: acc,
                  age: age,
                )));
  }
}
