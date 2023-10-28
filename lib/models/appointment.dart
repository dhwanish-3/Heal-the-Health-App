import 'dart:convert';

class Appointment {
  String? id;
  DateTime? dateTime;
  String? date;
  String? time;
  String? patient;
  String? doctor;
  String? status;
  // Appointment(this.id, this.dateTime, this.date, this.time, this.patient,
  //     this.doctor, this.status);
  Appointment();
  Appointment.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    dateTime = DateTime.parse((data["dateTime"]));
    date = data["date"];
    time = data["time"];
    patient = data["patient"];
    doctor = data["doctor"];
    status = data["status"];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': (dateTime.toString()),
      'date': date,
      'time': time,
      'patient': patient,
      'doctor': doctor,
      'status': status,
    };
  }

  List<String> getJson(List<Appointment> appointment) {
    List<String> json = [];
    for (var custom in appointment) {
      json.add(jsonEncode(custom.toMap()));
    }
    return json;
  }

  // 2023-05-13 06:40:05.330916
  String getDate(DateTime dateTime) {
    return dateTime.toString().substring(0, 10);
  }

  String getTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    if (hour < 12) {
      return '${dateTime.toString().substring(11, 16)} AM';
    } else {
      return '${(dateTime.hour - 12).toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} PM';
    }
  }
}
