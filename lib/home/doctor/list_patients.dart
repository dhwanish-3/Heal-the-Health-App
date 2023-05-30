import 'package:heal_the_health_app/constants/imports.dart';

class ListofPatients extends StatefulWidget {
  const ListofPatients({super.key});

  @override
  State<ListofPatients> createState() => _ListofPatientsState();
}

class _ListofPatientsState extends State<ListofPatients> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _showPatientDetails(PatientUser patient, context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
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

  @override
  Widget build(BuildContext context) {
    List<PatientUser> Patients = [];
    bool isEmpty = false;
    _getPatientsList(
        AuthNotifier authNotifier, List<PatientUser> Patients) async {
      int i = 0;
      for (String patient in authNotifier.doctorDetails!.patients ?? []) {
        await FirebaseFirestore.instance
            .collection('Patients')
            .doc(patient)
            .get()
            .catchError((e) => debugPrint(e))
            .then((value) {
          Patients.add(PatientUser());
          Patients[i] =
              PatientUser.fromMap(value.data() as Map<String, dynamic>);
        });
        i++;
      }
      isEmpty = Patients.isEmpty;
    }

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    Future<void> deletePatient(int index) async {
      authNotifier.doctorDetails!.patients!
          .remove(authNotifier.doctorDetails!.patients![index]);
      Patients.removeAt(index);
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(authNotifier.doctorDetails!.uid)
          .update({'patients': authNotifier.doctorDetails!.patients});
    }

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Your Patients List',
        authNotifier: authNotifier,
        leading: const Text(''),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: _getPatientsList(authNotifier, Patients),
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
                } else if (isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 180,
                              width: 180,
                              child: Column(
                                children: const [
                                  Image(
                                      image:
                                          AssetImage('images/no_patients.png')),
                                ],
                              )),
                          20.heightBox,
                          const Text(
                            "Your Patients list is Empty",
                            style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 255, 162, 55)),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: Patients.length,
                          itemBuilder: (context, index) {
                            PatientUser patient = Patients[index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  _showPatientDetails(patient, context);
                                },
                                leading: CircleAvatar(
                                  backgroundImage: _showProfile(patient),
                                ),
                                title: Text(Patients[index].name.toString()),
                                subtitle: Text(Patients[index].emailid),
                                trailing: PopupMenuButton(
                                  icon: const Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 1,
                                        onTap: () async {
                                          await deletePatient(index);
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          height: 40,
                                          width: 100,
                                          child: Center(
                                              child: Row(
                                            children: [
                                              const Icon(Icons.delete),
                                              20.widthBox,
                                              const Text("Delete")
                                            ],
                                          )),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

  ImageProvider _showProfile(PatientUser patient) {
    if (patient.imageUrl != '') {
      return NetworkImage(patient.imageUrl.toString());
    } else {
      return const AssetImage('images/default.png');
    }
  }
}
