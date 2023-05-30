import 'package:heal_the_health_app/constants/imports.dart';

class OOPs extends StatefulWidget {
  const OOPs({super.key});

  @override
  State<OOPs> createState() => _OOPsState();
}

class _OOPsState extends State<OOPs> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 1000,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 8, 123, 255),
                  Color.fromARGB(158, 0, 119, 255),
                  Color.fromARGB(161, 121, 206, 255),
                ],
                stops: [0, 0, 1],
              ),
              // color: authNotifier.isDoctor == false
              //     ? const Color.fromARGB(255, 255, 181, 70)
              //     : const Color.fromARGB(255, 99, 255, 206)
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 180,
                      width: 180,
                      decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: const Center(
                          child: Image(
                              image: AssetImage('images/chatbot_nobg.png')))),
                  20.heightBox,
                  Text(
                    'OOPs..',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: authNotifier.isDoctor == true
                            ? const Color.fromARGB(255, 70, 255, 255)
                            : const Color.fromARGB(255, 255, 0, 0)),
                  ),
                  20.heightBox,
                  const Text(
                    'You are too early.',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 7, 7)),
                  ),
                  10.heightBox,
                  const Text(
                    'We are under construction',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 7, 7)),
                  ),
                  30.heightBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: RoundButton(
                        authNotifier: authNotifier,
                        title: 'Go Back',
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
