import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/search_symptoms.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SymptomsScreen extends StatefulWidget {
  const SymptomsScreen({super.key});

  @override
  State<SymptomsScreen> createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  final apiUrl = 'http://HealTheHealthApp.pythonanywhere.com/predict';

  Future<Map<String, dynamic>> postData(
      List<int> array, AuthNotifier authNotifier) async {
    List<int> list = List<int>.filled(131, 0);

    for (int i = 0; i < array.length; i++) {
      list[array[i]] = 1;
    }

    final dataArray = list;
    Map<String, dynamic> data = {"data": dataArray};

    final response = await http
        .post(Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode(data))
        .then((value) {
      debugPrint('response${value.body}');
      return value;
    });
    authNotifier.setLoading(false);
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return json.decode(response.body);
    } else {
      // error handling
      Utils().toastMessage(
          'Could not get response from api,\nPlease try again later');
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }

  Disease findDisease(String result, AuthNotifier authNotifier) {
    return authNotifier.diseases!
        .firstWhere((element) => element.disease == result);
  }

  List<Symptom> addedSymptoms = [];
  List<chip> Chips = [];
  List<int> array = [];
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Select Symptons',
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Add your symptoms',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            children: const [
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  'Add as many symptoms as you can for the most accurate results.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent),
            onPressed: () async {
              Symptom result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchSymptoms()));
              setState(() {
                chip newChip =
                    chip(label: result.symptom ?? '', index: result.index ?? 0);
                if (Chips.contains(newChip)) {
                  Utils().toastMessage('The symptom is already selected');
                } else {
                  Chips.add(newChip);
                  addedSymptoms.add(result);
                  array.add(result.index ?? 0);
                }
                debugPrint(array.toString());
              });
            },
            child: const Text('Add symptoms'),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Center(
              child: buildPages(),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 30),
              child: Consumer<AuthNotifier>(builder: (context, value, child) {
                return RoundButton(
                    loading: authNotifier.loading ?? false,
                    onTap: () async {
                      if (Chips.length < 3) {
                        Utils()
                            .toastMessage('Please select atleast 3 symptoms');
                      } else {
                        authNotifier.setLoading(true);
                        final result = await postData(array, authNotifier);
                        debugPrint(result.toString());
                        Disease disease =
                            findDisease(result['result'], authNotifier);

                        Navigator.push(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => ResultofSymptoms(
                                      disease: disease,
                                    )));
                      }
                    },
                    title: 'Submit');
              })),
        ],
      ),
    );
  }

  Widget buildPages() {
    if (Chips.isEmpty) {
      return Center(
        child: Text(
          'Your Added Symptoms will show here',
          style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
              fontWeight: FontWeight.w800),
        ),
      );
    } else {
      return buildChip();
    }
  }

  double spacing = 2;
  Widget buildChip() => Padding(
        padding: const EdgeInsets.all(6.0),
        child: Wrap(
          runSpacing: spacing,
          spacing: spacing,
          children: Chips.map((inputChip) => InputChip(
                backgroundColor: const Color.fromARGB(255, 191, 255, 212),
                label: Text(inputChip.label),
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
                onDeleted: () => setState(() {
                  Chips.remove(inputChip);
                  array.remove(inputChip.index);
                }),
              )).toList(),
        ),
      );
}
