import 'package:heal_the_health_app/constants/imports.dart';

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class EditSchedule extends StatefulWidget {
  const EditSchedule({super.key});

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  List<String> list = [
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
    "08:30 PM",
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
  ];
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    Future<void> deleteItem(int index) async {
      authNotifier.doctorDetails!.schedule!.removeAt(index);
      authNotifier.doctorDetails!.schedule!.sort((a, b) {
        // Convert time strings to DateTime for comparison
        DateTime timeA = DateFormat('hh:mm a').parse(a);
        DateTime timeB = DateFormat('hh:mm a').parse(b);

        return timeA.compareTo(timeB);
      });
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(authNotifier.doctorDetails!.uid)
          .update({'schedule': authNotifier.doctorDetails!.schedule});
    }

    showPopup(int index) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(25),
              actionsPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              title: const Text('Delete'),
              content: const Text(
                  'Do you want to delete this time from your schedule'),
              actions: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () async {
                      await deleteItem(index);
                      setState(() {
                        Navigator.pop(context);
                        Utils().toastMessage(
                            'Timing has been successfully deleted');
                      });
                    },
                    child: const Text('Yes'))
              ],
            );
          });
    }

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Edit Schedule',
        authNotifier: authNotifier,
      ),
      body: Column(
        children: [
          20.heightBox,
          const Text(
            "Your Timings",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  "Your current timings for appointments to be able to book by patients is currently as below",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                20.heightBox,
                const Text(
                  'Notes:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                5.heightBox,
                Text(
                  "Double tap on a time to delete it",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          10.heightBox,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                ),
                itemCount: authNotifier.doctorDetails!.schedule!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      showPopup(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.amber),
                      alignment: Alignment.center,
                      child: Text(
                        authNotifier.doctorDetails!.schedule![index],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                  List<String> newList = [];
                  for (var time in list) {
                    if (!authNotifier.doctorDetails!.schedule!.contains(time)) {
                      newList.add(time);
                    }
                  }
                  return MultiSelectPopUp(
                    items: newList,
                  );
                }));
              },
              child: Hero(
                tag: _heroAddTodo,
                createRectTween: (begin, end) {
                  return CustomRectTween(
                      begin: begin as Rect, end: end as Rect);
                },
                child: Align(
                  alignment: const Alignment(1.1, 1.05),
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.transparent,
                    elevation: 10,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 77, 250, 204),
                            Color.fromARGB(255, 255, 129, 70),
                            Color.fromARGB(255, 255, 214, 30),
                          ],
                          stops: [0, 0, 1],
                        ),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 56,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MultiSelectPopUp extends StatefulWidget {
  final List<String> items;
  const MultiSelectPopUp({super.key, required this.items});

  @override
  State<MultiSelectPopUp> createState() => _MultiSelectPopUpState();
}

class _MultiSelectPopUpState extends State<MultiSelectPopUp> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    Future<void> updateSchedule() async {
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(authNotifier.doctorDetails!.uid)
          .update({'schedule': authNotifier.doctorDetails!.schedule});
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      title: const Text('Select Timings'),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      content: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 400,
            width: 250,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  String item = widget.items[index];
                  return CheckBoxwithName(string: item);
                }),
          ),
        ],
      )),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.amber),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          onPressed: () async {
            print(authNotifier.doctorDetails!.schedule);

            authNotifier.doctorDetails!.schedule!.sort((a, b) {
              // Convert time strings to DateTime for comparison
              DateTime timeA = DateFormat('hh:mm a').parse(a);
              DateTime timeB = DateFormat('hh:mm a').parse(b);

              return timeA.compareTo(timeB);
            });
            await updateSchedule();
            setState(() {
              Navigator.pop(context);
              Utils().toastMessage('Timing has been successfully updated');
            });
          },
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class CheckBoxwithName extends StatefulWidget {
  final String string;
  const CheckBoxwithName({super.key, required this.string});

  @override
  State<CheckBoxwithName> createState() => _CheckBoxwithNameState();
}

class _CheckBoxwithNameState extends State<CheckBoxwithName> {
  bool _isMarked = false;
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Row(
      children: [
        Checkbox(
            value: _isMarked,
            onChanged: (newValue) {
              setState(() {
                _isMarked = newValue ?? false;
                if (newValue != null) {
                  if (newValue) {
                    authNotifier.doctorDetails!.schedule!.add(widget.string);
                  } else {
                    authNotifier.doctorDetails!.schedule!.remove(widget.string);
                  }
                }
              });
            }),
        10.widthBox,
        Text(widget.string)
      ],
    );
  }
}
