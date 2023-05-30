import 'package:heal_the_health_app/constants/imports.dart';

class MedicalRecords extends StatefulWidget {
  const MedicalRecords({super.key});

  @override
  State<MedicalRecords> createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    String userName = authNotifier.patientDetails!.name ?? '';
    List<String>? details = authNotifier.patientDetails!.detailsofVisit;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: GradientAppBar(
          title: 'Medical History',
          leading: const Text(''),
        ),
        body: Column(
          children: [Expanded(child: _buildList(details))],
        ));
  }

  Widget _buildList(List<String>? details) {
    if (details != null && details.isNotEmpty) {
      debugPrint(details.toString());
      return ListView.builder(
          itemCount: details.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(details[index].substring(12)),
                subtitle: Text(details[index].substring(0, 11)),
              ),
            );
          });
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 180,
                width: 180,
                child: Column(
                  children: const [
                    Image(image: AssetImage('images/no_medical.png')),
                  ],
                )),
            20.heightBox,
            const Text(
              "Medical History is Empty",
              style: TextStyle(fontSize: 24, color: Colors.lightBlueAccent),
            ),
          ],
        ),
      );
    }
  }
}
