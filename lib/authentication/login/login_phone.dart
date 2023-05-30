import 'package:heal_the_health_app/constants/imports.dart';

class LoginwithPhone extends StatefulWidget {
  const LoginwithPhone({super.key});

  @override
  State<LoginwithPhone> createState() => _LoginwithPhoneState();
}

class _LoginwithPhoneState extends State<LoginwithPhone> {
  bool loading = false;
  final _phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'LogIn with Phone',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(children: [
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                  hintText: '+1 233 4567 890',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            80.heightBox,
            RoundButton(
                title: 'Login',
                loading: loading,
                onTap: () {
                  auth.verifyPhoneNumber(
                    phoneNumber: _phoneNumberController.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      Utils().toastMessage(e.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyCodeScreen(
                                    VerificationId: verificationId,
                                  )));
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().toastMessage(e.toString());
                    },
                  );
                })
          ]),
        ),
      ),
    );
  }
}
