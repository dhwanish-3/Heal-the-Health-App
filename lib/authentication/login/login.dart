import 'package:heal_the_health_app/constants/imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final PatientUser _user = PatientUser();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    AuthNotifier authNotifier;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      // UserShared userShared = Provider.of<UserShared>(context, listen: false);
      _authService.initializePatient(authNotifier);
    });
    // initialize current user
    // _authService.initializePatient(authNotifier); // gives error here
    super.initState();
  }

  Future<bool> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    authNotifier.setLoading(true);
    _user.emailid = _emailController.text;
    _user.password = _passwordController.text;
    authNotifier = await _authService.logInPatient(_user, authNotifier);
    if (authNotifier.user != null) {
      authNotifier.setLoading(false);
      UserShared userShared = Provider.of<UserShared>(context, listen: false);
      await userShared
          .getDiaryFormFirebase(authNotifier.patientDetails!.uid ?? '');
      return true;
    }
    authNotifier.setLoading(false);

    return false;
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    UserShared userShared = Provider.of<UserShared>(context, listen: false);
    return Scaffold(
      appBar: GradientAppBar(
          title: 'LogIn',
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        20.heightBox,
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          onSaved: (newVal) {
                            _user.emailid = newVal as String;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Consumer<AuthNotifier>(
                            builder: (context, value, child) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _passwordController,
                            onSaved: (newVal) {
                              _user.password = newVal as String;
                            },
                            obscureText: authNotifier.passwordShown!,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_open),
                                suffixIcon: authNotifier.passwordShown!
                                    ? IconButton(
                                        onPressed: () {
                                          authNotifier.setPasswordShown(false);
                                        },
                                        icon: const Icon(Ionicons.eye_outline),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          authNotifier.setPasswordShown(true);
                                        },
                                        icon: const Icon(
                                            Ionicons.eye_off_outline),
                                      ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              } else if (value.length < 6) {
                                return 'Please enter a password with atleast 6 characters';
                              }
                              return null;
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Consumer<AuthNotifier>(builder: (context, value, child) {
                    return RoundButton(
                      title: 'Log In',
                      loading: authNotifier.loading ?? false,
                      onTap: () async {
                        bool success = await _submitForm();
                        if (success == true) {
                          userShared.saveUser('patient');
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomePageDhwanish()));
                        } else {
                          debugPrint('failed');
                          Utils().toastMessage("Could not Login");
                        }
                      },
                    );
                  }),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()));
                        },
                        child: const Text('Forgot Password')),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Are you a Doctor? '),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNames.doctorlogin);
                          },
                          child: const Text('Log in as Doctor'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text('Sign Up'))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginwithPhone()));
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.lightBlue,
                          )),
                      child: const Center(child: Text('Login with Phone')),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
