import 'package:heal_the_health_app/constants/imports.dart';

class ListofPatients extends StatefulWidget {
  const ListofPatients({super.key});

  @override
  State<ListofPatients> createState() => _ListofPatientsState();
}

class _ListofPatientsState extends State<ListofPatients> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<PatientUser> Patients = [];

  // _getPatientsList() async {
  //   final uid = _auth.currentUser?.uid;
  //   final QuerySnapshot<Map<String, dynamic>> data =
  //       await FirebaseFirestore.instance
  //           .collection('Patients')
  //           // .doc(_auth.currentUser!.uid)
  //           .orderBy('name')
  //           .get()
  //           .catchError((e) => debugPrint(e))
  //           .then((value) {
  //     setState(() {
  //       Patients = value.docs
  //           .map((patient) => PatientUser.fromMap(patient.data()))
  //           .toList();
  //     });
  //     return value;
  //   });
  // }
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
        Patients[i] = PatientUser.fromMap(value.data() as Map<String, dynamic>);
      });
      i++;
    }
    return Patients;
  }

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
  void initState() {
    AuthNotifier authNotifier;
    Future.delayed(Duration.zero).then((value) async {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      // AuthService().initializeDoctor(authNotifier);
      await _getPatientsList(authNotifier, Patients);
      setState(() {});
    });

    super.initState();
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Your Patients List',
        authNotifier: authNotifier,
        leading: const Text(''),
      ),
      body: Column(
        children: [
          Expanded(
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
                                onTap: () {
                                  authNotifier.doctorDetails!.patients!
                                      .remove(Patients[index].uid);
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
          ),
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
