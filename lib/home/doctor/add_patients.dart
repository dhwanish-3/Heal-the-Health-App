import 'package:heal_the_health_app/constants/imports.dart';

class AddPatients extends StatefulWidget {
  const AddPatients({super.key});

  @override
  State<AddPatients> createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  final _auth = FirebaseAuth.instance;
  List<PatientUser> Patients = [];
  final _searchFilter = TextEditingController();
  void _showPatientDetails(PatientUser patient, context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: false,
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: PatientDetailsSheet(
              patient: patient,
            ),
          );
        });
  }

  _getPatientsList() async {
    await FirebaseFirestore.instance
        .collection('Patients')
        .orderBy('name')
        .get()
        .catchError((e) => debugPrint(e))
        .then((value) {
      Patients = value.docs
          .map((patient) => PatientUser.fromMap(patient.data()))
          .toList();

      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Add Patients',
        authNotifier: authNotifier,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchFilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
            FutureBuilder(
                future: _getPatientsList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.greenAccent,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Show an error message if there was an error during the delay
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: Patients.length,
                          itemBuilder: (context, index) {
                            PatientUser patient = Patients[index];
                            if (_searchFilter.text.isEmpty) {
                              return Card(
                                  surfaceTintColor: Colors.amber,
                                  child: showListTile(
                                      patient, context, authNotifier));
                            } else if (patient.name!
                                .toLowerCase()
                                .contains(_searchFilter.text.toLowerCase())) {
                              return Card(
                                child: showListTile(
                                    patient, context, authNotifier),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget showListTile(
      PatientUser patient, BuildContext context, AuthNotifier authNotifier) {
    return ListTile(
      title: Text(patient.name ?? ''),
      subtitle: Text(patient.emailid.toString()),
      leading: CircleAvatar(backgroundImage: showProfileImage(patient)),
      onTap: () {
        // _showPatientDetails(patient, context);
      },
      trailing: IconButton(
        icon: const Icon(Icons.add_box_outlined),
        onPressed: () async {
          await addPatient(authNotifier, patient);
          Utils().toastMessage("Patient added");
        },
      ),
    );
  }

  addPatient(AuthNotifier authNotifier, PatientUser patient) async {
    if (!authNotifier.doctorDetails!.patients!.contains(patient.uid ?? '')) {
      authNotifier.doctorDetails!.patients!.add(patient.uid ?? '');
      await uploadPatientList(authNotifier.doctorDetails!.uid,
          authNotifier.doctorDetails!.patients ?? []);

      await UpdatePatients(authNotifier.doctorDetails!.uid,
          authNotifier.doctorDetails!.patients ?? []);
    }
  }

  ImageProvider showProfileImage(PatientUser patient) {
    if (patient.imageUrl != '') {
      return NetworkImage(patient.imageUrl.toString());
    } else {
      return const AssetImage('images/default.png');
    }
  }

  Future<void> uploadPatientList(String uid, List<String> patients) async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection('Doctors');
    await ref.doc(uid).update({'patients': patients});
  }

  List<String> getDoctorsVisited(Map<String, dynamic> data) {
    return data['doctorsVisited'];
  }

  Future<void> UpdatePatients(String uid, List<String> patients) async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection('Patients');
    for (String patient in patients) {
      List<String> doctorVisited = [];
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(patient)
          .get()
          .catchError((e) {
        debugPrint(e);
      }).then((value) {
        doctorVisited = getDoctorsVisited(value.data() as Map<String, dynamic>);
      });
      doctorVisited.add(uid);
      await ref.doc(patient).update({'doctorsVisited': doctorVisited});
    }
  }

  goToHome() {
    Navigator.push((context),
        MaterialPageRoute(builder: (context) => const ListofPatients()));
  }
}
