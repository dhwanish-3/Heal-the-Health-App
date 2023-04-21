import 'package:heal_the_health_app/constants/imports.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

final _auth = FirebaseAuth.instance;
String uid = _auth.currentUser!.uid;

class _DiaryScreenState extends State<DiaryScreen> {
  final _diaryController = TextEditingController();
  final _editController = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('Patients');
  @override
  void dispose() {
    _diaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    String uid = authNotifier.patientDetails!.uid ?? '';
    List<String>? diary = authNotifier.patientDetails!.diary;
    return Scaffold(
      appBar: GradientAppBar(
        title: "Your Diary",
        leading: const Text(''),
      ),
      body: Column(children: [
        20.heightBox,
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            maxLines: 4,
            controller: _diaryController,
            decoration: const InputDecoration(
              labelText: 'Diary',
              hintText: 'Enter what do you want to do',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 0),
          child: RoundButton(
              title: 'Add',
              onTap: () async {
                diary!.add(_diaryController.text);

                setState(() {});
                await uploadtoDiary(uid, diary);
              }),
        ),
        10.heightBox,
        Expanded(child: _buildList(diary))
      ]),
    );
  }

  Widget _buildList(List<String>? diary) {
    if (diary != null) {
      return ListView.builder(
          itemCount: diary.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(diary[index]),
                trailing: PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            ShowMyDialog(diary, index);
                          },
                          leading: const Icon(Icons.edit),
                          title: const Text('Edit'),
                        )),
                    PopupMenuItem(
                        value: 1,
                        onTap: () {
                          // Navigator.pop(context);
                          diary.remove(diary[index]);
                          uploadtoDiary(uid, diary);
                          setState(() {});
                          // ref.doc(uid).remove();
                        },
                        child: const ListTile(
                          leading: Icon(Icons.delete_outline),
                          title: Text('Delete'),
                        ))
                  ],
                ),
              ),
            );
          });
    } else {
      return Container(
        child: const Center(child: Text("Your diary is empty")),
      );
    }
  }

  Future<void> ShowMyDialog(List<String> diary, int index) async {
    _editController.text = diary[index];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              child: TextField(
                controller: _editController,
                decoration: const InputDecoration(
                  hintText: 'Edit',
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    // ref.doc(id).update({
                    //   'diary': _editController.text.toString()
                    // }).
                    diary[index] = _editController.text;
                    setState(() {});
                    uploadtoDiary(uid, diary);
                    Navigator.pop(context);
                    // then((value) {
                    //   Utils().toastMessage('Diary Updated');
                    // }).onError((error, stackTrace) {
                    //   Utils().toastMessage(error.toString());
                    // });
                  },
                  child: const Text("Update"))
            ],
          );
        });
  }

  uploadtoDiary(String id, List<String> diary) async {
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(id)
        .update({'diary': diary});
  }
}
