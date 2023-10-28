import 'package:heal_the_health_app/constants/imports.dart';

class AppointmentBackend {
  Future<void> upcomingToCompleted(
      AuthNotifier authNotifier,
      List<DoctorUser> DoctorsUpcoming,
      List<DoctorUser> DoctorsCompleted) async {
    while (authNotifier.patientDetails!.upcoming!.isNotEmpty &&
        authNotifier.patientDetails!.upcoming![0].dateTime!
            .isBefore(DateTime.now())) {
      authNotifier.patientDetails!.completed!
          .insert(0, authNotifier.patientDetails!.upcoming![0]);
      authNotifier.patientDetails!.upcoming!.removeAt(0);
      DoctorsCompleted.insert(0, DoctorsUpcoming[0]);
      DoctorsUpcoming.removeAt(0);

      DoctorsCompleted[0]
          .completed!
          .insert(0, authNotifier.patientDetails!.completed![0]);
      DoctorsCompleted[0].upcoming!.removeWhere((object) =>
          object.dateTime ==
          authNotifier.patientDetails!.completed![0].dateTime);
    }
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(authNotifier.patientDetails!.uid)
        .update({
      'upcoming':
          Appointment().getJson(authNotifier.patientDetails!.upcoming ?? []),
      'completed':
          Appointment().getJson(authNotifier.patientDetails!.completed ?? [])
    });
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(DoctorsCompleted[0].uid)
        .update({
      'upcoming': Appointment().getJson(DoctorsCompleted[0].upcoming ?? []),
      'completed': Appointment().getJson(DoctorsCompleted[0].completed ?? [])
    });
    // await upcomingToCompleted(
    //     authNotifier, DoctorsUpcoming, DoctorsCompleted);
    // }
  }

  Future<void> upcomingToCompletedbyDoctor(
      AuthNotifier authNotifier,
      List<PatientUser> PatientsUpcoming,
      List<PatientUser> PatientsCompleted) async {
    if (authNotifier.doctorDetails!.upcoming!.isNotEmpty &&
        authNotifier.doctorDetails!.upcoming![0].dateTime!
            .isBefore(DateTime.now())) {
      authNotifier.doctorDetails!.completed!
          .insert(0, authNotifier.doctorDetails!.upcoming![0]);
      authNotifier.doctorDetails!.upcoming!.removeAt(0);
      PatientsCompleted.insert(0, PatientsUpcoming[0]);
      PatientsUpcoming.removeAt(0);
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(authNotifier.doctorDetails!.uid)
          .update({
        'upcoming':
            PatientUser().getJson(authNotifier.doctorDetails!.upcoming ?? []),
        'completed':
            PatientUser().getJson(authNotifier.doctorDetails!.completed ?? [])
      });
      PatientsCompleted[0]
          .completed!
          .insert(0, authNotifier.doctorDetails!.completed![0]);
      PatientsCompleted[0].upcoming!.removeWhere((object) =>
          object.dateTime ==
          authNotifier.doctorDetails!.completed![0].dateTime);
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(PatientsCompleted[0].uid)
          .update({
        'upcoming': PatientUser().getJson(PatientsCompleted[0].upcoming ?? []),
        'completed': PatientUser().getJson(PatientsCompleted[0].completed ?? [])
      });
      await upcomingToCompletedbyDoctor(
          authNotifier, PatientsUpcoming, PatientsCompleted);
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
          Appointment().getJson(authNotifier.patientDetails!.upcoming ?? []),
      'cancelled':
          Appointment().getJson(authNotifier.patientDetails!.cancelled ?? [])
    });
    if (!DoctorsCancelled[0]
        .cancelled!
        .contains(authNotifier.patientDetails!.cancelled![0])) {
      DoctorsCancelled[0]
          .cancelled!
          .insert(0, authNotifier.patientDetails!.cancelled![0]);
    }
    DoctorsCancelled[0].upcoming!.removeWhere((object) =>
        object.dateTime == authNotifier.patientDetails!.cancelled![0].dateTime);
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(DoctorsCancelled[0].uid)
        .update({
      'upcoming': Appointment().getJson(DoctorsCancelled[0].upcoming ?? []),
      'cancelled': Appointment().getJson(DoctorsCancelled[0].cancelled ?? [])
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
          Appointment().getJson(authNotifier.patientDetails!.upcoming ?? []),
    });
    doctor.upcoming!.remove(appointment);
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(doctor.uid)
        .update({
      'upcoming': Appointment().getJson(doctor.upcoming ?? []),
    });
  }

  Future<void> cancelAppointmentbyDoctor(
      int index,
      AuthNotifier authNotifier,
      List<PatientUser> PatientsUpcoming,
      List<PatientUser> PatientsCancelled) async {
    authNotifier.doctorDetails!.cancelled!
        .insert(0, authNotifier.doctorDetails!.upcoming![index]);
    authNotifier.doctorDetails!.upcoming!.removeAt(index);
    PatientsCancelled.insert(0, PatientsUpcoming[index]);
    PatientsUpcoming.removeAt(index);
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(authNotifier.doctorDetails!.uid)
        .update({
      'upcoming':
          PatientUser().getJson(authNotifier.doctorDetails!.upcoming ?? []),
      'cancelled':
          PatientUser().getJson(authNotifier.doctorDetails!.cancelled ?? [])
    });
    if (!PatientsCancelled[0]
        .cancelled!
        .contains(authNotifier.doctorDetails!.cancelled![0])) {
      PatientsCancelled[0]
          .cancelled!
          .insert(0, authNotifier.doctorDetails!.cancelled![0]);
    }
    PatientsCancelled[0].upcoming!.removeWhere((object) =>
        object.dateTime == authNotifier.doctorDetails!.cancelled![0].dateTime);
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(PatientsCancelled[0].uid)
        .update({
      'upcoming': PatientUser().getJson(PatientsCancelled[0].upcoming ?? []),
      'cancelled': PatientUser().getJson(PatientsCancelled[0].cancelled ?? [])
    });
  }
}
