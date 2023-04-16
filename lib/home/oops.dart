import 'package:heal_the_health_app/constants/imports.dart';

class OOPs extends StatefulWidget {
  const OOPs({super.key});

  @override
  State<OOPs> createState() => _OOPsState();
}

class _OOPsState extends State<OOPs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 1000,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 99, 255, 206)),
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
                          child:
                              Image(image: AssetImage('images/chatbot.png')))),
                  20.heightBox,
                  const Text(
                    'OOPs..',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 115, 115)),
                  ),
                  20.heightBox,
                  const Text(
                    'Your too early.',
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
