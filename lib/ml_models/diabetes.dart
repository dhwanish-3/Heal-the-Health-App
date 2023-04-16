import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/result_negative.dart';
import 'package:heal_the_health_app/ml_models/result_positive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:ui';

class Diabetes extends StatefulWidget {
  const Diabetes({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<Diabetes> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    final myFormKey = GlobalKey<FormState>();

    double acc = 100;
    int result = 0;

    final PregnanciesController = TextEditingController();
    final GlucoseController = TextEditingController();
    final BloodPressureController = TextEditingController();
    final SkinThicknessController = TextEditingController();
    final InsulinController = TextEditingController();
    final BMIController = TextEditingController();
    final DiabetesPedigreeFunctionController = TextEditingController();
    final AgeController = TextEditingController();
    // final _AgeController = TextEditingController();

    const apiUrl = 'http://34.131.127.115:8080/diab';
    final data1 = [
      0,
      0,
      0,
      0,
      0,
      0.0,
      0.0,
      authNotifier.patientDetails!.age, //PatientUser().age
    ];

    Map<String, dynamic> data = {"data": data1};

    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Diabetes Predictor',
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
                          controller: PregnanciesController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter no. of pregnancies';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Pregnancies',
                              hintText: 'Enter number of pregnancies',
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
                              return 'Please enter glucose level';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Glucose',
                              hintText: 'Enter glucose level',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: BloodPressureController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter blood pressure';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Blood Pressure',
                              hintText: 'Enter blood pressure',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: SkinThicknessController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter skin thickness';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Skin Thickness',
                              hintText: 'Enter skin thickness',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: InsulinController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter insulin level';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Insulin',
                              hintText: 'Enter insulin level',
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
                          controller: DiabetesPedigreeFunctionController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Diabetes Pedigree Function';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Diabetes Pedigree Function',
                              hintText: 'Enter Diabetes Pedigree Function',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(15),
                      //   child: TextFormField(
                      //     controller: AgeController,
                      //     keyboardType: TextInputType.number,
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'Please enter your age';
                      //       }
                      //       return null;
                      //     },
                      //     decoration: InputDecoration(
                      //         labelText: 'Age',
                      //         hintText: 'Enter your Age',
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(15),
                      //         )),
                      //   ),
                      // ),
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
                        print(data["data"][3]);

                        if (myFormKey.currentState!.validate()) {
                          data1[0] = int.parse(PregnanciesController.text);
                          data1[1] = int.parse(GlucoseController.text);
                          data1[2] = int.parse(BloodPressureController.text);
                          data1[3] = int.parse(SkinThicknessController.text);
                          data1[4] = int.parse(InsulinController.text);
                          data1[5] = double.parse(BMIController.text);
                          data1[6] = double.parse(
                              DiabetesPedigreeFunctionController.text);
                          // data1[7] = int.parse(AgeController.text);
                          debugPrint(data.toString());
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
                            if (response.body[8] == '.') {
                              acc =
                                  double.parse(response.body.substring(7, 11));
                              result = int.parse(response.body[21]);
                            } else {
                              acc = double.parse(response.body.substring(7, 9));
                              result = int.parse(response.body[19]);
                            }

                            if (result == 1) {
                              print("$acc% chance you have diabetes");
                              gotoNegative(acc, age);
                            } else {
                              print("$acc% chance you don't diabetes");
                              gotoPositive(acc, age);
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
                  //     print(data["data"][3]);

                  //     if (myFormKey.currentState!.validate()) {
                  //       data1[0] = int.parse(PregnanciesController.text);
                  //       data1[1] = int.parse(GlucoseController.text);
                  //       data1[2] = int.parse(BloodPressureController.text);
                  //       data1[3] = int.parse(SkinThicknessController.text);
                  //       data1[4] = int.parse(InsulinController.text);
                  //       data1[5] = double.parse(BMIController.text);
                  //       data1[6] = double.parse(
                  //           DiabetesPedigreeFunctionController.text);
                  //       data1[7] = int.parse(AgeController.text);
                  //       debugPrint(data.toString());

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
                  //           print("$acc% chance you have diabetes");
                  //           Navigator.pushNamed(context, '/Insurance');
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
