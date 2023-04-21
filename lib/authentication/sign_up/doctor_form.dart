import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/doctor/doctor_home.dart';

class DoctorFormFillScreen extends StatefulWidget {
  const DoctorFormFillScreen({super.key});

  @override
  State<DoctorFormFillScreen> createState() => _DoctorFormFillScreenState();
}

class _DoctorFormFillScreenState extends State<DoctorFormFillScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref('Profile_Photos');
  final AuthService _authService = AuthService();
  File? _image;
  final picker = ImagePicker();

  final _qualificationController = TextEditingController();
  final _hospitalNameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _myFormKey = GlobalKey<FormState>();

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
    _hospitalNameController.dispose();
    _experienceController.dispose();
    _hospitalNameController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    AuthNotifier authNotifier;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);

      _authService.initializeDoctor(authNotifier);
    });
    // initialize current user
    // _authService.initializeDoctor(authNotifier); //error removed after moving to future

    super.initState();
  }

  String _selectedSpec = 'Gastroenterologist';
  List<String> diseaseTypesonlyList = [
    'Gastroenterologist',
    'Hepatologist',
    'Colorectal Surgeon',
    'Orthopedic Surgeon',
    'Neurologist',
    'Urologist',
    'Pulmonologist',
    'Dermatologist',
    'Infectious Disease Specialist',
    'General Practitioner',
    'Immunologist',
    'Otolaryngologist',
    'Pediatrician',
    'Cardiologist',
    'Vascular Surgeon',
    'Endocrinologist'
  ];
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: GradientAppBar(
        authNotifier: authNotifier,
        title: 'Doctor fill the form',
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
              key: _myFormKey,
              child: Column(
                children: [
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
                  // Text(authNotifier.doctorDetails!.uid.toString()),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _hospitalNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your hospital name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Hospital name',
                        hintText: 'Enter which hospital do you work in',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // DropdownButton(
                  //     items: diseaseTypeList
                  //         .map((e) => DropdownMenuItem(
                  //               value: e,
                  //               child: Text(e),
                  //             ))
                  //         .toList(),
                  //     onChanged: (val) {}),
                  DropdownButtonFormField(
                      value: _selectedSpec,
                      items: diseaseTypesonlyList
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedSpec = val as String;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.blue,
                      ),
                      decoration: InputDecoration(
                          labelText: 'Specialization',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),

                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _experienceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of years of experience';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Experience',
                        hintText: '2 years',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _qualificationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your qualification';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Qualification',
                        hintText: 'Enter your qualification',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        onPressed: () async {
          bool success = await _submitForm();
          if (success == true) {
            goToDoctorHome();
          }
        },
        label: const Text('Submit'),
        icon: const Icon(Icons.done),
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

          Future.value(uploadTask).then((value) async {
            newUrl = await ref.getDownloadURL();
          });
        }
        await DatabaseService(uid: id).updateDoctorData(
            authNotifier.doctorDetails!.name,
            newUrl,
            _qualificationController.text,
            _hospitalNameController.text,
            int.parse(_experienceController.text),
            _selectedSpec, []).onError((error, stackTrace) {
          Utils().toastMessage(error.toString());
        });
        if (authNotifier.doctorDetails!.name == '') {
          return false;
        } else {
          return true;
        }
      }
    }
    return false;
  }

  goToDoctorHome() {
    // Navigator.pushNamed(context, RouteNames.doctorhome);
    Navigator.push(
        (context), MaterialPageRoute(builder: (context) => const DoctorHome()));
  }
}
