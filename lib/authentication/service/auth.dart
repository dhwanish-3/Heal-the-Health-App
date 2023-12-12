import 'package:heal_the_health_app/constants/imports.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //to get user details
  Future<void> getPatientDetails(AuthNotifier authNotifier) async {
    if (authNotifier.user != null) {
      await FirebaseFirestore.instance //changes
          .collection('Patients')
          .doc(authNotifier.user!.uid)
          .get()
          .then((value) => authNotifier.setUserDetails(
              PatientUser.fromMap(value.data() as Map<String, dynamic>)));
    }
  }

  Future<void> getDoctorDetails(AuthNotifier authNotifier) async {
    if (authNotifier.user != null) {
      await FirebaseFirestore.instance //changes
          .collection('Doctors')
          .doc(authNotifier.user!.uid)
          .get()
          .then((value) => authNotifier.setDoctorDetails(
              DoctorUser.fromMap(value.data() as Map<String, dynamic>)));
    }
  }

  //login
  Future<AuthNotifier> logInPatient(
      PatientUser user, AuthNotifier authNotifier) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: user.emailid.toString(), password: user.password.toString());

      try {
        User user = _auth.currentUser as User;

        authNotifier.setUser(user);

        await getPatientDetails(authNotifier);

        return authNotifier;
      } catch (e) {
        Utils().toastMessage(e.toString());
        return authNotifier;
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
      return authNotifier;
    }
  }

  //login doctor
  Future<AuthNotifier> logInDoctor(
      DoctorUser user, AuthNotifier authNotifier) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: user.emailid.toString(), password: user.password.toString());

      try {
        User user = _auth.currentUser as User;

        authNotifier.setUser(user);
        authNotifier.setisDoctor(true);

        await getDoctorDetails(authNotifier);

        return authNotifier;
      } catch (e) {
        Utils().toastMessage(e.toString());
        return authNotifier;
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
      return authNotifier;
    }
  }

  //sign up
  Future<AuthNotifier> signUpPatient(
      PatientUser user, AuthNotifier authNotifier) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.emailid, password: user.password);
      try {
        _auth.currentUser!.updateDisplayName(user.name);
        uploadPatientData(user);
        authNotifier.setUser(_auth.currentUser);
        authNotifier.setUserDetails(user);
        return authNotifier;
      } catch (e) {
        Utils().toastMessage(e.toString());
        return authNotifier;
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
      return authNotifier;
    }
  }

  // signup Doctor
  Future<AuthNotifier> signUpDoctor(
      DoctorUser user, AuthNotifier authNotifier) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.emailid, password: user.password);
      try {
        _auth.currentUser!.updateDisplayName(user.name);
        uploadDoctorData(user);
        authNotifier.setUser(_auth.currentUser);
        authNotifier.setisDoctor(true);
        authNotifier.setDoctorDetails(user);
        return authNotifier;
      } catch (e) {
        Utils().toastMessage(e.toString());
        return authNotifier;
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
      return authNotifier;
    }
  }

  Future<void> uploadPatientData(PatientUser user) async {
    User? currentUser = _auth.currentUser;
    user.uid = currentUser!.uid;
    CollectionReference patientRef =
        FirebaseFirestore.instance.collection('Patients');
    await patientRef
        .doc(currentUser.uid)
        .set(user.toMap())
        .catchError((e) => debugPrint(e));
  }

  Future<void> uploadDoctorData(DoctorUser user) async {
    User? currentUser = _auth.currentUser;
    user.uid = currentUser!.uid;
    CollectionReference doctorRef =
        FirebaseFirestore.instance.collection('Doctors');
    await doctorRef
        .doc(currentUser.uid)
        .set(user.toMap())
        .catchError((e) => debugPrint(e));
  }

  Future<void> initializePatient(AuthNotifier authNotifier) async {
    User? user = _auth.currentUser;
    authNotifier.setUser(user);
    await getPatientDetails(authNotifier);
  }

  Future<bool> initializeDoctor(AuthNotifier authNotifier) async {
    User? user = _auth.currentUser;
    authNotifier.setUser(user);
    await getDoctorDetails(authNotifier);
    return true;
  }

  Future signOutPatient(AuthNotifier authNotifier, BuildContext context) async {
    try {
      await _auth.signOut();
      authNotifier.setUser(null);
      authNotifier.setDoctorDetails(null);
      authNotifier.setUserDetails(null);
      Navigator.push((context),
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signOutDoctor(AuthNotifier authNotifier, BuildContext context) async {
    try {
      await _auth.signOut();
      authNotifier.setUser(null);
      authNotifier.setDoctorDetails(null);
      authNotifier.setUserDetails(null);
      Navigator.push((context),
          MaterialPageRoute(builder: (context) => const DoctorLogIn()));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
