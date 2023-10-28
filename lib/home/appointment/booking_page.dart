import 'dart:convert';

import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/appointment/booked.dart';
import 'package:table_calendar/table_calendar.dart';

import 'date_time.dart';

class BookingPage extends StatefulWidget {
  final DoctorUser? doctor;
  const BookingPage({Key? key, this.doctor}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  //declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = true;
  bool _timeSelected = false;
  int times = -1;
  String getAppointmentString(int index) {
    if (widget.doctor != null) {
      return widget.doctor!.schedule![index];
    }
    // index = (index / 2).round();
    if (index % 2 != 0) {
      times++;
      if (times + 10 > 12) {
        return '${(times + 10 - 12).toString().padLeft(2, '0')}:00 PM';
      } else {
        return '${(times + 10).toString().padLeft(2, '0')}:00 AM';
      }
    } else {
      if (times + 10 > 12) {
        return '${(times + 10 - 12).toString().padLeft(2, '0')}:30 PM';
      } else {
        return '${(times + 10).toString().padLeft(2, '0')}:30 AM';
      }
    }
  }

  Future<Appointment> getAppointments(String id) async {
    return await FirebaseFirestore.instance
        .collection('Appointments')
        .doc(id)
        .get()
        .then((value) =>
            Appointment.fromMap(value.data() as Map<String, dynamic>));
  }

  DateTime getDateTime(String date, String time) {
    String formattedTime =
        DateFormat("HH:mm").format(DateFormat.jm().parse(time));
    String dateTimeString = '$date $formattedTime';
    return DateTime.parse(dateTimeString);
  }

  Future<bool> checkDoctorFree(String date, String time) async {
    DateTime dateTime = getDateTime(date, time);

    for (var upcomingAppointment in widget.doctor!.upcoming!) {
      debugPrint(upcomingAppointment.id);
      if (upcomingAppointment.dateTime!.isAtSameMomentAs(dateTime)) {
        return false;
      }
      if (upcomingAppointment.dateTime!.isAfter(dateTime)) {
        return true;
      }
    }
    debugPrint('dateTime$dateTime');
    return true;
  }

  List<String> getJson(List<Appointment> appointment) {
    List<String> json = [];
    for (var custom in appointment) {
      json.add(jsonEncode(custom.toMap()));
    }
    return json;
  }

  Future<void> bookAppointment(
      PatientUser? patient, String date, String time) async {
    DateTime appointmentTime = getDateTime(date, time);
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    if (widget.doctor != null && patient != null) {
      Map<String, dynamic> appointmentJson = {
        "id": id,
        "dateTime": appointmentTime,
        "date": date,
        "time": time,
        "patient": patient.uid,
        "doctor": widget.doctor!.uid,
        "status": "upcoming",
      };
      Appointment appointment = Appointment.fromMap(appointmentJson);
      // await FirebaseFirestore.instance
      //     .collection('Appointments')
      //     .doc(id)
      //     .set(appointment.toMap());
      // for uppdating the doctors appointment list
      List<Appointment> doctorUpcoming = widget.doctor!.upcoming ?? [];
      int index = 0;
      for (var upcoming in doctorUpcoming) {
        if (upcoming.dateTime!.isAfter(appointmentTime)) {
          doctorUpcoming.insert(index, appointment);
          break;
        }
        index++;
      }
      // to add if list is empty or every appointment is before the new appointment
      if (index == doctorUpcoming.length) {
        doctorUpcoming.add(appointment);
      }
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(widget.doctor!.uid)
          .update({'upcoming': getJson(doctorUpcoming)});
      // for uppdating the patients appointment list
      List<Appointment> patientUpcoming = patient.upcoming ?? [];
      index = 0;
      for (var upcoming in patientUpcoming) {
        if (upcoming.dateTime!.isAfter(appointmentTime)) {
          patientUpcoming.insert(index, appointment);
          break;
        }
        index++;
      }
      if (index == patientUpcoming.length) {
        patientUpcoming.add(appointment);
      }
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(patient.uid)
          .update({'upcoming': getJson(patientUpcoming)});
    } else {
      Utils().toastMessage('Something Went Wrong,Try again lsater');
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Book an Appointment',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    10.heightBox,
                    _tableCalendar(),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                      child: Center(
                        child: Text(
                          'Select Consultation Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            _isWeekend
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 30),
                        alignment: Alignment.center,
                        child: const Text(
                          'Weekend is not available for Booking, please select another date',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: SizedBox(
                      width: 360,
                      height: 150, // Set the desired height of the grid
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          height: 260,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.5,
                            ),
                            itemCount: widget.doctor == null
                                ? 16
                                : widget.doctor!.schedule!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    _currentIndex = index;
                                    _timeSelected = true;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _currentIndex == index
                                          ? Colors.green
                                          : Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    color: _currentIndex == index
                                        ? Colors.blue
                                        : null,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    getAppointmentString(index),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _currentIndex == index
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
            SliverToBoxAdapter(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: RoundButton(
                  title: 'Book Appointment',
                  onTap: () async {
                    debugPrint(DateTime.now().toString());
                    if (_isWeekend) {
                      Utils().toastMessage("Please select a working day");
                    } else if (!(_timeSelected && _dateSelected)) {
                      Utils().toastMessage(
                          'Please select date and time of appointment');
                    } else if (!_timeSelected) {
                      Utils().toastMessage('Please select time of appointment');
                    } else if (!_dateSelected) {
                      Utils().toastMessage('Please select date of appointment');
                    } else {
                      //convert date/day/time into string first
                      final getDate = DateConverted.getDate(_currentDay);
                      final getDay = DateConverted.getDay(_currentDay.weekday);
                      final getTime = getAppointmentString(_currentIndex!);
                      debugPrint(getDate + getDay + getTime);
                      bool free = await checkDoctorFree(getDate, getTime);

                      if (free) {
                        ShowPopup(authNotifier, getDate, getTime);
                      } else {
                        Utils().toastMessage(
                            'Sorry...\nThe Doctor is busy at this time, Please select different time');
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ShowPopup(AuthNotifier authNotifier, String getDate, String getTime) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(25),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            title: const Text(
              'Confirm Appointment',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            content: const Text(
                'The Doctor is free at this time\nConfirm to book your Appointment'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Utils().toastMessage('Appointment was not Booked');
                  },
                  child: const Text('Go Back')),
              ElevatedButton(
                  onPressed: () async {
                    await bookAppointment(
                        authNotifier.patientDetails, getDate, getTime);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppointmentBooked()));
                  },
                  child: const Text('Confirm'))
            ],
          );
        });
  }

  //table calendar
  Widget _tableCalendar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // color: Color.fromARGB(255, 210, 235, 255)),
        gradient: LinearGradient(
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
          colors: [Color(0xffb6f4da), Color(0x8e66e4f5)],
          stops: [0, 1],
        ),
      ),
      child: TableCalendar(
        focusedDay: _focusDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(2023, 12, 31),
        calendarFormat: _format,
        currentDay: _currentDay,
        rowHeight: 46,
        calendarStyle: const CalendarStyle(
          todayDecoration:
              BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        onFormatChanged: (format) {
          setState(() {
            _format = format;
          });
        },
        onDaySelected: ((selectedDay, focusedDay) {
          setState(() {
            _currentDay = selectedDay;
            _focusDay = focusedDay;
            _dateSelected = true;

            //check if weekend is selected
            if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
              _isWeekend = true;
              _timeSelected = false;
              _currentIndex = null;
            } else {
              _isWeekend = false;
            }
          });
        }),
      ),
    );
  }
}
