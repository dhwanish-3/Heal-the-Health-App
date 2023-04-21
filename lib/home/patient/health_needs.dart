import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/patient/add_doctors.dart';
import 'package:heal_the_health_app/home/disease_details.dart';
import 'package:heal_the_health_app/home/patient/insurance.dart';
import 'package:heal_the_health_app/ml_models/symptoms.dart';

class HealthNeeds extends StatelessWidget {
  const HealthNeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    goToAddDoctors() {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AddDoctors()));
    }

    goToInsurance() {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Insurance()));
    }

    goToDiseases() {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DiseaseDetails()));
    }

    goToSymtoms() {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SymptomsScreen()));
    }

    FunctionFire(int index) {
      if (index == 0) {
        goToAddDoctors();
      } else if (index == 1) {
        goToInsurance();
      } else if (index == 2) {
        goToDiseases();
      } else if (index == 3) {
        goToSymtoms();
      }
    }

    List<CustomIcon> customIcons = [
      CustomIcon(
          name: "Doctors\nAvailable",
          icon: 'images/appointment.png',
          onTap: () => goToAddDoctors()),
      CustomIcon(
          name: "Health\nInsurance",
          icon: 'images/person-diary.png',
          onTap: () => goToInsurance),
      CustomIcon(
          name: "Disease\nDetails",
          icon: 'images/virus.png',
          onTap: () => goToDiseases()),
      CustomIcon(
          name: "Disease\nPredictor",
          icon: 'images/more.png',
          onTap: () => goToSymtoms()),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(customIcons.length, (index) {
        return InkWell(
          onTap: () => FunctionFire(index),
          child: Column(
            children: [
              Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  customIcons[index].icon,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                customIcons[index].name,
                textAlign: TextAlign.center,
              )
            ],
          ),
        );
      }),
    );
  }
}

class CustomIcon {
  final String name;
  final String icon;
  final Function? onTap;
  CustomIcon({
    required this.name,
    required this.icon,
    required this.onTap,
  });
}
