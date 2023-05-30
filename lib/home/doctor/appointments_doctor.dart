import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/appointment/date_time.dart';

class AppointmentsPageforDoctor extends StatefulWidget {
  const AppointmentsPageforDoctor({super.key});

  @override
  State<AppointmentsPageforDoctor> createState() =>
      _AppointmentsPageforDoctorState();
}

enum FilterStatus { Upcoming, Complete, Cancel }

extension FilterExtensions on FilterStatus {
  String get name {
    switch (this) {
      case FilterStatus.Upcoming:
        return 'upcoming';
      case FilterStatus.Complete:
        return 'completed';
      case FilterStatus.Cancel:
        return 'cancelled';
      default:
        return '';
    }
  }
}

class _AppointmentsPageforDoctorState extends State<AppointmentsPageforDoctor> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;

  List<PatientUser> PatientsUpcoming = [];
  List<PatientUser> PatientsCompleted = [];
  List<PatientUser> PatientsCancelled = [];
  getPatientDetails(String uid, List<PatientUser> Patients) async {
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(uid)
        .get()
        .then((value) {
      print(value);
      Patients.add(PatientUser.fromMap(value.data() as Map<String, dynamic>));
    });
  }

  getPatients(
      List<Appointment> appointments, List<PatientUser> Patients) async {
    for (Appointment schedule in appointments) {
      await getPatientDetails(schedule.patient ?? '', Patients);
    }
  }

  @override
  Widget build(BuildContext context) {
    PatientsUpcoming = [];
    PatientsCompleted = [];
    PatientsCancelled = [];
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    List<Appointment> filteredSchedules = [];
    if (status == FilterStatus.Upcoming) {
      filteredSchedules = authNotifier.doctorDetails!.upcoming ?? [];
    } else if (status == FilterStatus.Complete) {
      filteredSchedules = authNotifier.doctorDetails!.completed ?? [];
    } else if (status == FilterStatus.Cancel) {
      filteredSchedules = authNotifier.doctorDetails!.cancelled ?? [];
    }
    List<PatientUser> filteredPatients = [];
    if (status == FilterStatus.Upcoming) {
      filteredPatients = PatientsUpcoming;
    } else if (status == FilterStatus.Complete) {
      filteredPatients = PatientsCompleted;
    } else if (status == FilterStatus.Cancel) {
      filteredPatients = PatientsCancelled;
    }
    bool isEmpty = false;
    Future<void> getList() async {
      if (status == FilterStatus.Upcoming) {
        await getPatients(
            authNotifier.doctorDetails!.upcoming ?? [], PatientsUpcoming);
        if (authNotifier.doctorDetails!.upcoming!.isNotEmpty) {
          await AppointmentBackend().upcomingToCompletedbyDoctor(
              authNotifier, PatientsUpcoming, PatientsCompleted);

          filteredSchedules = authNotifier.doctorDetails!.upcoming ?? [];
          filteredPatients = PatientsUpcoming;
          isEmpty = authNotifier.doctorDetails!.upcoming!.isEmpty;
        }
      } else if (status == FilterStatus.Complete) {
        await getPatients(
            authNotifier.doctorDetails!.completed ?? [], PatientsCompleted);
      } else if (status == FilterStatus.Cancel) {
        await getPatients(
            authNotifier.doctorDetails!.cancelled ?? [], PatientsCancelled);
      }
    }

    if (status == FilterStatus.Upcoming) {
      isEmpty = authNotifier.doctorDetails!.upcoming!.isEmpty;
    } else if (status == FilterStatus.Complete) {
      isEmpty = authNotifier.doctorDetails!.completed!.isEmpty;
    } else if (status == FilterStatus.Cancel) {
      isEmpty = authNotifier.doctorDetails!.cancelled!.isEmpty;
    }
    return Scaffold(
      appBar: GradientAppBar(
        authNotifier: authNotifier,
        title: "Your Appointments",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            20.heightBox,
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.Upcoming) {
                                  status = FilterStatus.Upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.Complete) {
                                  status = FilterStatus.Complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.Cancel) {
                                  status = FilterStatus.Cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                                child: Text(
                                    filterStatus.toString().substring(13))),
                          ),
                        )
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 189, 65),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      status.toString().substring(13),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
            10.heightBox,
            FutureBuilder(
              future: getList(),
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        100.heightBox,
                        SizedBox(
                            height: 150,
                            width: 150,
                            child: Column(
                              children: const [
                                Image(
                                    image: AssetImage(
                                        'images/no_appointment.png')),
                              ],
                            )),
                        40.heightBox,
                        Text(
                          "You have no ${status.name} appointments",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 255, 217, 65),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: filteredSchedules.length,
                        itemBuilder: ((context, index) {
                          var schedule = filteredSchedules[index];
                          PatientUser patient = filteredPatients[index];
                          bool isLast = filteredSchedules.length + 1 == index;
                          return Card(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20)),
                            margin: !isLast
                                ? const EdgeInsets.only(bottom: 15)
                                : EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          patient.imageUrl ?? '',
                                          width: 70,
                                          height: 90,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      10.widthBox,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            width: 230,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${patient.name}',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    10.widthBox,
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          6.heightBox,
                                          SizedBox(
                                            width: 220,
                                            height: 20,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Text(
                                                  'Age: ${patient.age}',
                                                  style: const TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          5.heightBox,
                                          ScheduleCard(
                                              authNotifier: authNotifier,
                                              date: DateConverted.getDay(
                                                  schedule.dateTime!.weekday),
                                              day: schedule.date ?? '',
                                              time: schedule.time ?? ''),
                                        ],
                                      )
                                    ],
                                  ),
                                  10.heightBox,
                                  getButtons(
                                      index, authNotifier, status, patient)
                                ],
                              ),
                            ),
                          );
                        })),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget getButtons(int index, AuthNotifier authNotifier, FilterStatus status,
      PatientUser patient) {
    if (status == FilterStatus.Upcoming) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                showPopUpforCancel(index, authNotifier);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ),
        ],
      );
    } else if (status == FilterStatus.Complete) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          padding: const EdgeInsets.all(8),
          // height: 28,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
          child: const Center(
            child: Text(
              'COMPLETED',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          ),
        ),
      );
    } else if (status == FilterStatus.Cancel) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          padding: const EdgeInsets.all(8),
          // height: 28,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
          child: const Center(
            child: Text(
              'CANCELLED',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  showPopUpforCancel(int index, AuthNotifier authNotifier) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(25),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            title: const Text('Are you Sure?'),
            content: const Text('Do you want to Cancel this Appointment'),
            actions: [
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () async {
                    await AppointmentBackend().cancelAppointmentbyDoctor(index,
                        authNotifier, PatientsUpcoming, PatientsCancelled);

                    setState(() {
                      Navigator.pop(context);
                      Utils().toastMessage(
                          'The Appointment has been cancelled successfully');
                    });
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }
}
