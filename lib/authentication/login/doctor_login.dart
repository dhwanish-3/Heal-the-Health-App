import 'package:heal_the_health_app/constants/imports.dart';

class DoctorLogIn extends StatefulWidget {
  const DoctorLogIn({super.key});

  @override
  State<DoctorLogIn> createState() => _DoctorLogInState();
}

class _DoctorLogInState extends State<DoctorLogIn> {
  final DoctorUser _user = DoctorUser();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

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
      UserShared userShared = Provider.of<UserShared>(context, listen: false);
      _authService.initializeDoctor(authNotifier);
    });
    // _authService.initializePatient(authNotifier);

    // initialize current user
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
    authNotifier = await _authService.logInDoctor(_user, authNotifier, context);
    if (authNotifier.user != null) {
      authNotifier.setLoading(false);
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
          title: 'Doctor LogIn',
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
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          onSaved: (newVal) {
                            _user.emailid = newVal as String;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_open),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Consumer<AuthNotifier>(builder: (context, value, child) {
                    return RoundButton(
                      title: 'Log in',
                      loading: authNotifier.loading ?? false,
                      onTap: () async {
                        bool success = await _submitForm();
                        if (success == true) {
                          userShared.saveUser('doctor');
                          goToDoctorForm();
                        } else {
                          debugPrint('failed');
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Are you not a Doctor?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNames.patientlogin);
                          },
                          child: const Text('Log in as Patient'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNames.doctorsignup);
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
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.lightBlue,
                          )),
                      child: const Center(child: Text('Login with Phone')),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  goToDoctorForm() {
    Navigator.pushNamed(context, RouteNames.doctortuserform);
  }
}
