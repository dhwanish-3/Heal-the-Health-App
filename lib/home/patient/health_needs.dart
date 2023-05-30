import 'package:heal_the_health_app/constants/imports.dart';

class HealthNeeds extends StatelessWidget {
  HealthNeeds({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

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

    goToAppointments() {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Appointments()));
    }

    FunctionFire(int index) {
      if (index == 0) {
        goToAddDoctors();
      } else if (index == 1) {
        goToInsurance();
      } else if (index == 2) {
        goToSymtoms();
      } else if (index == 3) {
        goToAppointments();
      } else if (index == 4) {
        goToDiseases();
      }
    }

    List<CustomIcon> customIcons = [
      CustomIcon(
          name: "Visit\nDoctor",
          icon: 'images/doctors.png',
          onTap: () => goToAddDoctors()),
      CustomIcon(
          name: "Health\nInsurance",
          icon: 'images/insurance.png',
          onTap: () => goToInsurance),
      CustomIcon(
          name: "Disease\nPredictor",
          icon: 'images/predictor.png',
          onTap: () => goToSymtoms()),
      CustomIcon(
          name: "Health\nVisits",
          icon: 'images/appointment.png',
          onTap: () => goToAppointments()),
      CustomIcon(
          name: "Disease\nDetails",
          icon: 'images/details.png',
          onTap: () => goToDiseases()),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(customIcons.length, (index) {
        if (index == 2) {
          return InkWell(
            onTap: () => FunctionFire(index),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(3),
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
                4.heightBox,
                Text(
                  customIcons[index].name,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        }
        if (index == 4) {
          return InkWell(
            onTap: () => FunctionFire(index),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(7),
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
        }
        return InkWell(
          onTap: () => FunctionFire(index),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(12),
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
