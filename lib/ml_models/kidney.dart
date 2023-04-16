import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/result_negative.dart';
import 'package:heal_the_health_app/ml_models/result_positive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:ui';

class Kidney extends StatefulWidget {
  const Kidney({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<Kidney> {
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

    final BPController = TextEditingController();
    final SgController = TextEditingController();
    final AlController = TextEditingController();
    final SuController = TextEditingController();
    final RBCController = TextEditingController();
    final BuController = TextEditingController();
    final ScController = TextEditingController();
    final SodController = TextEditingController();
    final PotController = TextEditingController();
    final HemoController = TextEditingController();
    final WBCCController = TextEditingController();
    final RBCCController = TextEditingController();
    final HypertensionController = TextEditingController();

    const apiUrl = 'http://34.131.127.115:8080/chr_kid';
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
      0.0,
      0.0,
      0.0,
    ];

    Map<String, dynamic> data = {"data": array};

    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Kidney Disease Predictor',
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
                          controller: BPController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Blood Pressure';
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
                          controller: SgController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter specific gravity';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Specific Gravity',
                              hintText: 'Enter specific gravity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: AlController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter albumin level';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Albumin',
                              hintText: 'Enter albumin level',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: SuController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter sugar level';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Sugar',
                              hintText: 'Enter sugar level',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: RBCController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter RBC level in urine';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Red Blood Cells',
                              hintText: 'Enter RBC level in urine',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: BuController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter blood urea ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Blood Urea',
                              hintText: 'Enter blood urea',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: ScController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter serum creatinine ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Serum Creatinine',
                              hintText: 'Enter serum creatinine',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: SodController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter sodium ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Sodium',
                              hintText: 'Enter sodium ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: PotController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Potassium';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Potassium',
                              hintText: 'Enter Potassium',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: HemoController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter haemoglobin';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Haemoglobin',
                              hintText: 'Enter haemoglobin',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: WBCCController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter WBC count';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'WBC Count',
                              hintText: 'Enter WBC count',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: RBCCController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter RBC count';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'RBC Count',
                              hintText: 'Enter RBC count',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),
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
                          array[0] = double.parse(BPController.text);
                          array[1] = double.parse(SgController.text);
                          array[2] = double.parse(AlController.text);
                          array[3] = double.parse(SuController.text);
                          array[4] = double.parse(RBCController.text);
                          array[5] = double.parse(BuController.text);
                          array[6] = double.parse(ScController.text);
                          array[7] = double.parse(SodController.text);
                          array[8] = double.parse(PotController.text);
                          array[9] = double.parse(HemoController.text);
                          array[10] = double.parse(WBCCController.text);
                          array[11] = double.parse(RBCCController.text);
                          array[12] = double.parse(HypertensionController.text);
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
                            if (response.body[8] == '.') {
                              acc =
                                  double.parse(response.body.substring(7, 11));
                              result = int.parse(response.body[21]);
                            } else {
                              acc = double.parse(response.body.substring(7, 9));
                              result = int.parse(response.body[19]);
                            }

                            if (result == 1) {
                              // print("$acc% chance you have kidney disease");
                              gotoNegative(acc, age);
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
