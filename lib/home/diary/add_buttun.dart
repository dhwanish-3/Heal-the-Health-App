import 'package:heal_the_health_app/constants/imports.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddDiaryButton extends StatefulWidget {
  List<Diary> list;
  AddDiaryButton({super.key, required this.list});

  @override
  State<AddDiaryButton> createState() => _AddDiaryButtonState();
}

class _AddDiaryButtonState extends State<AddDiaryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return AddDiaryPopCard();
          }));
        },
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin as Rect, end: end as Rect);
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
                      Color.fromARGB(255, 71, 200, 255),
                      Color.fromARGB(255, 30, 255, 150),
                    ],
                    stops: [0, 0, 1],
                  ),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 56,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddDiaryPopCard extends StatelessWidget {
  AddDiaryPopCard({super.key});
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserShared userShared = Provider.of<UserShared>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin as Rect, end: end as Rect);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(159, 85, 193, 255),
                  Color.fromARGB(255, 135, 219, 255),
                  Color.fromARGB(255, 207, 255, 253),
                ],
                stops: [0, 0, 1],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        style: const TextStyle(fontSize: 20),
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'New diary',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.9,
                      ),
                      TextFormField(
                        controller: _bodyController,
                        decoration: const InputDecoration(
                          hintText: 'Write about your day',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                        maxLines: 6,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: TextButton(
                          onPressed: () {
                            Diary newDiary = Diary(_titleController.text,
                                _bodyController.text, DateTime.now());

                            userShared.addtoDiary(newDiary);

                            debugPrint(userShared.diaryList.toString());
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blue)),
                            child: const Center(
                              child: Text(
                                'Add',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
