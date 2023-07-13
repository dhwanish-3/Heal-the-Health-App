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
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
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

    const apiUrl = 'http://HealTheHealthApp.pythonanywhere.com/thyroid';
    const apiUrlAge = 'http://HealTheHealthApp.pythonanywhere.com/age_thyroid';
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

    Future<void> postData() async {
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
        Map<String, dynamic> body = jsonDecode(response.body);
        acc = body['acc'];
        result = body['result'];
        final ageResponse = await http
            .post(Uri.parse(apiUrlAge),
                headers: {'Content-Type': 'application/json'},
                body: json.encode(data))
            .then((value) {
          debugPrint('response ${value.body} ');
          return value;
        });
        if (ageResponse.statusCode == 200) {
          debugPrint(ageResponse.body);
          age = jsonDecode(ageResponse.body)['result'];
        }
        authNotifier.setLoading(false);
        if (result == 1) {
          gotoNegative(acc, age);
        } else {
          gotoPositive(acc, age);
        }
      } else {
        authNotifier.setLoading(false);
        Utils().toastMessage("Something went wrong...\nPlease try again later");
        // error handling
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    }

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
                    child: Consumer<AuthNotifier>(
                        builder: (context, value, child) {
                      return RoundButton(
                          loading: authNotifier.loading ?? false,
                          title: 'Submit',
                          onTap: () async {
                            authNotifier.setLoading(true);
                            if (myFormKey.currentState!.validate()) {
                              await postData();
                            } else {
                              Utils().toastMessage(
                                  'Please complete all the fields');
                            }
                          });
                    })),
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
