import 'package:heal_the_health_app/constants/imports.dart';

class MedicalConditionsScreen extends StatefulWidget {
  const MedicalConditionsScreen({super.key});

  @override
  State<MedicalConditionsScreen> createState() =>
      _MedicalConditionsScreenState();
}

class _MedicalConditionsScreenState extends State<MedicalConditionsScreen> {
  List<chip> Chips = [];
  final _auth = FirebaseAuth.instance;
  Future<void> uploadMedicalConditions(
      String uid, List<int> medicalConditions) async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection('Patients');
    return await ref.doc(uid).update({'medicalConditions': medicalConditions});
  }

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    Future.delayed(const Duration(seconds: 1)).then((value) {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      AuthService().initializePatient(authNotifier);
    });

    super.initState();
  }

  bool firstTime = false;
  List<Disease>? medicalConditionsList = [];
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        // context.watch<AuthNotifier>();
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
        appBar: GradientAppBar(title: 'Medical Conditions'),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Add your past medical conditions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              children: const [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Please add your past medical conditions from the list shown after pressig the button below.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20),
              child: Consumer<AuthNotifier>(builder: (context, value, child) {
                return RoundButton(
                  loading: authNotifier.loading ?? false,
                  onTap: () async {
                    if (firstTime) {
                      authNotifier.setLoading(true);
                      medicalConditionsList =
                          await Medicals().MedicalConditionsList;
                      authNotifier.setDiseases(medicalConditionsList);
                      firstTime = false;
                      authNotifier.setLoading(false);
                    }
                    Disease result =
                        await goToAddList(medicalConditionsList ?? []);

                    setState(() {
                      chip newChip = chip(
                          label: result.disease ?? '',
                          index: result.index ?? 0);
                      if (Chips.contains(newChip)) {
                        Utils().toastMessage('The disease is already selected');
                      } else {
                        Chips.add(newChip);
                        authNotifier.patientDetails!.medicalConditions!
                            .add(result.index ?? 0);
                      }
                      debugPrint(authNotifier.patientDetails!.medicalConditions
                          .toString());
                    });
                  },
                  title: 'Add Medical Conditions',
                  // child: const Text('Add Medical Conditions'),
                );
              }),
            ),
            Expanded(
              child: Center(
                child: buildPages(authNotifier),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<AuthNotifier>(builder: (context, value, child) {
                return RoundButton(
                    loading: authNotifier.loading ?? false,
                    onTap: () async {
                      if (authNotifier.patientDetails!.medicalConditions !=
                          []) {
                        authNotifier.setLoading(true);
                        await uploadMedicalConditions(
                            authNotifier.patientDetails!.uid ?? '',
                            authNotifier.patientDetails!.medicalConditions ??
                                []);
                        authNotifier.setLoading(false);
                        goToAddDoctors();
                      }
                    },
                    title: 'Next');
              }),
            ),
          ],
        ));
  }

  Widget buildPages(AuthNotifier authNotifier) {
    if (Chips.isEmpty) {
      return Container();
    } else {
      return buildChip(authNotifier);
    }
  }

  double spacing = 2;
  Widget buildChip(AuthNotifier authNotifier) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: Wrap(
          runSpacing: spacing,
          spacing: spacing,
          children: Chips.map((inputChip) => InputChip(
                backgroundColor: const Color.fromARGB(255, 176, 255, 179),
                label: Text(inputChip.label),
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
                onDeleted: () => setState(() {
                  Chips.remove(inputChip);
                  // authNotifier.patientDetails!.medicalConditions = [];
                  authNotifier.patientDetails!.medicalConditions!
                      .remove(inputChip.index);
                  debugPrint(authNotifier.patientDetails!.medicalConditions!
                      .toString());
                }),
              )).toList(),
        ),
      );
  goToAddDoctors() {
    Navigator.push((context),
        MaterialPageRoute(builder: (context) => const HomePageDhwanish()));
  }

  Future<Disease> goToAddList(List<Disease> medicalCondtionsList) async {
    Disease result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddmedicalConditions(
                  medicalConditions: medicalCondtionsList,
                )));
    return result;
  }
}
