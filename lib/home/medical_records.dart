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
        appBar: const GradientAppBar(title: 'Medical History'),
        body: Column(
          children: [Expanded(child: _buildList(details))],
        ));
  }

  Widget _buildList(List<String>? details) {
    if (details != null) {
      return ListView.builder(
          itemCount: details.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(details[index].substring(11)),
                subtitle: Text(details[index].substring(0, 11)),
              ),
            );
          });
    } else {
      return Container(
        child: const Text("No details"),
      );
    }
  }
}