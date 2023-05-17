import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/appointment/date_time.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
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

class _AppointmentsState extends State<Appointments> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;

  List<DoctorUser> DoctorsUpcoming = [];
  List<DoctorUser> DoctorsCompleted = [];
  List<DoctorUser> DoctorsCancelled = [];
  getDoctorDetails(String uid, List<DoctorUser> Doctors) async {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(uid)
        .get()
        .then((value) {
      Doctors.add(DoctorUser.fromMap(value.data() as Map<String, dynamic>));
    });
  }

  // getDoctors(PatientUser patient,List<DoctorUser> Doctors) async {
  //   for (Appointment schedule in patient.upcoming ?? []) {
  //     await getDoctorDetails(schedule.doctor ?? '', Doctors);
  //   }
  //   for (Appointment schedule in patient.completed ?? []) {
  //     await getDoctorDetails(schedule.doctor ?? '', Doctors);
  //   }
  //   for (Appointment schedule in patient.cancelled ?? []) {
  //     await getDoctorDetails(schedule.doctor ?? '', Doctors);
  //   }
  // }
  getDoctors(List<Appointment> appointments, List<DoctorUser> Doctors) async {
    for (Appointment schedule in appointments) {
      await getDoctorDetails(schedule.doctor ?? '', Doctors);
    }
  }

  @override
  Widget build(BuildContext context) {
    DoctorsUpcoming = [];
    DoctorsCompleted = [];
    DoctorsCancelled = [];
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    // List<dynamic> filteredSchedules = schedules.where((var schedule) {
    // switch (schedule['status']) {
    //   case 'Upcoming':
    //     schedule['status'] = FilterStatus.Upcoming;
    //     break;
    //   case 'Complete':
    //     schedule['status'] = FilterStatus.Complete;
    //     break;
    //   case 'Cancel':
    //     schedule['status'] = FilterStatus.Cancel;
    //     break;
    // }
    // return schedule['status'] == status;
    // switch (schedule.status) {
    //     case 'upcoming':
    //       schedule.status = FilterStatus.Upcoming.name;
    //       break;
    //     case 'completed':
    //       schedule.status = FilterStatus.Complete.name;
    //       break;
    //     case 'cancelled':
    //       schedule.status = FilterStatus.Cancel.name;
    //       break;
    //   }
    //   return schedule.status == status.name;
    // }).toList();
    List<Appointment> filteredSchedules = [];
    if (status == FilterStatus.Upcoming) {
      filteredSchedules = authNotifier.patientDetails!.upcoming ?? [];
    } else if (status == FilterStatus.Complete) {
      filteredSchedules = authNotifier.patientDetails!.completed ?? [];
    } else if (status == FilterStatus.Cancel) {
      filteredSchedules = authNotifier.patientDetails!.cancelled ?? [];
    }
    List<DoctorUser> filteredDoctors = [];
    if (status == FilterStatus.Upcoming) {
      filteredDoctors = DoctorsUpcoming;
    } else if (status == FilterStatus.Complete) {
      filteredDoctors = DoctorsCompleted;
    } else if (status == FilterStatus.Cancel) {
      filteredDoctors = DoctorsCancelled;
    }
    bool isEmpty = false;
    Future<void> getList() async {
      if (status == FilterStatus.Upcoming) {
        await getDoctors(
            authNotifier.patientDetails!.upcoming ?? [], DoctorsUpcoming);
      } else if (status == FilterStatus.Complete) {
        await getDoctors(
            authNotifier.patientDetails!.completed ?? [], DoctorsCompleted);
      } else if (status == FilterStatus.Cancel) {
        await getDoctors(
            authNotifier.patientDetails!.cancelled ?? [], DoctorsCancelled);
      }

      if (authNotifier.patientDetails!.upcoming!.isNotEmpty) {
        await AppointmentBackend().upcomingToCompleted(
            authNotifier, DoctorsUpcoming, DoctorsCompleted);
        if (status == FilterStatus.Upcoming) {
          filteredSchedules = authNotifier.patientDetails!.upcoming ?? [];
          filteredDoctors = DoctorsUpcoming;
          isEmpty = authNotifier.patientDetails!.upcoming!.isEmpty;
        }
      }
    }

    if (status == FilterStatus.Upcoming) {
      isEmpty = authNotifier.patientDetails!.upcoming!.isEmpty;
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
                                  print(authNotifier.patientDetails!.cancelled);
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
                        color: Colors.blue,
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
                } else if (isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        50.heightBox,
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
                        20.heightBox,
                        const Text(
                          "You have no Upcoming appointments",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 24, color: Colors.blueAccent),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: RoundButton(
                              title: 'New Appointment',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BookingPage()));
                              }),
                        )
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: filteredSchedules.length,
                        itemBuilder: ((context, index) {
                          var schedule = filteredSchedules[index];
                          DoctorUser doctor = filteredDoctors[index];
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
                                          doctor.imageUrl,
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
                                                      'Dr. ${doctor.name}',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    10.widthBox,
                                                    Text(
                                                      doctor.specialization,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
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
                                                  doctor.hospitalName,
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
                                      index, authNotifier, status, doctor)
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
      DoctorUser doctor) {
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
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                showPopUpforReschedule(index, authNotifier, doctor);
              },
              child: const Text(
                'Reschedule',
                style: TextStyle(color: Colors.white),
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  onPressed: () async {
                    await AppointmentBackend().cancelAppointment(
                        index, authNotifier, DoctorsUpcoming, DoctorsCancelled);

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

  showPopUpforReschedule(
      int index, AuthNotifier authNotifier, DoctorUser doctor) {
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
            content: const Text('Do you want to Reschedule this Appointment'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  onPressed: () async {
                    await AppointmentBackend().rescheduleAppointment(
                        index, authNotifier, DoctorsUpcoming);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingPage(
                                  doctor: doctor,
                                )));
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {Key? key, required this.date, required this.day, required this.time})
      : super(key: key);
  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 240,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                  size: 15,
                ),
                3.widthBox,
                Text(
                  '$day, $date',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                10.widthBox,
                const Icon(
                  Icons.access_alarm,
                  color: Colors.blue,
                  size: 17,
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
