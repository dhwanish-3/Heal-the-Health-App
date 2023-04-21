import 'package:heal_the_health_app/constants/imports.dart';

class SearchSymptoms extends StatefulWidget {
  const SearchSymptoms({super.key});

  @override
  State<SearchSymptoms> createState() => _SearchSymptomsState();
}

class _SearchSymptomsState extends State<SearchSymptoms> {
  final searchFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Search symptoms',
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              controller: searchFilter,
              decoration: const InputDecoration(
                  hintText: 'Search your symptoms',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  suffixIcon: Icon(Icons.search)),
              onChanged: (String value) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: Symptoms.length,
                  itemBuilder: (context, index) {
                    if (searchFilter.text.isEmpty) {
                      return ListTile(
                        title: Text(Symptoms[index].symptom ?? ''),
                        onTap: () {
                          Navigator.pop(
                            context,
                            Symptoms[index],
                          );
                          // print(index);
                        },
                      );
                    } else if (Symptoms[index]
                        .symptom!
                        .toLowerCase()
                        .contains(searchFilter.text.toLowerCase())) {
                      return ListTile(
                        title: Text(Symptoms[index].symptom ?? ''),
                        onTap: () {
                          Navigator.pop(context, Symptoms[index]);
                          // print(index);
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
