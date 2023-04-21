import 'package:heal_the_health_app/constants/imports.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  Future<void> updatePatientData(
      AuthNotifier authNotifier,
      String uid,
      String nickName,
      String imageUrl,
      String dob,
      int height,
      int weight,
      bool smoker,
      bool alcoholic,
      bool physicallyActive,
      bool pwd,
      int percentageDisability,
      String phone,
      int age) async {
    authNotifier.patientDetails!.nickName = nickName;
    authNotifier.patientDetails!.imageUrl = imageUrl;
    authNotifier.patientDetails!.birthDate = dob;
    authNotifier.patientDetails!.height = height;
    authNotifier.patientDetails!.weight = weight;
    authNotifier.patientDetails!.isSmoker = smoker;
    authNotifier.patientDetails!.isAlcoholic = alcoholic;
    authNotifier.patientDetails!.isPhysicallyActive = physicallyActive;
    authNotifier.patientDetails!.isPWD = pwd;
    authNotifier.patientDetails!.percentageofDisability = percentageDisability;
    authNotifier.patientDetails!.phoneNumber = phone;
    authNotifier.patientDetails!.age = age;

    return await FirebaseFirestore.instance
        .collection('Patients')
        .doc(uid)
        .update({
      'nickName': nickName,
      'imageUrl': imageUrl,
      'dob': dob,
      'height': height,
      'weight': weight,
      'isSmoker': smoker,
      'isAlcoholic': alcoholic,
      'isPhysicallyActive': physicallyActive,
      'isPWD': pwd,
      'percentageofDisability': percentageDisability,
      'phoneNumber': phone,
      'age': age
    });
  }

  Future<bool> _submitForm(AuthNotifier authNotifier, File? image) async {
    if (_myFormKey.currentState!.validate()) {
      if (_auth.currentUser == null) {
        debugPrint('user null');
        return false;
      } else {
        String id = _auth.currentUser!.uid;
        UploadTask uploadTask;
        String newUrl = '';

        if (image != null) {
          // debugPrint('image is mine $image');
          Reference ref = FirebaseStorage.instance.ref('/pics/$id');
          uploadTask = ref.putFile(image.absolute);

          await Future.value(uploadTask).then((value) async {
            newUrl = await ref.getDownloadURL();
          });
          debugPrint(newUrl);
        }
        // debugPrint('newurl is $newUrl');

        DateTime dob = DateTime.parse(_dobController.text);
        int age = calculateAge(dob);

        await updatePatientData(
                authNotifier,
                _auth.currentUser!.uid,
                _nicknameController.text,
                newUrl,
                _dobController.text,
                int.parse(_heightController.text),
                int.parse(_weightController.text),
                _isSmoker,
                _isAlcoholic,
                _isPhysicallyActive,
                _isPhysicallyChallenged,
                _percentageDisability,
                _phoneNumberController.text,
                age)
            .onError((error, stackTrace) {
          Utils().toastMessage(error.toString());
        });
      }
      if (authNotifier.patientDetails!.phoneNumber == '') {
        return false;
      } else {
        return true;
      }
    }
    return false;
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

  String profileUrl = '';

  getData() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    PatientUser user = authNotifier.patientDetails!;
    profileUrl = user.imageUrl ?? '';
    String nickName = user.nickName ?? '';
    String phoneNumber = user.phoneNumber ?? '';
    String dob = user.birthDate ?? '';
    int height = user.height ?? 150;
    int weight = user.weight ?? 50;
    _isSmoker = user.isSmoker ?? false;
    _isAlcoholic = user.isAlcoholic ?? false;
    _isPhysicallyChallenged = user.isPWD ?? false;
    _isPhysicallyActive = user.isPhysicallyActive ?? false;
    _nicknameController.text = nickName;
    _phoneNumberController.text = phoneNumber;
    _dobController.text = dob;
    _heightController.text = height.toString();
    _weightController.text = weight.toString();
    _selectionGender = user.gender == 1 ? 'Female' : 'Male';
  }

  bool firstTime = true;
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    if (firstTime) {
      getData();
      firstTime = false;
    }
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Edit Profile',
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
                          child: _showProfile(profileUrl, _image)),
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
          bool success = await _submitForm(authNotifier, _image);
          if (success == true) {
            await AuthService().initializePatient(authNotifier);
            goBack();
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
              'Done',
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

  goBack() {
    // Navigator.pushNamed(context, RouteNames.patienthome);
    Navigator.pop(context);
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

  _showProfile(String profileUrl, File? image) {
    if (profileUrl == '' && image == null) {
      return const Center(
          child: Icon(
        LineIcons.user,
        color: Colors.blue,
        size: 130,
      ));
    } else if (image != null) {
      return Container(
        height: 150.0,
        width: 150.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.file(
              _image as File,
              fit: BoxFit.cover,
            )),
      );
    } else {
      return Container(
        height: 150.0,
        width: 150.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(profileUrl)),
      );
    }
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
