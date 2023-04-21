import 'dart:convert';

import 'package:heal_the_health_app/constants/imports.dart';

class Structure {
  List<Diary>? DiaryStructureList;
  List<String>? DiaryStructureStringList;
  Structure({this.DiaryStructureList, this.DiaryStructureStringList});
}

class UserShared with ChangeNotifier {
  Future<bool> saveUser(String user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(user);
    sp.setString('User', jsonString);
    notifyListeners();
    return true;
  }

  Future<String> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String user = sp.getString('User') ?? 'patient';
    // PatientUser user =
    //     PatientUser.fromMap(jsonDecode(sp.getString('User') as String));
    return user;
  }

  //For offline diary maintainance
  List<Diary>? _diaryList = [];
  List<String>? _diaryListString = [];

  List<Diary>? get diaryList => _diaryList;
  List<String>? get diaryJsonList => _diaryListString;

  void SetDiaryList(List<Diary> list, List<String> stringList) {
    _diaryList = list;
    _diaryListString = stringList;
    notifyListeners();
  }

  void addtoDiary(Diary diary) {
    _diaryList!.add(diary);
    _diaryListString!.add(jsonEncode(diary.toMap()));
    saveDiary();
    notifyListeners();
  }

  void updateDiary(Diary diary, int index) {
    _diaryList![index] = diary;
    _diaryListString![index] = jsonEncode(diary.toMap());
    saveDiary();
    notifyListeners();
  }

  void deleteDiary(Diary diary) {
    _diaryList!.remove(diary);
    _diaryListString!.remove(jsonEncode(diary.toMap()));
    saveDiary();
    notifyListeners();
  }

  Future<bool> saveDiary() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    // inefficient for loop , so changed to o(1)
    // for (Diary dairy in dairyList) {
    //   diaryListString.add(jsonEncode(dairy.toMap()));
    // }
    sp.setStringList('DiaryList', _diaryListString ?? []);
    notifyListeners();
    return true;
  }

  List<String>? getDiarydiary(Map<String, dynamic> data) {
    return data['diary'] is Iterable ? List.from(data['diary']) : null;
  }

  getDiaryFormFirebase(String uid) async {
    List<String> diaryListFire = [];
    await FirebaseFirestore.instance
        .collection('Patients')
        .doc(uid)
        .get()
        .then((value) {
      diaryListFire = getDiarydiary(value.data() as Map<String, dynamic>) ?? [];
    });
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList('DiaryList', diaryListFire);
    debugPrint('this is from firebsde$diaryListFire');
    notifyListeners();
  }

  Future<Structure> getDaiary() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? dairySP = sp.getStringList('DiaryList');
    _diaryListString = dairySP;

    debugPrint('diary Stirng in get Diary$_diaryListString');
    List<Diary> diaryList = [];
    for (String dairy in _diaryListString ?? []) {
      diaryList.add(Diary.fromMap(jsonDecode(dairy)));
    }
    notifyListeners();
    debugPrint('diary string get Diary$_diaryListString');
    Structure structure = Structure(
        DiaryStructureList: diaryList,
        DiaryStructureStringList: _diaryListString);
    return structure;
  }

  void ClearDiaryList() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    // List<String> diaryListString = [];
    // for (Diary dairy in _diaryList ?? []) {
    //   diaryListString.add(jsonEncode(dairy.toMap()));
    // }
    debugPrint('this is logout upload$_diaryListString');
    final auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance
        .collection(
          'Patients',
        )
        .doc(auth.currentUser!.uid)
        .update({
      'diary': _diaryListString,
    });
    _diaryList = [];
    _diaryListString = [];
    notifyListeners();
  }
}
