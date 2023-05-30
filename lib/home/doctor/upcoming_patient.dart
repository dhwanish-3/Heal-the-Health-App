import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/appointment/date_time.dart';
import 'package:heal_the_health_app/home/doctor/appointments_doctor.dart';

class UpcomingPatient extends StatelessWidget {
  UpcomingPatient({super.key});
  PatientUser patient = PatientUser();
  String getDayString(Appointment appointment) {
    if (appointment.dateTime!.year == DateTime.now().year &&
        appointment.dateTime!.month == DateTime.now().month) {
      if (appointment.dateTime!.day == DateTime.now().day) {
        return '${appointment.date}, Today';
      } else if (appointment.dateTime!.day == DateTime.now().day + 1) {
        return '${appointment.date}, Tomorrow';
      } else {
        return '${appointment.date}, ${DateConverted.getDay(appointment.dateTime!.weekday)}';
      }
    } else {
      return '${appointment.date} ,${DateConverted.getDay(appointment.dateTime!.weekday)}';
    }
  }

  Future<void> getPatientHere(String uid) async {
    // AppointmentBackend().upcomingToCompleted(authNotifier, DoctorsUpcoming)
    patient = await PatientUser().getPatient(uid);
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (authNotifier.doctorDetails!.upcoming!.isNotEmpty) {
      List<Appointment> upcoming = authNotifier.doctorDetails!.upcoming!;
      return Material(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const AppointmentsPageforDoctor())));
          },
          child: Container(
            width: double.maxFinite,
            height: 110,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 226, 111),
              borderRadius: BorderRadius.circular(25),
            ),
            child: FutureBuilder(
                future: getPatientHere(upcoming[0].patient ?? ''),
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
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            patient.imageUrl ?? '',
                            width: 60,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        10.widthBox,
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 260,
                                height: 20,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Text(
                                      '${patient.name}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              5.heightBox,
                              SizedBox(
                                width: 260,
                                height: 20,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Text('Age: ${patient.age.toString()}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            wordSpacing: 2,
                                            letterSpacing: 0.2)),
                                  ],
                                ),
                              ),
                              3.heightBox,
                              Container(
                                width: 270,
                                height: 30,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          Ionicons.calendar_outline,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, right: 10, top: 2),
                                          child: Text(
                                            getDayString(upcoming[0]),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 3),
                                          child: Icon(
                                            Ionicons.time_outline,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          upcoming[0].time ?? '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                }),
          ),
        ),
      );
    } else {
      return Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 207, 64),
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
              child: Text(
            'No Upcoming Appointments',
            style: TextStyle(fontSize: 16, color: Colors.white),
          )));
    }
  }
}
