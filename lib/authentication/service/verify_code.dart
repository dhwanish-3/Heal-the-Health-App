import 'package:heal_the_health_app/constants/imports.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String VerificationId;
  const VerifyCodeScreen({Key? key, required this.VerificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final VerificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(
            height: 80,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: VerificationCodeController,
            decoration: const InputDecoration(
                hintText: '6 digit code',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          const SizedBox(
            height: 80,
          ),
          RoundButton(
              title: 'Verify',
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.VerificationId,
                    smsCode: VerificationCodeController.text.toString());
                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserFormFillScreen()));
                } catch (e) {
                  Utils().toastMessage(e.toString());
                }
              })
        ]),
      ),
    );
  }
}
