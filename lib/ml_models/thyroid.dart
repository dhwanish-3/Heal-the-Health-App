import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/result_negative.dart';
import 'package:heal_the_health_app/ml_models/result_positive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'dart:ui';

class Thyroid extends StatefulWidget {
  const Thyroid({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<Thyroid> {
  @override
  Widget build(BuildContext context) {
    final myFormKey = GlobalKey<FormState>();

    final conditionList = ['Yes', 'No'];
    final Map<String, int> mapping = {
      'Yes': 1,
      'No': 0,
    };

    double acc = 100;
    int result = 0;

    final ThyroxineController = TextEditingController();
    final TSHController = TextEditingController();
    final SurgeryController = TextEditingController();
    final T4UController = TextEditingController();
    final T3Controller = TextEditingController();
    final T3MeasuredController = TextEditingController();
    final TumorController = TextEditingController();
    final GoitreController = TextEditingController();
    final HypothyroidController = TextEditingController();
    final TT4MeasuredController = TextEditingController();

    const apiUrl = 'http://34.131.185.13:8080/thyroid';
    const apiUrlAge = 'http://34.131.185.13:8080/age_thyroid';
    final array = [
      0,
      0,
      0,
      0.0,
      0.0,
      0,
      0,
      0,
      0,
      0,
    ];

    Map<String, dynamic> data = {"data": array};

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Thyroid Predictor',
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
                          controller: ThyroxineController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'On Thyroxine',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: TSHController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter TSH measured';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'TSH Measured',
                              hintText: 'Enter TSH measured',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: SurgeryController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Thyroid Surgery',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: T4UController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter T4U';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'T4U',
                              hintText: 'Enter T4U',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),

                      //Probably dropdown Y/N
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: T3Controller,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter T3';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'T3',
                              hintText: 'Enter T3',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: T3MeasuredController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter T3 measured';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'T3 Measured',
                              hintText: 'Enter T3 measured',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: TumorController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Tumour',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: GoitreController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Goitre',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: HypothyroidController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Query Hypothyroid',
                              hintText: 'Enter 1 for Yes, 0 for No',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: TT4MeasuredController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter TT4 measured';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'TT4 Measured',
                              hintText: 'Enter TT4 measured',
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
                          array[0] = int.parse(ThyroxineController.text);
                          array[1] = int.parse(TSHController.text);
                          array[2] = int.parse(SurgeryController.text);
                          array[3] = double.parse(T4UController.text);
                          array[4] = double.parse(T3Controller.text);
                          array[5] = int.parse(T3MeasuredController.text);
                          array[6] = int.parse(TumorController.text);
                          array[7] = int.parse(GoitreController.text);
                          array[8] = int.parse(HypothyroidController.text);
                          array[9] = int.parse(TT4MeasuredController.text);
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
                            final response2 = await http
                                .post(Uri.parse(apiUrlAge),
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
                              // print("$acc% chance you have thyroid disease");
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
    );
  }

  gotoNegative(double acc, int age) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Negative(
                  accuracy: acc,
                  age: age,
                )));
  }

  gotoPositive(double acc, int age) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Positive(
                  accuracy: acc,
                  age: age,
                )));
  }
}
