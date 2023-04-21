import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/oops.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  File? _image;

  final picker = ImagePicker();

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
  void initState() {
    AuthNotifier authNotifier;
    UserShared userShared;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      userShared = Provider.of<UserShared>(context, listen: false);
      AuthService().initializeDoctor(authNotifier);
    });
    // _authService.initializePatient(authNotifier);

    // initialize current user
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    String profileUrl = authNotifier.doctorDetails!.imageUrl;
    String userName = authNotifier.doctorDetails!.name;
    String userEmailid = authNotifier.doctorDetails!.emailid;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            20.heightBox,
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                // Text(authNotifier.patientDetails!.imageUrl ?? ''),
                Expanded(
                  child: Center(
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 200, 0),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100))),
                        height: 200,
                        width: 200,
                        child: _showProfile(profileUrl, _image),
                      ),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              getImageGallery();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 255, 222, 32),
                                    Color.fromARGB(255, 255, 121, 24)
                                  ]),
                                  borderRadius: BorderRadius.circular(20)),
                              height: 40,
                              width: 40,
                              child: const Icon(Icons.edit),
                            ),
                          ))
                    ]),
                  ),
                ),
              ]),
            ),
            Text(
              userName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            5.heightBox,
            Text(
              userEmailid,
              style: const TextStyle(fontSize: 20),
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
              ),
              child: RoundButton(
                  authNotifier: authNotifier,
                  title: 'Edit Profile',
                  onTap: () {
                    Navigator.push((context),
                        MaterialPageRoute(builder: (context) => const OOPs()));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () => goTosettings(),
                      leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[200]),
                          child: const Icon(
                            Icons.settings_outlined,
                            color: Colors.orange,
                          )),
                      title: const Text(
                        'Settings',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.arrow_right,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () => goToAddPatients(),
                      leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[200]),
                          child: const Icon(
                            LineIcons.bookmarkAlt,
                            color: Colors.orange,
                          )),
                      title: const Text(
                        'Patients',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.arrow_right,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () => logout(),
                      leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[200]),
                          child: const Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                          )),
                      title: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.arrow_right,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _buildListTile(String title, IconData icon, void Function()? tap) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () => tap,
        leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey[200]),
            child: Icon(
              icon,
              color: Colors.blue,
            )),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.arrow_right,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  final _auth = FirebaseAuth.instance;

  uploadProfile(File? image) async {
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
      FirebaseFirestore.instance
          .collection('Doctors')
          .doc(id)
          .update({'imageUrl': newUrl});
    }
  }

  _showProfile(String profileUrl, File? image) {
    if (profileUrl == '' && image == null) {
      return const Center(
          child: Icon(
        LineIcons.user,
        color: Colors.orange,
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

  goTosettings() {
    debugPrint('settings');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OOPs()));
  }

  goToAddPatients() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddPatients()));
  }

  logout() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    debugPrint('logout');
    AuthService().signOutDoctor(authNotifier, context);
    Navigator.pushNamed(context, RouteNames.doctorlogin);
  }
}
