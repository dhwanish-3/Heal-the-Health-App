import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/cardio.dart';
import 'package:heal_the_health_app/ml_models/cervical_cancer.dart';
import 'package:heal_the_health_app/ml_models/diabetes.dart';
import 'package:heal_the_health_app/ml_models/kidney.dart';
import 'package:heal_the_health_app/ml_models/lung_cancer.dart';
import 'package:heal_the_health_app/ml_models/parkinsons.dart';
import 'package:heal_the_health_app/ml_models/stroke.dart';
import 'package:heal_the_health_app/ml_models/thyroid.dart';
import 'package:heal_the_health_app/ml_models/x_ray.dart';

class ListModels extends StatefulWidget {
  const ListModels({super.key});

  @override
  State<ListModels> createState() => _ListModelsState();
}

class _ListModelsState extends State<ListModels> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Diagnose',
        authNotifier: authNotifier,
        leading: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    10.heightBox,
                    // _buildListTile('STROKE', 'stroke', gotoStroke()),

                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 149, 201, 247),
                          gradient: const LinearGradient(
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                              colors: [
                                Color.fromARGB(255, 141, 255, 164),
                                Color.fromARGB(255, 122, 182, 255)
                              ]),
                          border: Border.all(
                            color: const Color.fromARGB(255, 244, 217, 182),
                            width: 5,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: ListTile(
                          onTap: () => gotoStroke(),
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(
                                    image: AssetImage('images/stroke.png'))),
                          ),
                          title: const Text(
                            'STROKE',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    10.heightBox,
                    // _buildListTile('DIABETES', 'diabetes', gotoDiabetes()),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 149, 201, 247),
                          border: Border.all(
                            color: const Color.fromARGB(255, 244, 217, 182),
                            width: 5,
                          ),
                          gradient: const LinearGradient(
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                              colors: [
                                Color.fromARGB(255, 255, 201, 143),
                                Color.fromARGB(255, 255, 107, 107)
                              ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: ListTile(
                          onTap: () => gotoDiabetes(),
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage('images/diabetes.png'))),
                          ),
                          title: const Text(
                            'DIABETES',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    // _buildListTile('LUNG CANCER', 'lung', gotoLungCancer()),
                    10.heightBox,
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 244, 217, 182),
                            width: 5,
                          ),
                          color: const Color.fromARGB(255, 149, 201, 247),
                          gradient: const LinearGradient(
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                              colors: [
                                Color.fromARGB(255, 240, 255, 128),
                                Color.fromARGB(255, 255, 85, 207)
                              ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: ListTile(
                          onTap: () => gotoLungCancer(),
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(
                                    image: AssetImage('images/lung.png'))),
                          ),
                          title: const Text(
                            'LUNG CANCER',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    // _buildListTile('THYROID', 'thyroid', gotoThyroid()),
                    10.heightBox,
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 244, 217, 182),
                            width: 5,
                          ),
                          color: const Color.fromARGB(255, 149, 201, 247),
                          gradient: const LinearGradient(
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                              colors: [
                                Color.fromARGB(255, 166, 255, 175),
                                Color.fromARGB(255, 196, 232, 255)
                              ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: ListTile(
                          onTap: () => gotoThyroid(),
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(
                                    image: AssetImage('images/thyroid.png'))),
                          ),
                          title: const Text(
                            'THYROID',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    // _buildListTile(
                    // 'CHRONIC KIDNEY DISEASES', 'kidney', gotoKidney()),
                    10.heightBox,
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 244, 217, 182),
                            width: 5,
                          ),
                          color: const Color.fromARGB(255, 149, 201, 247),
                          gradient: const LinearGradient(
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                              colors: [
                                Color.fromARGB(255, 166, 139, 255),
                                Color.fromARGB(255, 255, 193, 193)
                              ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: ListTile(
                          onTap: () => gotoKidney(),
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(
                                    image: AssetImage('images/kidney.png'))),
                          ),
                          title: const Text(
                            'CHRONIC KIDNEY DISEASES',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    // _buildListTile(
                    //     'CARDIO VASCULAR DISEASES', 'cvd', gotoCVD()),
                    10.heightBox,
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 244, 217, 182),
                            width: 5,
                          ),
                          gradient: const LinearGradient(
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                              colors: [
                                Color.fromARGB(255, 255, 120, 120),
                                Color.fromARGB(255, 255, 163, 163)
                              ]),
                          color: const Color.fromARGB(255, 149, 201, 247),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: ListTile(
                          onTap: () => gotoCVD(),
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(
                                    image: AssetImage('images/cvd.png'))),
                          ),
                          title: const Text(
                            'CARDIO VASCULAR DISEASES',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    // _buildListTile(
                    //     'PARKINSON`S DISEASE', 'parkinsons', gotoparkinsons()),
                    10.heightBox,
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 244, 217, 182),
                            width: 5,
                          ),
                          gradient: const LinearGradient(
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                              colors: [
                                Color.fromARGB(255, 172, 132, 86),
                                Color.fromARGB(255, 114, 255, 206)
                              ]),
                          color: const Color.fromARGB(255, 149, 201, 247),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: ListTile(
                          onTap: () => gotoparkinsons(),
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(
                                    image:
                                        AssetImage('images/parkinsons.png'))),
                          ),
                          title: const Text(
                            'PARKINSON`S DISEASE',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    // _buildListTile(
                    //     'CERVICAL CANCER', 'cervical', gotoCervicalCancer()),
                    10.heightBox,
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 244, 217, 182),
                            width: 5,
                          ),
                          gradient: const LinearGradient(
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                              colors: [
                                Color.fromARGB(255, 251, 139, 255),
                                Colors.white
                              ]),
                          color: const Color.fromARGB(255, 149, 201, 247),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: ListTile(
                          onTap: () => gotoCervicalCancer(),
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(
                                    image: AssetImage('images/cervical.png'))),
                          ),
                          title: const Text(
                            'CERVICAL CANCER',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 149, 201, 247),
                          gradient: const LinearGradient(
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                              colors: [
                                Color.fromARGB(255, 240, 255, 243),
                                Color.fromARGB(255, 38, 37, 46)
                              ]),
                          border: Border.all(
                            color: const Color.fromARGB(255, 164, 162, 160),
                            width: 5,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: ListTile(
                          onTap: () => gotoXRay(),
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(
                                    image: AssetImage('images/x_ray.png'))),
                          ),
                          title: const Text(
                            'X-RAY',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget _buildListTile(String title, String image, Function? onTap) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Card(
        color: const Color.fromARGB(255, 149, 201, 247),
        child: Center(
          child: ListTile(
            onTap: () => onTap,
            leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image:
                      DecorationImage(image: AssetImage('images/$image.png'))),
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  gotoThyroid() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Thyroid()));
  }

  gotoCVD() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CardioScreen()));
  }

  gotoKidney() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Kidney()));
  }

  gotoDiabetes() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Diabetes()));
  }

  gotoCervicalCancer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CervCancer()));
  }

  gotoLungCancer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LungCancer()));
  }

  gotoparkinsons() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Parkinsons()));
  }

  gotoStroke() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Stroke()));
  }

  gotoXRay() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const XRayScreen()));
  }
}
