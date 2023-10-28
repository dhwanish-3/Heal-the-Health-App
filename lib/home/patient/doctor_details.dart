import 'package:heal_the_health_app/constants/imports.dart';

class DoctorDetailsSheet extends StatelessWidget {
  final DoctorUser doctor;
  const DoctorDetailsSheet({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return SingleChildScrollView(
        child: Form(
            child: Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: showProfileImage(doctor),
        ),
        14.heightBox,
        Text(
          "Name:${doctor.name}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        5.heightBox,
        Text(
          doctor.specialization,
          style: const TextStyle(fontSize: 17),
        ),
        5.heightBox,
        Text(
          "Email id:${doctor.emailid}",
          style: const TextStyle(fontSize: 16),
        ),
        10.heightBox,
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              doctor.hospitalName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        10.heightBox,
        Row(
          children: [
            InfoCard(
                label: "Patients", value: doctor.patients!.length.toString()),
            15.widthBox,
            InfoCard(label: 'Experience', value: doctor.experience.toString())
          ],
        ),
        10.heightBox,
        Row(
          children: [
            OutlinedButton(
                onPressed: () async {
                  PatientUser patient =
                      authNotifier.patientDetails ?? PatientUser();
                  // patient.doctorsVisited = [];
                  debugPrint(patient.uid);
                  if (!patient.doctorsVisited!.contains(doctor.uid)) {
                    await uploadDoctorList(doctor, authNotifier);
                    await UpdateDoctors(doctor, authNotifier);
                  }

                  Navigator.pop(context);
                  // debugPrint(authNotifier.doctorDetails!.doctors.toString());
                },
                child: const Text('Add doctor')),
            14.widthBox,
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingPage(
                                doctor: doctor,
                              )));
                },
                child: const Text('Book Appointment')),
          ],
        )
      ],
    )));
  }

  ImageProvider showProfileImage(DoctorUser doctor) {
    if (doctor.imageUrl != '') {
      return NetworkImage(doctor.imageUrl.toString());
    } else {
      return const AssetImage('images/default.png');
    }
  }

  Future<void> uploadDoctorList(
      DoctorUser doctor, AuthNotifier authNotifier) async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection('Patients');
    authNotifier.addDoctor(
        authNotifier.patientDetails ?? PatientUser(), doctor.uid);
    await ref.doc(authNotifier.patientDetails!.uid).update(
        {'doctorsVisited': authNotifier.patientDetails!.doctorsVisited});
  }

  Future<void> UpdateDoctors(
      DoctorUser doctor, AuthNotifier authNotifier) async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection('Doctors');
    doctor.patients!.add(authNotifier.patientDetails!.uid ?? '');
    await ref.doc(doctor.uid).update({'patients': doctor.patients});
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
