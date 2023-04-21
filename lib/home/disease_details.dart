import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/disease_details_sheet.dart';

class DiseaseDetails extends StatefulWidget {
  const DiseaseDetails({super.key});

  @override
  State<DiseaseDetails> createState() => _DiseaseDetailsState();
}

class _DiseaseDetailsState extends State<DiseaseDetails> {
  final _searchFilter = TextEditingController();
  showDiseaseDetails(Disease disease, context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: false,
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: DiseaseDetailsSheet(
              disease: disease,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    List<Disease>? medicalConditions = authNotifier.diseases;
    return Scaffold(
      appBar: GradientAppBar(
        title: "Disease Details",
        authNotifier: authNotifier,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Text(authNotifier.patientDetails!.emailid),
            TextFormField(
              controller: _searchFilter,
              decoration: const InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  suffixIcon: Icon(Icons.search)),
              onChanged: (String value) {
                setState(() {});
              },
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: medicalConditions!.length,
                  itemBuilder: (context, index) {
                    Disease condition = medicalConditions[index];
                    if (_searchFilter.text.isEmpty) {
                      return ListTile(
                        title: Text(condition.disease ?? ''),
                        onTap: () {
                          // authNotifier.patientDetails!.medicalConditions!
                          //     .add(condition.index ?? 0);
                          // await getDoctors();
                          showDiseaseDetails(medicalConditions[index], context);
                          debugPrint(condition.discription);
                          debugPrint(condition.precautions.toString());
                          debugPrint(condition.type);
                          debugPrint(condition.symptoms.toString());
                          debugPrint(condition.doctors.toString());
                        },
                      );
                    } else if (condition.disease!
                        .toLowerCase()
                        .contains(_searchFilter.text.toLowerCase())) {
                      return ListTile(
                        title: Text(condition.disease ?? ''),
                        onTap: () {
                          showDiseaseDetails(medicalConditions[index], context);
                          debugPrint(condition.discription);
                          debugPrint(condition.precautions.toString());
                          debugPrint(condition.type);
                          debugPrint(condition.symptoms.toString());
                          debugPrint(condition.doctors.toString());
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
