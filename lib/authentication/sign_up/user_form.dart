import 'package:heal_the_health_app/constants/imports.dart';

class UserFormFillScreen extends StatefulWidget {
  const UserFormFillScreen({super.key});

  @override
  State<UserFormFillScreen> createState() => _UserFormFillScreenState();
}

class _UserFormFillScreenState extends State<UserFormFillScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref('Profile_Photos');
  final AuthService _authService = AuthService();
  File? _image;
  final picker = ImagePicker();

  final _conditionList = ['Male', 'Female'];
  final _mappingGender = {'Male': 2, 'Female': 1};
  String _selectionGender = 'Male';
  final _nicknameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dobController = TextEditingController();
  int gender = 2;
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _myFormKey = GlobalKey<FormState>();
  bool _isSmoker = false;
  bool _isAlcoholic = false;
  bool _isPhysicallyActive = false;
  bool _isPhysicallyChallenged = false;
  late int _percentageDisability = 0;

  pleaseshowDatePicker() {
    return showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1910),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        _dobController.text =
            DateFormat('yyyy-MM-dd').format(value as DateTime);
      });
    });
  }

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Utils().toastMessage("No image picked");
      }
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _phoneNumberController.dispose();
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    AuthNotifier authNotifier;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);

      _authService.initializePatient(authNotifier);
    });
    // initialize current user
    // _authService.initializePatient(authNotifier); //error removed after moving to future

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Fill Form',
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        // )
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
              key: _myFormKey,
              child: Column(
                children: [
                  20.heightBox,
                  Center(
                    child: InkWell(
                      onTap: () {
                        getImageGallery();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100))),
                          height: 200,
                          width: 200,
                          child: _image != null
                              ? Container(
                                  height: 150.0,
                                  width: 150.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: Image.file(
                                        _image as File,
                                        fit: BoxFit.cover,
                                      )),
                                )
                              : const Center(
                                  child: Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                  size: 60,
                                ))),
                    ),
                  ),
                  // Text(authNotifier.patientDetails!.uid.toString()),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _nicknameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your nickname';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Nickname',
                        hintText: 'Enter what you want to be called',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length != 10) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '123 6789 123',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                            child: TextField(
                          keyboardType: TextInputType.datetime,
                          controller: _dobController,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: pleaseshowDatePicker,
                                  child: const Icon(Icons.calendar_month)),
                              labelText: 'Date of birth',
                              hintText: 'YYYY-MM-DD',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: DropdownButtonFormField(
                              value: _selectionGender,
                              items: _conditionList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectionGender = val as String;
                                  gender = _mappingGender[val] as int;
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.blue,
                              ),
                              decoration: InputDecoration(
                                  labelText: 'Gender',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Height',
                        hintText: 'Enter your height',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _weightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Weight',
                        hintText: 'Enter your weight',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Checkbox(
                        value: _isSmoker,
                        activeColor: Colors.blue,
                        onChanged: (newBool) {
                          setState(() {
                            _isSmoker = newBool as bool;
                          });
                        }),
                    title: const Text(
                      'Are you a Smoker',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Checkbox(
                        value: _isAlcoholic,
                        activeColor: Colors.blue,
                        onChanged: (newBool) {
                          setState(() {
                            _isAlcoholic = newBool as bool;
                          });
                        }),
                    title: const Text(
                      'Are you Alcoholic',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Checkbox(
                        value: _isPhysicallyActive,
                        activeColor: Colors.blue,
                        onChanged: (newBool) {
                          setState(() {
                            _isPhysicallyActive = newBool as bool;
                          });
                        }),
                    title: const Text(
                      'Are you a PhysicallyActive',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Checkbox(
                        value: _isPhysicallyChallenged,
                        activeColor: Colors.blue,
                        onChanged: (newBool) {
                          setState(() {
                            _isPhysicallyChallenged = newBool as bool;
                          });
                        }),
                    title: const Text(
                      'Are you a Physically challenged',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  15.heightBox,
                  buildSlider(_isPhysicallyChallenged),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.transparent,
        onPressed: () async {
          bool success = await _submitForm();
          if (success == true) {
            goToHome();
          } else {
            Utils().toastMessage('Could not Proceed, Try again later');
          }
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 95, 225, 100), Colors.blue])),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              'Next',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Icon(
              Icons.done,
              color: Colors.white,
            )
          ]),
        ),
      ),
    );
  }

  Future<bool> _submitForm() async {
    if (_myFormKey.currentState!.validate()) {
      AuthNotifier authNotifier =
          Provider.of<AuthNotifier>(context, listen: false);
      if (_auth.currentUser == null) {
        debugPrint('user null');
        return false;
      } else {
        String id = _auth.currentUser!.uid;
        UploadTask uploadTask;
        String newUrl = '';
        if (_image != null) {
          Reference ref = FirebaseStorage.instance.ref('/pics/$id');
          uploadTask = ref.putFile(_image!.absolute);

          await Future.value(uploadTask).then((value) async {
            newUrl = await ref.getDownloadURL();
          });
        }

        DateTime dob = DateTime.parse(_dobController.text);
        int age = calculateAge(dob);
        await DatabaseService(uid: id)
            .updatePatientData(
                _auth.currentUser!.displayName as String,
                _nicknameController.text,
                newUrl,
                _dobController.text,
                int.parse(_heightController.text),
                int.parse(_weightController.text),
                _isSmoker,
                _isAlcoholic,
                _isPhysicallyActive,
                _isPhysicallyChallenged,
                0,
                [],
                [],
                _phoneNumberController.text,
                age,
                [])
            .onError((error, stackTrace) {
          Utils().toastMessage(error.toString());
        });
      }
      if (authNotifier.patientDetails!.name == '') {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  goToHome() {
    // Navigator.pushNamed(context, RouteNames.patienthome);
    Navigator.push(
        (context),
        MaterialPageRoute(
            builder: (context) => const MedicalConditionsScreen()));
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  Widget buildSlider(bool isPWD) {
    if (isPWD) {
      return Column(
        children: [
          Text(
            'Percentage of disabiltity : $_percentageDisability',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Slider(
              value: _percentageDisability.toDouble(),
              label: 'Percentage',
              min: 0,
              max: 100,
              inactiveColor: Colors.blue[_percentageDisability * 99],
              activeColor: Colors.blue[_percentageDisability * 99],
              onChanged: (val) {
                setState(() {
                  _percentageDisability = val.round();
                });
              }),
          70.heightBox
        ],
      );
    } else {
      return Container();
    }
  }
}
