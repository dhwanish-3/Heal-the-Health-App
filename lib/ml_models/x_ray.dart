import 'package:heal_the_health_app/constants/imports.dart';
import 'package:heal_the_health_app/ml_models/x_ray_result.dart';
import 'package:heal_the_health_app/models/x_ray.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<String> list = [
  'Atelectasis',
  'Cardiomegaly',
  'Consolidation',
  'Pleural effusion',
  'Hernia',
  'Infiltration',
  'Growth or Lumps',
  'No Finding',
  'Lung Nodule',
  'Pneumonia',
  'Pneumothorax'
];

List<String> description = [
  "Atelectasis is a complete or partial collapse of the entire or an area (lobe) of the lung. It occurs when the tiny air sacs (alveoli) within the lung become deflated or possibly filled with alveolar fluid. Atelectasis is one of the most common breathing complications after surgery.",
  '''The term "cardiomegaly" refers to an enlarged heart seen on any imaging test, including a chest X-ray.  An enlarged heart  isn't a disease, but rather a sign of another condition.Other tests are then needed to diagnose the condition that's causing the enlarged heart''',
  "A pulmonary consolidation is a region of normally compressible lung tissue that has filled with liquid instead of air. Consolidation occurs through accumulation of inflammatory cellular exudate in the alveoli and adjoining ducts.",
  "Pleural effusions are abnormal accumulations of fluid within the pleural space. They may result from a variety of pathological processes which overwhelm the pleura's ability to reabsorb fluid.",
  "A hernia is caused when an organ or fatty tissue squeezes through a weak spot in the fascia layer of the abdominal wall. It is most commonly found in the belly or groin area and can have various causes. Symptoms of a hernia may include abdominal pain, tenderness, and swelling.",
  "An abnormal accumulation of substances, such as fluid, blood, or cells, in the lung tissue. Infiltration is often a sign of inflammation or infection within the lungs. It can be caused by various conditions.",
  "Suggestive of presence of growth or lump in the area. A mass seen by x-ray could indicate various conditions or abnormalities including tumours,cysts,abscess,hematoma or enlarged organs.",
  "We are pleased to inform you that we did not detect any signs of illness or abnormatlities",
  '''A nodule is a round area that is more dense than normal lung tissue. It shows up as a white spot on a CT scan. Lung nodules are usually caused by scar tissue, a healed infection  or some irritant in the air. Sometimes, a nodule can be an early lung cancer.''',
  "Pneumonia is an infection that inflames the air sacs in one or both lungs. The air sacs may fill with fluid or pus (purulent material), causing cough with phlegm or pus, fever, chills, and difficulty breathing. A variety of organisms, including bacteria, viruses and fungi, can cause pneumonia.",
  "Occurs when air accumulates between the parietal and visceral pleurae inside the chest, causing pressure on the lung and causing it to collapse. Pneumothorax can result from chest trauma, excess pressure on the lungs, or a lung disease such as COPD, asthma, cystic fibrosis, tuberculosis, or whooping cough."
];

List<List<String>> prevention = [
  [
    "Chest Physiotherapy",
    "Breathing Exercises",
    "Smoking Cessation",
    "Coughing and Deep Breathing"
  ],
  [
    "Nutritious Diet",
    "Regular Exercise",
    "Quit Smoking",
    "Manage Blood Pressure"
  ],
  [
    "Vaccinations",
    "Occupational Safety",
    "Smoking Cessation",
    "Environmental Precautions"
  ],
  [
    "Vaccinations",
    "Avoid Smoking",
    "Respiratory Hygiene",
    "Follow Medications"
  ],
  [
    "Practise Good Posture",
    "Maintain Healthy Weight",
    "Quit Smoking",
    "Strengthen Core Muscles"
  ],
  [
    "Respiratory Hygiene",
    "Avoid Irritants",
    "Consult a Specialist",
    "Manage Symptoms"
  ],
  [
    "Regular check ups",
    "Healthy Lifestyle",
    "Self Examinations",
    "Awareness about symptoms"
  ],
  ["Stay Safe", "Regular Exercise", "Smoking Cessation", "Regular Check ups"],
  [
    "Healthy Lifestyle",
    "Quit Smoking",
    "Respiratory Hygiene",
    "Regular Checkups"
  ],
  ["Vaccinations", "Good Hygiene", "Quit Smoking", "Stay Hydrated"],
  [
    "Prevent Chest Trauma",
    "Diving Safely",
    "Avoid Lung Damage",
    "Address symptoms"
  ]
];

List<XRay> conditions = List.generate(list.length,
    (index) => XRay(list[index], description[index], prevention[index]));

Future<int> sendImageURL(String imageUrl, AuthNotifier authNotifier) async {
  final url = Uri.parse('http://HealTheHealthApp/pythonanywhere.com/x_ray');

  final response = await http.post(
    url,
    body: {'image_url': imageUrl},
  );
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    int result = jsonResponse['result'];
    debugPrint(result.toString());
    authNotifier.setLoading(false);
    return result;
  } else {
    authNotifier.setLoading(false);
    Utils().toastMessage("Something went wrong...\nPlease try again later");
    throw Exception('Failed to send image URL to the API');
  }
}

class XRayScreen extends StatefulWidget {
  const XRayScreen({super.key});

  @override
  State<XRayScreen> createState() => _XRayScreenState();
}

class _XRayScreenState extends State<XRayScreen> {
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Future<String> getImageUrl(File? image) async {
      String id = _auth.currentUser!.uid;
      UploadTask uploadTask;
      String newUrl = '';
      if (image != null) {
        Reference ref = FirebaseStorage.instance.ref('/pics/$id');
        uploadTask = ref.putFile(image.absolute);

        await Future.value(uploadTask).then((value) async {
          newUrl = await ref.getDownloadURL();
        });
      }
      return newUrl;
    }

    return Scaffold(
      appBar: GradientAppBar(
        title: 'X-Ray Predictor',
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (height * 0.08).heightBox,
          const Text(
            'Please upload an Image of X-Ray',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          (height * 0.04).heightBox,
          Container(
              height: height * 0.5,
              width: width * 0.7,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey)),
              child: GestureDetector(
                onTap: () {
                  getImageGallery();
                },
                child: _image != null
                    ? SizedBox(
                        child: ClipRRect(
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
                      )),
              )),
          40.heightBox,
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: _image == null
                  ? RoundButton(
                      title: 'Select Image',
                      onTap: () {
                        getImageGallery();
                      })
                  : Consumer<AuthNotifier>(builder: (context, value, child) {
                      return RoundButton(
                          loading: authNotifier.loading ?? false,
                          title: 'Upload',
                          onTap: () async {
                            if (_image != null) {
                              authNotifier.setLoading(true);
                              String url = await getImageUrl(_image);
                              if (url.isNotEmpty) {
                                int res = await sendImageURL(url, authNotifier);
                                goToResults(res);
                              } else {
                                authNotifier.setLoading(false);
                                Utils().toastMessage(
                                    "Something went wrong...\nPlease try again later");
                              }
                            } else {
                              Utils().toastMessage(
                                  'Please select an x-ray image to predict');
                            }
                          });
                    }))
        ],
      )),
    );
  }

  goToResults(int res) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) =>
                XRayResults(disease: conditions[res % conditions.length]))));
  }
}
