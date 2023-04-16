import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/disease_details.dart';

class DoctorTiles extends StatelessWidget {
  const DoctorTiles({super.key});

  @override
  Widget build(BuildContext context) {
    goToAddPatients() {
      debugPrint('sdsadsadjkas');
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddPatients()));
    }

    goToListPatients() {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ListofPatients()));
    }

    goToDiseases() {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DiseaseDetails()));
    }

    goToAddModels() {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ListModels()));
    }

    FunctionFire(int index) {
      if (index == 0) {
        goToAddPatients();
      } else if (index == 1) {
        goToListPatients();
      } else if (index == 2) {
        goToDiseases();
      } else if (index == 3) {
        goToAddModels();
      }
    }

    List<Tile> Tiles = [
      Tile(
          name: "Add\nPatient",
          icon: 'images/add_patient.png',
          onTap: () => goToAddPatients()),
      Tile(
          name: "Your\nPatients",
          icon: 'images/person-diary.png',
          onTap: () => goToListPatients),
      Tile(
          name: "Disease\nDetails",
          icon: 'images/virus.png',
          onTap: () => goToDiseases()),
      Tile(
          name: "More\n",
          icon: 'images/more.png',
          onTap: () => goToAddModels()),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(Tiles.length, (index) {
        return InkWell(
          onTap: () => FunctionFire(index),
          child: Column(
            children: [
              Container(
                width: 75,
                height: 75,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.4),
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
