import 'package:heal_the_health_app/constants/imports.dart';

class PatientDetailsSheet extends StatefulWidget {
  final PatientUser patient;
  const PatientDetailsSheet({super.key, required this.patient});

  @override
  State<PatientDetailsSheet> createState() => _PatientDetailsSheetState();
}

class _PatientDetailsSheetState extends State<PatientDetailsSheet> {
  final _detailsController = TextEditingController();

  _uploadMedicalConditions(PatientUser patient, Disease disease) async {
    patient.medicalConditions!.add(disease.index ?? 0);
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(patient.uid)
        .update({'medicalConditions': patient.medicalConditions});
  }

  getMedicalConditions(PatientUser patient) {
    List<Widget> medics = [];
    for (int dis in patient.medicalConditions ?? []) {
      medics.add(Column(
        children: [Text(diseasesList[dis]), 5.heightBox],
      ));
    }
    return medics;
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Form(
        child: OverflowBar(
      spacing: 20,
      overflowAlignment: OverflowBarAlignment.center,
      overflowSpacing: 20,
      children: [
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: showProfileImage(widget.patient),
              ),
              Text(
                widget.patient.name.toString(),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              5.heightBox,
              Text('Age : ${widget.patient.age}',
                  style: const TextStyle(
                    fontSize: 16,
                  )),
              5.heightBox,
              Text('Email id : ${widget.patient.emailid}',
                  style: const TextStyle(
                    fontSize: 16,
                  )),
              5.heightBox,
              const Text(
                "Medical Conditions : ",
                style: TextStyle(fontSize: 20, color: Colors.orange),
              ),
              8.heightBox,
              Column(
                children: getMedicalConditions(widget.patient),
              ),
              20.heightBox,
              TextFormField(
                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _detailsController,
                // onChanged: (value) {
                //   _detailsController.text = value;
                //   debugPrint(_detailsController.text);
                // },
                decoration: const InputDecoration(
                  labelText: 'Details',
                  prefixIcon: Icon(Icons.auto_fix_normal_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              10.heightBox,
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          Disease condition = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddmedicalConditions()));

                          await _uploadMedicalConditions(
                              widget.patient, condition);
                          setState(() {
                            Utils().toastMessage(
                                'Medical Condition successfully added');
                          });
                        },
                        child: const Text('Add medical\nCondition',
                            textAlign: TextAlign.center)),
                    10.widthBox,
                    ElevatedButton(
                        onPressed: () async {
                          DoctorUser doctor =
                              authNotifier.doctorDetails ?? DoctorUser();
                          await uploadDetails(widget.patient,
                              _detailsController.text, authNotifier);
                          Navigator.pop(context);
                          Utils().toastMessage(
                              'Details of visit has been added successfully');
                          // if (!doctor.patients!.contains(patient.uid)) {
                          //   authNotifier.addPatient(
                          //       authNotifier.doctorDetails ?? DoctorUser(),
                          //       patient.uid ?? '');
                          // }
                          // debugPrint(authNotifier.doctorDetails!.patients.toString());
                        },
                        child: const Text(
                          'Add Details\nof Visit',
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  ImageProvider showProfileImage(PatientUser patient) {
    if (patient.imageUrl != '') {
      return NetworkImage(patient.imageUrl.toString());
    } else {
      return const AssetImage('images/default.png');
    }
  }

  Future<void> uploadDetails(
      PatientUser patient, String details, AuthNotifier authNotifier) async {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    debugPrint(authNotifier.doctorDetails!.patients.toString());
    debugPrint(authNotifier.doctorDetails!.uid);
    if (!authNotifier.doctorDetails!.patients!.contains(patient.uid)) {
      authNotifier.doctorDetails!.patients!.add(patient.uid ?? '');
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(authNotifier.doctorDetails!.uid)
          .update({'patients': authNotifier.doctorDetails!.patients});
    }
    patient.detailsofVisit!.add("$date : $details");

    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(patient.uid)
        .update({'detailsofVisit': patient.detailsofVisit});
  }
}
