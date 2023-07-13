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

    const apiUrl = 'http://HealTheHealthApp.pythonanywhere.com/diab';
    const apiUrlAge = 'http://HealTheHealthApp.pythonanywhere.com/age_diab';
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
    final arrayAge = [
      0,
      0,
      0,
      0,
      0,
      0.0,
      0.0,
    ];

    Map<String, dynamic> data = {"data": data1};
    Map<String, dynamic> dataAge = {"data": arrayAge};

    Future<void> postData() async {
      data1[0] = int.parse(PregnanciesController.text);
      data1[1] = int.parse(GlucoseController.text);
      data1[2] = int.parse(BloodPressureController.text);
      data1[3] = int.parse(SkinThicknessController.text);
      data1[4] = int.parse(InsulinController.text);
      data1[5] = double.parse(BMIController.text);
      data1[6] = double.parse(DiabetesPedigreeFunctionController.text);

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
        Map<String, dynamic> body = jsonDecode(response.body);
        acc = body['acc'];
        result = body['result'];
        final ageResponse = await http
            .post(Uri.parse(apiUrlAge),
                headers: {'Content-Type': 'application/json'},
                body: json.encode(dataAge))
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
                            if (myFormKey.currentState!.validate()) {
                              authNotifier.setLoading(true);
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
