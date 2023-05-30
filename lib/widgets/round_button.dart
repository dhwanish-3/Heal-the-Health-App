import 'package:heal_the_health_app/constants/imports.dart';

class RoundButton extends StatelessWidget {
  AuthNotifier? authNotifier;
  final String title;
  final VoidCallback onTap;
  final bool loading;
  RoundButton(
      {Key? key,
      this.authNotifier,
      required this.title,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (authNotifier != null && authNotifier!.patientDetails == null) {
      return InkWell(
        onTap: onTap,
        child: Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  stops: [0, 0, 1],
                  colors: [
                    Color.fromARGB(255, 255, 127, 110),
                    Color.fromARGB(255, 255, 244, 40),
                    Color.fromARGB(255, 255, 123, 0),
                  ],
                )),
            child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    )
                  : Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white, fontFamily: bold, fontSize: 15),
                    ),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: onTap,
        child: Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 77, 250, 204),
                  Color.fromARGB(255, 71, 200, 255),
                  Color.fromARGB(255, 141, 255, 202),
                ],
                stops: [0, 0, 1],
              ),
            ),
            child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    )
                  : Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white, fontFamily: bold, fontSize: 15),
                    ),
            ),
          ),
        ),
      );
    }
  }
}
