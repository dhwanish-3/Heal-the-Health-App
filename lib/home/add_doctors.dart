import 'package:heal_the_health_app/constants/imports.dart';

class AddDoctors extends StatefulWidget {
  const AddDoctors({super.key});

  @override
  State<AddDoctors> createState() => _AddDoctorsState();
}

class _AddDoctorsState extends State<AddDoctors> {
  List<DoctorUser> Doctors = [];
  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('Doctors');
  final _searchFilter = TextEditingController();
  final _auth = FirebaseAuth.instance;

  showDoctorDetails(DoctorUser doctor, context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: false,
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: DoctorDetailsSheet(
              doctor: doctor,
            ),
          );
        });
  }

  _getDoctorsList() async {
    final uid = _auth.currentUser?.uid;
    final QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance
            .collection('Doctors')
            // .doc(_auth.currentUser!.uid)
            .orderBy('name')
            .get()
            .catchError((e) => debugPrint(e))
            .then((value) {
      setState(() {
        // debugPrint(value.docs.toString());
        Doctors = value.docs
            .map((doctor) => DoctorUser.fromMap(doctor.data()))
            .toList();
      });
      return value;
    });
  }

  @override
  void initState() {
    AuthNotifier authNotifier;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      // authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      // AuthService().initializeDoctor(authNotifier);
      _getDoctorsList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: const GradientAppBar(title: 'Add Doctors'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchFilter,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: Doctors.length,
                    itemBuilder: (context, index) {
                      DoctorUser doctor = Doctors[index];
                      if (_searchFilter.text.isEmpty) {
                        return Card(child: showListTile(doctor, context));
                      } else if (doctor.name
                              .toLowerCase()
                              .contains(_searchFilter.text.toLowerCase()) ||
                          doctor.hospitalName
                              .toLowerCase()
                              .contains(_searchFilter.text.toLowerCase())) {
                        return Card(
                          child: showListTile(doctor, context),
                        );
                      } else {
                        return Container();
                      }
                    })),
            RoundButton(
                title: 'Next',
                onTap: () async {
                  await uploadDoctorList(authNotifier.patientDetails!.uid ?? '',
                      authNotifier.patientDetails!.doctorsVisited ?? []);
                  await UpdateDoctors(authNotifier.patientDetails!.uid ?? '',
                      authNotifier.patientDetails!.doctorsVisited ?? []);
                  // Navigator.push(
                  //     (context),
                  //     MaterialPageRoute(
                  //         builder: (context) => const SymptomsScreen()));
                })
          ],
        ),
      ),
    );
  }

  Future<void> uploadDoctorList(String uid, List<String> doctors) async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection('Patients');
    return await ref.doc(uid).update({'doctorsVisited': doctors});
  }

  Future<void> UpdateDoctors(String uid, List<String> doctors) async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection('Doctors');
    for (var doctor in doctors) {
      await ref.doc(doctor).update({'patients': uid});
    }
  }

  ImageProvider showProfileImage(DoctorUser doctor) {
    if (doctor.imageUrl != '') {
      return NetworkImage(doctor.imageUrl.toString());
    } else {
      return const AssetImage('images/default.png');
    }
  }

  Widget showListTile(DoctorUser doctor, BuildContext context) {
    return ListTile(
      title: Text('${doctor.name}\n${doctor.hospitalName}'),
      subtitle: Text(doctor.qualification),
      leading: CircleAvatar(backgroundImage: showProfileImage(doctor)),
      onTap: () {
        showDoctorDetails(doctor, context);
      },
    );
  }
}


// StreamBuilder<QuerySnapshot>(
//   stream: doctorCollection.orderBy('name').snapshots(),
//   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (!snapshot.hasData) {
//       return const CircularProgressIndicator();
//     } else {
//       return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             var data = snapshot.data!.docs;

//             String name = data[index]['name'];
//             String hospital = data[index]['hospitalName'];
//             if (_searchFilter.text.isEmpty) {
//               return Card(
//                   shadowColor: Colors.blue,
//                   child: showListTile(snapshot, name, hospital,
//                       index));
//             } else if (name
//                     .toLowerCase()
//                     .contains(_searchFilter.text.toLowerCase()) ||
//                 hospital
//                     .toLowerCase()
//                     .contains(_searchFilter.text.toLowerCase())) {
//               return Card(
//                   shadowColor: Colors.red,
//                   child: showListTile(
//                       snapshot, name, hospital, index));
//             } else {
//               return Container();
//             }
//           });
//     }
//   },
// )
