import 'package:heal_the_health_app/constants/imports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final PatientUser _user = PatientUser();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _nameController.dispose();
  }

  @override
  void initState() {
    AuthNotifier authNotifier;
    UserShared userShared;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      userShared = Provider.of<UserShared>(context, listen: false);
      _authService.initializePatient(authNotifier);
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

    RegExp regExp =
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');

    if (!regExp.hasMatch(_user.emailid)) {
      Utils().toastMessage("Enter a valid email id");
      return false;
    } else {
      authNotifier.setLoading(true);
      // authNotifier =
      await _authService.signUpPatient(_user, authNotifier);
      if (authNotifier.user != null) {
        authNotifier.setLoading(false);
        return true;
      }
      authNotifier.setLoading(false);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    UserShared userShared = Provider.of<UserShared>(context, listen: false);
    return Scaffold(
      appBar: GradientAppBar(
          title: 'SignUp',
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
                          onSaved: (newVal) {
                            _user.name = newVal as String;
                          },
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            hintText: 'Name',
                            prefixIcon: Icon(Icons.auto_fix_normal_rounded),
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
                      title: 'Sign Up',
                      loading: authNotifier.loading ?? false,
                      onTap: () async {
                        bool success = await _submitForm();
                        if (success == true) {
                          await userShared.saveUser('patient'); //new
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UserFormFillScreen()));
                        } else {
                          debugPrint('failed');
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Are you a Doctor? '),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNames.doctorsignup);
                          },
                          child: const Text('Sign Up as Doctor'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text('Login'))
                    ],
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
                      child: const Center(child: Text('Sign Up with Phone')),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
