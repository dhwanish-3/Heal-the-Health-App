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
          .collection('Doctors')
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
        isScrollControlled: false,
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: DoctorDetailsSheet(
              doctor: Doctor,
            ),
          );
        });
  }

  @override
  void initState() {
    AuthNotifier authNotifier;
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      // AuthService().initializeDoctor(authNotifier);
      await _getDoctorsList(authNotifier, Doctors);
      setState(() {});
    });

    super.initState();
  }

  ImageProvider _showProfile(DoctorUser doctor) {
    debugPrint(doctor.imageUrl);
    if (doctor.imageUrl != '') {
      return NetworkImage(doctor.imageUrl);
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
      appBar: GradientAppBar(
        title: 'Doctors Visited',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: Doctors.length,
                itemBuilder: (context, index) {
                  DoctorUser doctor = Doctors[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: _showProfile(doctor),
                              )),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${Doctors[index].name}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                Text("Email id: ${Doctors[index].emailid}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200)),
                                Text(Doctors[index].hospitalName,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            child: PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                          value: 1,
                                          onTap: () {
                                            authNotifier
                                                .patientDetails!.doctorsVisited!
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
                                    ]),
                          )
                        ]),
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
