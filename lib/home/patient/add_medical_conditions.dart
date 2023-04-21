import 'package:heal_the_health_app/constants/imports.dart';

class AddmedicalConditions extends StatefulWidget {
  final List<Disease>? medicalConditions;
  const AddmedicalConditions({super.key, this.medicalConditions});

  @override
  State<AddmedicalConditions> createState() => _AddmedicalConditionsState();
}

class _AddmedicalConditionsState extends State<AddmedicalConditions> {
  final _searchFilter = TextEditingController();
  // List<Disease> medicalConditions = [];
  // @override
  // void initState() {
  //   super.initState();
  //   AuthNotifier authNotifier;
  //   Future.delayed(const Duration(seconds: 1)).then((value) async {
  //     authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  //     // AuthService().initializePatient(authNotifier);
  //     // List<Disease>? medicalConditions = await Medicals().MedicalConditionsList;
  //   });
  // }

  // List<Disease>? medicalConditions = widget.medicalConditions;
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    return Scaffold(
      appBar: GradientAppBar(title: 'Add Past Medical Conditions'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Text(authNotifier.patientDetails!.emailid),
            TextFormField(
              controller: _searchFilter,
              decoration: const InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search)),
              onChanged: (String value) {
                setState(() {});
              },
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: authNotifier.diseases!.length,
                  itemBuilder: (context, index) {
                    Disease condition = authNotifier.diseases![index];
                    if (_searchFilter.text.isEmpty) {
                      return ListTile(
                        title: Text(condition.disease ?? ''),
                        onTap: () {
                          // authNotifier.patientDetails!.medicalConditions!
                          //     .add(condition.index ?? 0);
                          // await getDoctors();

                          debugPrint(condition.discription);
                          debugPrint(condition.precautions.toString());
                          debugPrint(condition.type);
                          debugPrint(condition.symptoms.toString());
                          debugPrint(condition.doctors.toString());
                          Navigator.pop(context, condition);
                        },
                      );
                    } else if (condition.disease!
                        .toLowerCase()
                        .contains(_searchFilter.text.toLowerCase())) {
                      return ListTile(
                        title: Text(condition.disease ?? ''),
                        onTap: () {
                          debugPrint(condition.discription);
                          debugPrint(condition.precautions.toString());
                          debugPrint(condition.type);
                          debugPrint(condition.symptoms.toString());
                          debugPrint(condition.doctors.toString());
                          Navigator.pop(context, condition);
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
