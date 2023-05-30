import 'package:heal_the_health_app/constants/imports.dart';

class AddDoctors extends StatefulWidget {
  const AddDoctors({super.key});

  @override
  State<AddDoctors> createState() => _AddDoctorsState();
}

class _AddDoctorsState extends State<AddDoctors> {
  List<String> Types = [
    'General Practitioner',
    'Gastroenterologist',
    'Neurologist',
    'Dermatologist',
    'Pediatrician',
    'Cardiologist',
    'Hepatologist',
    'Immunologist',
    'Infectious Disease Specialist',
    'Urologist',
    'Pulmonologist',
    'Otolaryngologist',
    'Vascular Surgeon',
    'Endocrinologist',
    'Colorectal Surgeon',
    'Orthopedic Surgeon',
  ];
  String _selectedSpecialization = 'General Practitioner';

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

  @override
  Widget build(BuildContext context) {
    List<DoctorUser> Doctors = [];
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    // List<DoctorUser> filterDoctors = [];
    Future<void> _getDoctorsList(String specialization) async {
      await FirebaseFirestore.instance
          .collection('Doctors')
          .where('specialization', isEqualTo: specialization)
          .get()
          .catchError((e) => debugPrint(e))
          .then((value) {
        print(value.docs);
        Doctors = value.docs
            .map((doctor) => DoctorUser.fromMap(doctor.data()))
            .toList();
        print(Doctors);
        return value;
      });
    }

    return Scaffold(
      appBar: GradientAppBar(title: 'Doctors'),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Types.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 6),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSpecialization = Types[index];
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        _selectedSpecialization == Types[index]
                                            ? Colors.blueAccent
                                            : Colors.blue),
                                borderRadius: BorderRadius.circular(20),
                                color: _selectedSpecialization == Types[index]
                                    ? Colors.lightBlueAccent
                                    : Colors.white),
                            child: Center(
                                child: Text(
                              Types[index],
                              style: TextStyle(
                                  color: _selectedSpecialization == Types[index]
                                      ? Colors.white
                                      : Colors.blue),
                            ))),
                      ),
                    );
                  }),
            ),
            // 5.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchFilter,
                decoration: const InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
            ),
            FutureBuilder(
                future: _getDoctorsList(_selectedSpecialization),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
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
                            itemCount: Doctors.length,
                            itemBuilder: (context, index) {
                              DoctorUser doctor = Doctors[index];
                              if (_searchFilter.text.isEmpty) {
                                return Card(
                                    child: showListTile(doctor, context));
                              } else if (doctor.name.toLowerCase().contains(
                                      _searchFilter.text.toLowerCase()) ||
                                  doctor.hospitalName.toLowerCase().contains(
                                      _searchFilter.text.toLowerCase())) {
                                return Card(
                                  child: showListTile(doctor, context),
                                );
                              } else {
                                return Container();
                              }
                            }));
                  }
                }),
          ],
        ),
      ),
    );
  }

  ImageProvider showProfileImage(DoctorUser doctor) {
    if (doctor.imageUrl != '') {
      return NetworkImage(doctor.imageUrl.toString());
    } else {
      return const AssetImage('images/default.png');
    }
  }

  Widget showListTile(DoctorUser doctor, BuildContext context) {
    Widget showImage() {
      if (doctor.imageUrl != '') {
        return Image.network(
          doctor.imageUrl,
          width: 50,
          height: 60,
          fit: BoxFit.cover,
        );
      } else {
        return Image.asset(
          'images/doctor_profile.png',
          width: 50,
          height: 60,
          fit: BoxFit.cover,
        );
      }
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => showDoctorDetails(doctor, context),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: showImage(),
              ),
              10.widthBox,
              SizedBox(
                width: 300,
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Dr. ${doctor.name}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: Colors.black,
                              ),
                            ),
                            10.widthBox,
                            Text(doctor.qualification,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.3)),
                          ],
                        ),
                        10.heightBox,
                        Text(
                          doctor.hospitalName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
