import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/result_negative.dart';
import 'package:heal_the_health_app/ml_models/result_positive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:ui';

class Parkinsons extends StatefulWidget {
  const Parkinsons({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<Parkinsons> {
  @override
  Widget build(BuildContext context) {
    final myFormKey = GlobalKey<FormState>();

    final conditionList = ['Yes', 'No'];
    final Map<String, int> mapping = {
      'Yes': 1,
      'No': 2,
    };

    double acc = 100;
    int result = 0;

    final FoController = TextEditingController();
    final FhiController = TextEditingController();
    final FloController = TextEditingController();
    final JitterController = TextEditingController();
    final RAPController = TextEditingController();
    final DDPController = TextEditingController();
    final PPEController = TextEditingController();
    final NHRController = TextEditingController();
    final Spread1Controller = TextEditingController();
    final Spread2Controller = TextEditingController();

    const apiUrl = 'http://34.131.127.115:8080/parkinsons';
    final array = [
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
    ];

    Map<String, dynamic> data = {"data": array};

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Parkinson\'s Predictor',
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
                          controller: FoController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter MDVP:Fo(Hz)';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'MDVP:Fo(Hz)',
                              hintText: 'Enter blood pressure',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: FhiController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter MDVP:Fhi(Hz)';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'MDVP:Fhi(Hz)',
                              hintText: 'Enter MDVP:Fhi(Hz)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: FloController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter MDVP:Flo(Hz)';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'MDVP:Flo(Hz)',
                              hintText: 'Enter MDVP:Flo(Hz)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: JitterController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter MDVP:Jitter(Abs)';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'MDVP:Jitter(Abs)',
                              hintText: 'Enter MDVP:Jitter(Abs)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: RAPController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter MDVP:RAP';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'MDVP:RAP',
                              hintText: 'Enter MDVP:RAP',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: DDPController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Jitter:DDP';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Jitter:DDP',
                              hintText: 'Enter Jitter:DDP',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: PPEController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter PPE';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'PPE',
                              hintText: 'Enter PPE',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: NHRController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter NHR';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'NHR',
                              hintText: 'Enter NHR',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: Spread1Controller,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Spread1';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Spread1',
                              hintText: 'Enter Spread1',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: Spread2Controller,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Spread2';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Spread2',
                              hintText: 'Enter Spread2',
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
                          array[0] = double.parse(FoController.text);
                          array[1] = double.parse(FhiController.text);
                          array[2] = double.parse(FloController.text);
                          array[3] = double.parse(JitterController.text);
                          array[4] = double.parse(RAPController.text);
                          array[5] = double.parse(DDPController.text);
                          array[6] = double.parse(PPEController.text);
                          array[7] = double.parse(NHRController.text);
                          array[8] = double.parse(Spread1Controller.text);
                          array[9] = double.parse(Spread2Controller.text);
                          debugPrint(array.toString());
                          int age = 80;
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
                              gotoNegative(acc, age);
                              // print(
                              // "$acc% chance you have Parkinson's disease");
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
