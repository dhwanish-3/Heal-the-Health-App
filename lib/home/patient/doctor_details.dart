import 'package:heal_the_health_app/constants/imports.dart';

class DoctorDetailsSheet extends StatelessWidget {
  final DoctorUser doctor;
  const DoctorDetailsSheet({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return StreamBuilder<DoctorUser>(builder: (context, snapshot) {
      return Form(
          child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: showProfileImage(doctor),
          ),
          10.heightBox,
          Text(
            doctor.name.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          10.heightBox,
          Text(
            doctor.emailid,
            style: const TextStyle(fontSize: 18),
          ),
          10.heightBox,
          Text(doctor.hospitalName),
          10.heightBox,
          Text(
            'Experience of ${doctor.experience} years',
            style: const TextStyle(fontSize: 20),
          ),
          20.heightBox,
          ElevatedButton(
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
              child: const Text('Add doctor'))
        ],
      ));
    });
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
    // for (var doctor in doctors) {
    //   await ref.doc(doctor).update({'patients': uid});
    // }
  }
}
