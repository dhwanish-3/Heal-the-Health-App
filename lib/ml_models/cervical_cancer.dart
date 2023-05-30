import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/result_negative.dart';
import 'package:heal_the_health_app/ml_models/result_positive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:ui';

class CervCancer extends StatefulWidget {
  const CervCancer({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<CervCancer> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    final myFormKey = GlobalKey<FormState>();

    final conditionList = ['Yes', 'No'];
    final Map<String, int> mapping = {
      'Yes': 1,
      'No': 2,
    };

    final stdHPVController = TextEditingController();
    final stdCController = TextEditingController();
    final stdVPCController = TextEditingController();
    final IUDController = TextEditingController();
    final stdHIVController = TextEditingController();
    final stdSController = TextEditingController();
    final stdNoController = TextEditingController();
    final stdNumController = TextEditingController();

    const apiUrl = 'http://34.131.185.13:8080/cerv_canc';
    const apiUrlage = 'http://34.131.185.13:8080/age_cerv_canc';
    final array = [
      0.0,
      0.0,
      0.0,
      authNotifier.patientDetails!.isSmoker == true ? 1.0 : 0.0,
      // (PatientUser().isSmoker) ?? 0,
      0.0,
      0.0,
      0.0,
      0,
      0.0,
    ];

    Map<String, dynamic> data = {"data": array};

    double acc = 100;
    int age = 100;
    int result = 0;

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Cervical Cancer Predictor',
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
                          controller: stdHPVController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'STDs : HPV',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: stdCController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'STDs : Condylomatosis',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: stdVPCController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'STDs : vulvo-perineal condylomatosis',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: IUDController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'IUD',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: stdHIVController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'STDs : HIV',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: stdSController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'STDs : syphilis',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: stdNoController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'STDs : Number of diagnosis',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: stdNumController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'STDs : Number',
                              hintText: 'Enter 1 for Yes, 0 for No',
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
                          array[0] = double.parse(stdHPVController.text);
                          array[1] = double.parse(stdCController.text);
                          array[2] = double.parse(stdVPCController.text);
                          array[4] = double.parse(IUDController.text);
                          array[5] = double.parse(stdHIVController.text);
                          array[6] = double.parse(stdSController.text);
                          array[7] = int.parse(stdNoController.text);
                          array[8] = double.parse(stdNumController.text);

                          // array[3] = 0.0;
                          debugPrint(array.toString());

                          final response = await http
                              .post(Uri.parse(apiUrl),
                                  headers: {'Content-Type': 'application/json'},
                                  body: json.encode(data))
                              .then((value) {
                            debugPrint('response ${value.body} ');
                            return value;
                          });

                          if (response.statusCode == 200) {
                            // success, parse response data
                            Map<String, dynamic> body =
                                jsonDecode(response.body);
                            acc = body['acc'];
                            result = body['result'];
                            // debugPrint(response.body);
                            // debugPrint(response.body[7]);
                            // if (response.body[9] == '.') {
                            //   // print(response.body[21]);
                            //   acc =
                            //       double.parse(response.body.substring(7, 11));
                            //   result = int.parse(response.body[21]);
                            //   // print('accur$acc');
                            //   // print('rsdjd$result');
                            // } else {
                            //   acc = double.parse(response.body.substring(7, 9));
                            //   result = int.parse(response.body[19]);
                            // }
                            final response2 = await http
                                .post(Uri.parse(apiUrlage),
                                    headers: {
                                      'Content-Type': 'application/json'
                                    },
                                    body: json.encode(data))
                                .then((value) {
                              debugPrint('response ${value.body} ');
                              return value;
                            });
                            if (response2.statusCode == 200) {
                              debugPrint(response2.body);
                              age = int.parse(response2.body.substring(10, 12));
                            }
                            if (result == 1) {
                              gotoNegative(acc, age);
                              // print("$acc% chance you have cervical cancer");
                              // Navigator.pushNamed(context, '/Insurance');
                            } else {
                              gotoPositive(acc, age);
                              // print("$acc% chance you don't cancer");
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
