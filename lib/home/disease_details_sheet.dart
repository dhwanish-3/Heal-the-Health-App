import 'package:heal_the_health_app/constants/imports.dart';

class DiseaseDetailsSheet extends StatelessWidget {
  final Disease disease;
  const DiseaseDetailsSheet({super.key, required this.disease});
  listofSymptoms(Disease disease) {
    List<Widget> symptoms = [];
    for (Symptom symptom in disease.symptoms ?? []) {
      symptoms.add(Column(
        children: [
          Text(
            symptom.symptom ?? '',
            style: const TextStyle(fontSize: 16),
          ),
          5.heightBox
        ],
      ));
    }
    return symptoms;
  }

  listofPrecs(Disease disease) {
    List<Widget> prec = [];
    for (String pre in disease.precautions ?? []) {
      prec.add(Column(
        children: [
          Text(
            pre,
            style: const TextStyle(fontSize: 16),
          ),
          5.heightBox
        ],
      ));
    }
    return prec;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: 800,
        child: Column(children: [
          Text(
            disease.disease ?? '',
            style: const TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          10.heightBox,
          Text(
            disease.discription ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          20.heightBox,
          Column(
            children: [
              Column(
                children: [
                  const Text(
                    'Symptoms',
                    style: TextStyle(fontSize: 20, color: Colors.amber),
                  ),
                  Column(
                    children: listofSymptoms(disease),
                  ),
                ],
              ),
              10.heightBox,
              Column(
                children: [
                  const Text(
                    'Precautions',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  10.heightBox,
                  Column(
                    children: listofPrecs(disease),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
