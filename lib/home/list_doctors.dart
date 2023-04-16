import 'package:heal_the_health_app/constants/imports.dart';

class ListDoctors extends StatefulWidget {
  const ListDoctors({super.key});

  @override
  State<ListDoctors> createState() => _ListDoctorsState();
}

class _ListDoctorsState extends State<ListDoctors> {
  List<DoctorUser> Doctors = [];
  _getDoctorsList(AuthNotifier authNotifier, List<DoctorUser> Doctors) async {
    int i = 0;
    for (String Doctor in authNotifier.patientDetails!.doctorsVisited ?? []) {
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(Doctor)
          .get()
          .catchError((e) => debugPrint(e))
          .then((value) {
        Doctors.add(DoctorUser());
        Doctors[i] = DoctorUser.fromMap(value.data() as Map<String, dynamic>);
      });
      i++;
    }
    return Doctors;
  }

  void _showDoctorDetails(DoctorUser Doctor, context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: DoctorDetailsSheet(
              doctor: Doctor,
            ),
          );
        });
  }

  @override
  void initState() {
    AuthNotifier authNotifier;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      // AuthService().initializeDoctor(authNotifier);
      _getDoctorsList(authNotifier, Doctors);
    });

    super.initState();
  }

  ImageProvider _showProfile(DoctorUser doctor) {
    if (doctor.imageUrl != '') {
      return NetworkImage(doctor.imageUrl.toString());
    } else {
      return const AssetImage('images/default.png');
    }
  }

  bool loading = true;
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Your Patients List',
      ),
      body: Column(
        children: [
          // Expanded(child: Consumer<AuthNotifier>(
          //   builder: (context, value, child) {
          //     return loading
          //         ? Container()
          //         : ListView.builder(
          //             itemCount: authNotifier.doctorDetails!.patients!.length,
          //             itemBuilder: (context, index) {
          //               return Card(
          //                 child: ListTile(
          //                   onTap: () {},
          //                   title: Text(
          //                       authNotifier.doctorDetails!.patients![index]),
          //                 ),
          //               );
          //             });
          //   },
          // )),
          Expanded(
            child: ListView.builder(
                itemCount: Doctors.length,
                itemBuilder: (context, index) {
                  DoctorUser patient = Doctors[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        _showDoctorDetails(patient, context);
                      },
                      leading: CircleAvatar(
                        backgroundImage: _showProfile(patient),
                      ),
                      title: Text(Doctors[index].name.toString()),
                      subtitle: Text(Doctors[index].emailid),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              onTap: () {
                                authNotifier.patientDetails!.doctorsVisited!
                                    .remove(Doctors[index].uid);
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
        ],
      ),
    );
  }
}
