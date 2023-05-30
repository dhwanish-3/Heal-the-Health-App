import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/home/oops.dart';
import 'package:heal_the_health_app/home/patient/edit_profile.dart';
import 'package:heal_the_health_app/home/patient/list_doctors.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
    Future.delayed(Duration.zero).then((value) async {
      authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      userShared = Provider.of<UserShared>(context, listen: false);
      // await AuthService().initializePatient(authNotifier);
      // setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    String profileUrl = authNotifier.patientDetails!.imageUrl ?? '';
    String userName = authNotifier.patientDetails!.name ?? '';
    String nickName = authNotifier.patientDetails!.nickName ?? '';
    String userEmailid = authNotifier.patientDetails!.emailid;
    UserShared userShared = Provider.of<UserShared>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            30.heightBox,
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
                              color: const Color.fromARGB(255, 96, 244, 101),
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
                                    Colors.blue,
                                    Color.fromARGB(255, 111, 236, 115)
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
            20.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
              ),
              child: RoundButton(
                  title: 'Edit Profile',
                  onTap: () {
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()));
                  }),
            ),
            // 10.heightBox,
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
                            color: Colors.blue,
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
                      onTap: () => goToListofDoctors(),
                      leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[200]),
                          child: const Icon(
                            LineIcons.doctor,
                            color: Colors.blue,
                          )),
                      title: const Text(
                        'Doctors',
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
                      onTap: () => ShowPopUp(),
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
                        'LogOut',
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
            ),
            200.heightBox,
            TextButton(
              child: const Text('Made with ❤️ by Dhwanish'),
              onPressed: () {
                Utils()
                    .toastMessage('Contact me for any help reqarding the app');
              },
            ),
            20.heightBox
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
          .collection('Patients')
          .doc(id)
          .update({'imageUrl': newUrl});
    }
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

  goTosettings() {
    debugPrint('settings');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OOPs()));
  }

  goToListofDoctors() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ListDoctors()));
  }

  ShowPopUp() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(25),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            title: const Text('Log out'),
            content: const Text('Do you want to logout from this app'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  onPressed: () async {
                    await logout();
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }

  logout() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    UserShared userShared = Provider.of<UserShared>(context, listen: false);
    debugPrint('logout');

    AuthService().signOutPatient(authNotifier, context);
    userShared.ClearDiaryList();
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.patientlogin, (route) => false);
  }
}
