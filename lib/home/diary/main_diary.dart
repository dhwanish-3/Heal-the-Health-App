import 'package:heal_the_health_app/constants/imports.dart';

const String _heroAddTodo = 'add-todo-hero';

class DiaryMain extends StatefulWidget {
  const DiaryMain({super.key});

  @override
  State<DiaryMain> createState() => _DiaryMainState();
}

class _DiaryMainState extends State<DiaryMain> {
  List<Diary> ListDiary = [];
  List<String> ListStringDiary = [];
  Future<Structure> getDiary() => UserShared().getDaiary();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      Structure structure = await getDiary();
      ListDiary = structure.DiaryStructureList ?? [];
      ListStringDiary = structure.DiaryStructureStringList ?? [];
      UserShared userShared = Provider.of<UserShared>(context, listen: false);
      userShared.SetDiaryList(ListDiary, ListStringDiary);

      debugPrint('this is in initstate user${userShared.diaryList}');
      debugPrint('this is in initstate user${userShared.diaryJsonList}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserShared userShared = Provider.of<UserShared>(context, listen: false);
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 8, 123, 255),
                Color.fromARGB(158, 0, 119, 255),
                Color.fromARGB(161, 121, 206, 255),
              ],
              stops: [0, 0, 1],
            ),
          ),
        ),
        SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 56,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Your Diary',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Consumer<UserShared>(
              builder: (context, value, child) {
                return const Expanded(child: DiaryList());
              },
            ),
          ],
        )),
        Align(
          alignment: Alignment.bottomRight,
          // child: AddDiaryButton(list: ListDiary),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: GestureDetector(
              onTap: () async {
                debugPrint('ontap to diarylist${userShared.diaryList}');

                debugPrint(
                    'ontap to json get string diury${userShared.diaryJsonList}');
                await Navigator.of(context)
                    .push(HeroDialogRoute(builder: (context) {
                  return AddDiaryPopCard();
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
                            Color.fromARGB(255, 71, 200, 255),
                            Color.fromARGB(255, 30, 255, 150),
                          ],
                          stops: [0, 0, 1],
                        ),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 56,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
