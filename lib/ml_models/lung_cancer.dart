import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/result_negative.dart';
import 'package:heal_the_health_app/ml_models/result_positive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:ui';

class LungCancer extends StatefulWidget {
  const LungCancer({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<LungCancer> {
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

    final YellowController = TextEditingController();
    final AnxietyController = TextEditingController();
    final PPController = TextEditingController();
    final CDController = TextEditingController();
    final FatigueController = TextEditingController();
    final AllergyController = TextEditingController();
    final WheezingController = TextEditingController();
    final CoughingController = TextEditingController();
    final SBController = TextEditingController();
    final SDController = TextEditingController();
    final CPController = TextEditingController();

    const apiUrl = 'http://34.131.185.13:8080/lung';
    const apiUrlAge = 'http://34.131.185.13:8080/age_lung';
    PatientUser patient = authNotifier.patientDetails!;
    final array = [
      patient.gender,
      patient.age,
      patient.isSmoker,
      // (PatientUser().gender) ?? 0,
      // (PatientUser().age) ?? 0,
      // (PatientUser().isSmoker) ?? 0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      patient.isAlcoholic == true ? 1 : 0,
      // (PatientUser().isAlcoholic) ?? 0,
      0,
      0,
      0,
      0,
    ];
    final arrayAge = [
      patient.gender,
      patient.isSmoker,
      // (PatientUser().gender) ?? 0,
      // (PatientUser().age) ?? 0,
      // (PatientUser().isSmoker) ?? 0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      patient.isAlcoholic == true ? 1 : 0,
      // (PatientUser().isAlcoholic) ?? 0,
      0,
      0,
      0,
      0,
    ];

    Map<String, dynamic> data = {"data": array};
    Map<String, dynamic> dataAge = {"data": arrayAge};

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Lung Cancer Predictor',
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
                          controller: YellowController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Yellow Fingers',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: AnxietyController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Anxiety',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: PPController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Peer Pressure',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: CDController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Chronic Disease',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: FatigueController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Fatigue',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: AllergyController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Allergy',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: WheezingController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Wheezing',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: CoughingController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Coughing',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: SBController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Shortness of Breath',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: SDController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Swallowing Difficulty',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: CPController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Chest Pain',
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
                          array[3] = int.parse(YellowController.text);
                          array[4] = int.parse(AnxietyController.text);
                          array[5] = int.parse(PPController.text);
                          array[6] = int.parse(CDController.text);
                          array[7] = int.parse(FatigueController.text);
                          array[8] = int.parse(AllergyController.text);
                          array[9] = int.parse(WheezingController.text);
                          array[11] = int.parse(CoughingController.text);
                          array[12] = int.parse(SBController.text);
                          array[13] = int.parse(SDController.text);
                          array[14] = int.parse(CPController.text);
                          arrayAge[2] = int.parse(YellowController.text);
                          arrayAge[3] = int.parse(AnxietyController.text);
                          arrayAge[4] = int.parse(PPController.text);
                          arrayAge[5] = int.parse(CDController.text);
                          arrayAge[6] = int.parse(FatigueController.text);
                          arrayAge[7] = int.parse(AllergyController.text);
                          arrayAge[8] = int.parse(WheezingController.text);
                          arrayAge[10] = int.parse(CoughingController.text);
                          arrayAge[11] = int.parse(SBController.text);
                          arrayAge[12] = int.parse(SDController.text);
                          arrayAge[13] = int.parse(CPController.text);

                          // array[0] = 0;
                          // array[1] = 59;
                          // array[2] = 1;

                          // array[10] = 1;
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
                            Map<String, dynamic> body =
                                jsonDecode(response.body);
                            acc = body['acc'];
                            result = body['result'];
                            // if (response.body[8] == '.') {
                            //   acc =
                            //       double.parse(response.body.substring(7, 11));
                            //   result = int.parse(response.body[21]);
                            // } else {
                            //   acc = double.parse(response.body.substring(7, 9));
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
