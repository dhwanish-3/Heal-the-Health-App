import 'package:heal_the_health_app/constants/imports.dart';

class AppointmentBackend {
  Future<void> upcomingToCompleted(
      AuthNotifier authNotifier,
      List<DoctorUser> DoctorsUpcoming,
      List<DoctorUser> DoctorsCompleted) async {
    if (authNotifier.patientDetails!.upcoming!.isNotEmpty &&
        authNotifier.patientDetails!.upcoming![0].dateTime!
            .isBefore(DateTime.now())) {
      authNotifier.patientDetails!.completed!
          .insert(0, authNotifier.patientDetails!.upcoming![0]);
      authNotifier.patientDetails!.upcoming!.removeAt(0);
      DoctorsCompleted.insert(0, DoctorsUpcoming[0]);
      DoctorsUpcoming.removeAt(0);
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(authNotifier.patientDetails!.uid)
          .update({
        'upcoming':
            DoctorUser().getJson(authNotifier.patientDetails!.upcoming ?? []),
        'completed':
            DoctorUser().getJson(authNotifier.patientDetails!.completed ?? [])
      });
      DoctorsCompleted[0]
          .completed!
          .insert(0, authNotifier.patientDetails!.completed![0]);
      DoctorsCompleted[0].upcoming!.removeWhere((object) =>
          object.dateTime ==
          authNotifier.patientDetails!.completed![0].dateTime);
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(DoctorsCompleted[0].uid)
          .update({
        'upcoming': DoctorUser().getJson(DoctorsCompleted[0].upcoming ?? []),
        'completed': DoctorUser().getJson(DoctorsCompleted[0].completed ?? [])
      });
      await upcomingToCompleted(
          authNotifier, DoctorsUpcoming, DoctorsCompleted);
    }
  }

  Future<void> cancelAppointment(
      int index,
      AuthNotifier authNotifier,
      List<DoctorUser> DoctorsUpcoming,
      List<DoctorUser> DoctorsCancelled) async {
    authNotifier.patientDetails!.cancelled!
        .insert(0, authNotifier.patientDetails!.upcoming![index]);
    authNotifier.patientDetails!.upcoming!.removeAt(index);
    DoctorsCancelled.insert(0, DoctorsUpcoming[index]);
    DoctorsUpcoming.removeAt(index);
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(authNotifier.patientDetails!.uid)
        .update({
      'upcoming':
          DoctorUser().getJson(authNotifier.patientDetails!.upcoming ?? []),
      'cancelled':
          DoctorUser().getJson(authNotifier.patientDetails!.cancelled ?? [])
    });
    if (!DoctorsCancelled[0]
        .cancelled!
        .contains(authNotifier.patientDetails!.cancelled![0])) {
      DoctorsCancelled[0]
          .cancelled!
          .insert(0, authNotifier.patientDetails!.cancelled![0]);
    }

    // debugPrint('cancel[0]${authNotifier.patientDetails!.cancelled![0].id}');
    // debugPrint('upc[0]${authNotifier.patientDetails!.upcoming![0]}');
    // debugPrint('doccancelcancelled[0]${DoctorsCancelled[0].cancelled![0].id}');
    // if (DoctorsCancelled[0].upcoming!.isNotEmpty) {
    //   debugPrint('doccancelupcoming[0]${DoctorsCancelled[0].upcoming![0].id}');
    // }
    DoctorsCancelled[0].upcoming!.removeWhere((object) =>
        object.dateTime == authNotifier.patientDetails!.cancelled![0].dateTime);
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(DoctorsCancelled[0].uid)
        .update({
      'upcoming': DoctorUser().getJson(DoctorsCancelled[0].upcoming ?? []),
      'cancelled': DoctorUser().getJson(DoctorsCancelled[0].cancelled ?? [])
    });
  }

  Future<void> rescheduleAppointment(int index, AuthNotifier authNotifier,
      List<DoctorUser> DoctorsUpcoming) async {
    DoctorUser doctor = DoctorsUpcoming[index];
    Appointment appointment = authNotifier.patientDetails!.upcoming![index];
    authNotifier.patientDetails!.upcoming!.removeAt(index);
    DoctorsUpcoming.removeAt(index);
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(authNotifier.patientDetails!.uid)
        .update({
      'upcoming':
          DoctorUser().getJson(authNotifier.patientDetails!.upcoming ?? []),
    });
    doctor.upcoming!.remove(appointment);
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(doctor.uid)
        .update({
      'upcoming': DoctorUser().getJson(doctor.upcoming ?? []),
    });
  }
}
