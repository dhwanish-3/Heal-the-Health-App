import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/result_negative.dart';
import 'package:heal_the_health_app/ml_models/result_positive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:ui';

class Stroke extends StatefulWidget {
  const Stroke({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<Stroke> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    final myFormKey = GlobalKey<FormState>();

    final conditionList = ['Yes', 'No'];
    final Map<String, int> mapping = {
      'Yes': 1,
      'No': 0,
    };

    double acc = 100;
    int result = 0;

    final HypertensionController = TextEditingController();
    final HDController = TextEditingController();
    final AvgGlucoseLevelController = TextEditingController();
    final BMIController = TextEditingController();
    final MarriedController = TextEditingController();
    final URBController = TextEditingController();
    final WSTController = TextEditingController();

    const apiUrl = 'http://34.131.127.115:8080/stroke';
    PatientUser patient = authNotifier.patientDetails!;
    final array = [
      patient.age, // PatientUser().age
      0,
      0,
      0.0,
      0.0,
      patient.gender, // PatientUser().gender,
      0,
      0,
      patient.isSmoker, // (PatientUser().isSmoker) ?? 0,
      0,
    ];

    Map<String, dynamic> data = {"data": array};

    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Stroke Predictor',
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
                          controller: HypertensionController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Hypertension',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: HDController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Heart Disease',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: AvgGlucoseLevelController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter average glucose level';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Average Glucose Level',
                              hintText: 'Enter average glucose level',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: BMIController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter BMI';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'BMI',
                              hintText: 'Enter BMI',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: MarriedController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Married',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: URBController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Urb';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Urb',
                              hintText: 'Enter Urb',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: WSTController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Working State',
                              hintText: 'Enter 1 for Active, 0 for Not active',
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
                  padding: const EdgeInsets.symmetric(horizontal: 80),

                  child: RoundButton(
                      title: 'Submit',
                      onTap: () async {
                        if (myFormKey.currentState!.validate()) {
                          array[1] = int.parse(HypertensionController.text);
                          array[2] = int.parse(HDController.text);
                          array[3] =
                              double.parse(AvgGlucoseLevelController.text);
                          array[4] = double.parse(BMIController.text);
                          array[6] = int.parse(MarriedController.text);
                          array[7] = int.parse(URBController.text);
                          array[9] = int.parse(WSTController.text);

                          // array[0] = 67.0;
                          // array[5] = 1;
                          // array[8] = 0;
                          debugPrint(array.toString());
                          int age = 0;
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
                            if (response.body[9] == '.') {
                              acc =
                                  double.parse(response.body.substring(7, 11));
                              result = int.parse(response.body[21]);
                            } else {
                              acc = double.parse(response.body.substring(7, 9));
                              result = int.parse(response.body[19]);
                            }

                            if (result == 1) {
                              // print("$acc% chance you have a stroke");
                              gotoNegative(acc, age);
                            } else {
                              // print("$acc% chance you don't diabetes");
                              gotoPositive(acc, age);
                            }

                            // return json.decode(response.body);
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

                  // child: ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 50, vertical: 10),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20))),
                  //   child: const Text(
                  //     'Submit',
                  //     style: TextStyle(fontSize: 24),
                  //   ),
                  //   onPressed: () async {
                  //     if (myFormKey.currentState!.validate()) {
                  //       array[1] = int.parse(HypertensionController.text);
                  //       array[2] = int.parse(HDController.text);
                  //       array[3] = double.parse(AvgGlucoseLevelController.text);
                  //       array[4] = double.parse(BMIController.text);
                  //       array[6] = int.parse(MarriedController.text);
                  //       array[7] = int.parse(URBController.text);
                  //       array[9] = int.parse(WSTController.text);

                  //       array[0] = 67.0;
                  //       array[5] = 1;
                  //       array[8] = 0;
                  //       debugPrint(array.toString());

                  //       final response = await http
                  //           .post(Uri.parse(apiUrl),
                  //               headers: {'Content-Type': 'application/json'},
                  //               body: json.encode(data))
                  //           .then((value) {
                  //         debugPrint('response${value.body}');
                  //         return value;
                  //       });

                  //       if (response.statusCode == 200) {
                  //         // success, parse response data
                  //         debugPrint(response.body);
                  //         if (response.body[8] == '.') {
                  //           acc = double.parse(response.body.substring(7, 11));
                  //           result = int.parse(response.body[21]);
                  //         } else {
                  //           acc = double.parse(response.body.substring(7, 9));
                  //           result = int.parse(response.body[19]);
                  //         }

                  //         if (result == 1) {
                  //           print("$acc% chance you have a stroke");
                  //           // Navigator.pushNamed(context, '/Insurance');
                  //         } else {
                  //           print("$acc% chance you don't diabetes");
                  //         }

                  //         return json.decode(response.body);
                  //       } else {
                  //         // error handling
                  //         throw Exception(
                  //             'Failed to post data: ${response.statusCode}');
                  //       }
                  //     } else {
                  //       Utils().toastMessage('Please complete all the fields');
                  //     }
                  //   },
                  // ),
                ),
              )
            ],
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
