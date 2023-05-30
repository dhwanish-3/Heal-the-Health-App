import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/doctor/appointments_doctor.dart';
import 'package:heal_the_health_app/home/doctor/edit_schedule.dart';

class DoctorTiles extends StatelessWidget {
  const DoctorTiles({super.key});

  @override
  Widget build(BuildContext context) {
    goToAddPatients() {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddPatients()));
    }

    goToEditSchedule() {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const EditSchedule()));
    }

    goToDiseases() {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DiseaseDetails()));
    }

    goToAppointments() {
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AppointmentsPageforDoctor()));
    }

    FunctionFire(int index) {
      if (index == 0) {
        goToAddPatients();
      } else if (index == 1) {
        goToEditSchedule();
      } else if (index == 2) {
        goToAppointments();
      } else if (index == 3) {
        goToDiseases();
      }
    }

    List<Tile> Tiles = [
      Tile(
          name: "Add\nPatient",
          icon: 'images/add_patient.png',
          onTap: () => goToAddPatients()),
      Tile(
          name: "Edit\nSchedule",
          icon: 'images/edit_schedule.png',
          onTap: () => goToEditSchedule),
      Tile(
          name: "Health\nVisits",
          icon: 'images/doc_app.png',
          onTap: () => goToAppointments()),
      Tile(
          name: "Disease\nDetails",
          icon: 'images/virus.png',
          onTap: () => goToDiseases()),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(Tiles.length, (index) {
        return InkWell(
          onTap: () => FunctionFire(index),
          child: Column(
            children: [
              Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 255, 162, 155),
                    Color.fromARGB(255, 255, 221, 120),
                    Color.fromARGB(255, 255, 188, 88)
                  ], stops: <double>[
                    0,
                    0,
                    1
                  ]),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  Tiles[index].icon,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                Tiles[index].name,
                textAlign: TextAlign.center,
              )
            ],
          ),
        );
      }),
    );
  }
}

class Tile {
  final String name;
  final String icon;
  final Function? onTap;
  Tile({
    required this.name,
    required this.icon,
    required this.onTap,
  });
}
