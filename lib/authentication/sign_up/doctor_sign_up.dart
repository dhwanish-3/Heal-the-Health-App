import 'package:heal_the_health_app/constants/imports.dart';

class DoctorSignUp extends StatefulWidget {
  const DoctorSignUp({super.key});

  @override
  State<DoctorSignUp> createState() => _DoctorSignUpState();
}

class _DoctorSignUpState extends State<DoctorSignUp> {
  final DoctorUser _user = DoctorUser();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _nameController = TextEditingController();
  Future<bool> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    RegExp regExp =
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');

    if (!regExp.hasMatch(_user.emailid)) {
      Utils().toastMessage("Enter a valid email id");
      return false;
    } else {
      authNotifier.setLoading(true);
      await _authService.signUpDoctor(_user, authNotifier);
      if (authNotifier.user != null) {
        authNotifier.setLoading(false);
        return true;
      }
      authNotifier.setLoading(false);
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    AuthNotifier authNotifier;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      UserShared userShared = Provider.of<UserShared>(context, listen: false);
      _authService.initializeDoctor(authNotifier);
    });

    super.initState();
  }

  gotToDoctorForm() {
    Navigator.pushNamed(context, RouteNames.doctortuserform);
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    UserShared userShared = Provider.of<UserShared>(context, listen: false);

    return Scaffold(
      appBar: GradientAppBar(
        authNotifier: authNotifier,
        title: 'Doctor SignUp',
      ),
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
                          onSaved: (newVal) {
                            _user.name = newVal as String;
                          },
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            hintText: 'Name',
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
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
                        const SizedBox(height: 20.0),
                        Consumer<AuthNotifier>(
                            builder: (context, value, child) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _confirmpasswordController,
                            obscureText: authNotifier.confirmPasswordShown!,
                            decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                labelText: 'Confirm Password',
                                prefixIcon:
                                    const Icon(Icons.lock_outline_rounded),
                                suffixIcon: authNotifier.confirmPasswordShown!
                                    ? IconButton(
                                        onPressed: () {
                                          authNotifier
                                              .setconfirmPasswordShown(false);
                                        },
                                        icon: const Icon(Ionicons.eye_outline),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          authNotifier
                                              .setconfirmPasswordShown(true);
                                        },
                                        icon: const Icon(
                                            Ionicons.eye_off_outline),
                                      ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (_confirmpasswordController.text !=
                                  _passwordController.text) {
                                return 'Your passwords didn`t match';
                              }
                              return null;
                            },
                          );
                        })
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Consumer<AuthNotifier>(builder: (context, value, child) {
                    return RoundButton(
                      authNotifier: authNotifier,
                      title: 'Sign Up as Doctor',
                      loading: authNotifier.loading ?? false,
                      onTap: () async {
                        bool success = await _submitForm();
                        if (success == true) {
                          userShared.saveUser('doctor');
                          gotToDoctorForm();
                        } else {
                          debugPrint('failed');
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Here by mistake ?'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNames.patientsignup);
                          },
                          child: const Text('Sign up as Patient'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have Doctor account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DoctorLogIn()));
                          },
                          child: const Text('Login'))
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
