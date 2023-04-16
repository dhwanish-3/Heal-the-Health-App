import 'package:heal_the_health_app/constants/imports.dart';

class ResultofSymptoms extends StatefulWidget {
  final Disease? disease;
  const ResultofSymptoms({super.key, required this.disease});

  @override
  State<ResultofSymptoms> createState() => _ResultofSymptomsState();
}

class _ResultofSymptomsState extends State<ResultofSymptoms> {
  late Color primaryColor = const Color(0xFF4B39EF);
  late Color secondaryColor = const Color(0xFF39D2C0);
  late Color tertiaryColor = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFFF5963);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color primaryText = const Color(0xFF101213);
  late Color secondaryText = const Color(0xFF57636C);

  late Color primaryBtnText = const Color(0xFFFFFFFF);
  late Color lineColor = const Color(0xFFE0E3E7);

  // List<String> precautions = [
  //   'Avoid spicy fatty food',
  //   'Consume probiotic food',
  //   'Eliminate milk',
  //   'Exercise'
  // ];

  Widget _buildListofPrecautions(String prec) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
      child: Text(
        prec,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontFamily: 'Poppins',
            color: secondaryBackground,
            // lineHeight: 1,
            fontSize: 18),
      ),
    );
  }

  ImageProvider showProfileImage(DoctorUser doctor) {
    if (doctor.imageUrl != '') {
      return NetworkImage(doctor.imageUrl.toString());
    } else {
      return const AssetImage('images/default.png');
    }
  }

  List<Widget> _buildList(List<String> prec) {
    List<Widget> widgets = [];
    for (String precaution in prec) {
      widgets.add(_buildListofPrecautions(precaution));
    }
    return widgets;
  }

  double findSize(String str) {
    if (str.length < 10) {
      return 24;
    } else {
      return 40 - (str.length - 0);
    }
  }

  List<DoctorUser> doctors = [];
  buildDoctors(Disease disease) async {
    for (String doctorid in disease.doctors ?? []) {
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctorid)
          .get()
          .then((value) => doctors
              .add(DoctorUser.fromMap(value.data() as Map<String, dynamic>)));
    }
    return doctors;
  }

  List<Widget> buildDoctorsList() {
    List<Widget> listdoctors = [];
    for (DoctorUser doctor in doctors) {
      listdoctors.add(Container(
        height: 70,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 243, 207),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ListTile(
          leading: CircleAvatar(
              child: Image(
            image: showProfileImage(doctor),
            fit: BoxFit.cover,
          )),
          title: Text(doctor.name),
          subtitle: Text(doctor.hospitalName),
        ),
      ));
    }
    return listdoctors;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      await buildDoctors(widget.disease ?? Disease());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
          headerSliverBuilder: (context, inboxisScrolled) {
            return [
              SliverAppBar(
                // elevation: 0,
                backgroundColor: const Color(0xFF484848),
                // scrolledUnderElevation: ,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ];
          },
          body: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.26,
                      decoration: const BoxDecoration(
                        color: Color(0xFF484848),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 40.heightBox,
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: Text(
                              'Your symptoms are consistent\n with that of the disease',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: secondaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          20.heightBox,
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 0),
                              child: Text(
                                widget.disease!.disease ?? '',
                                // 'Hyperthyroidism',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: lineColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: findSize(
                                        widget.disease!.disease ?? '')),
                              ),
                            ),
                          ),
                          8.heightBox,
                          Expanded(
                            child: Container(
                              height: 31.5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            color: secondaryBackground,
                          ),
                          child: Column(
                            children: [
                              // Column(
                              // crossAxisCount: 2,
                              // children: [
                              VxSwiper.builder(
                                itemCount: 2,
                                itemBuilder: buildSliding,
                                height: 250,
                              ),
                              // Swiper(
                              // pagination: const SwiperPagination(),
                              // control: const SwiperControl(),
                              // itemHeight: 100,
                              // itemWidth: 300,
                              //   itemCount: 2,
                              //   itemBuilder: buildSliding,
                              // ),
                              //   ],
                              // ),
                              10.heightBox,
                              const Text(
                                'Handipicked Specialists for you',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.deepOrange),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: 400,
                                  child: ListView(
                                    // crossAxisSpacing: 20,
                                    // childAspectRatio: 0.5,
                                    // crossAxisCount: 2,
                                    children: buildDoctorsList(),
                                  ),
                                ),
                              ),
                              10.heightBox,
                              InkWell(
                                onTap: () => gotoModelsList(),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF52A29A),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                            color: const Color(0xFFBAF8FC),
                                            width: 5,
                                          ),
                                        ),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(10, 10, 10, 10),
                                              child: Image.asset(
                                                'images/fingertips.png',
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Column(
                                              // mainAxisSize: MainAxisSize.max,
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.stretch,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(5, 0, 5, 0),
                                                  child: Text(
                                                    'UNDERTAKE SOPHISTICATED\nDISEASE CONFIRMATION TEST',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: lineColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                // 10.heightBox,
                                                const Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 5, 0),
                                                  child: Text(
                                                    'Diagnosis at your fingertips',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              10.heightBox,
                              Expanded(
                                child: Text(
                                  'Please note that the information from this tool is only for educational purposes and isn’t a qualified medical opinion. This information shouldn’t be considered a doctor or other healthcare provider’s advice or opinion about your actual health. You should get help from a healthcare provider for your symptoms. If you’re having a health emergency, you should call the local emergency number right away for help.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: primaryText,
                                    fontSize: 12,
                                    // lineHeight: 1,
                                  ),
                                ),
                              ),
                              10.heightBox
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ])),
    );
  }

  gotoModelsList() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ListModels()));
  }

  Widget buildSliding(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            Container(
              width: 300,
              constraints: const BoxConstraints(maxHeight: 240, minHeight: 150),
              // width:
              //     MediaQuery.of(context).size.width * 0.9,
              // height:
              //     MediaQuery.of(context).size.height * 0.19,
              decoration: BoxDecoration(
                color: const Color(0xB13960FE),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x33000000),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0x9AFFE6E6),
                  width: 5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  10.heightBox,
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      'DESCRIPTION',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFFFFF500),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  5.heightBox,
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Text(
                      widget.disease!.discription ?? '',
                      // 'Intracerebral hemorrhage (ICH) is when blood suddenly bursts into brain tissue, causing damage to your brain. Symptoms usually appear suddenly during ICH. They include headache, weakness, confusion, and paralysis, particularly on one side of your body.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: primaryBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        // lineHeight: 1,
                      ),
                    ),
                  ),
                  // 15.heightBox
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            Material(
              color: Colors.transparent,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: 300,
                constraints:
                    const BoxConstraints(maxHeight: 240, minHeight: 150),
                // width:
                //     MediaQuery.of(context).size.width * 0.9,
                // height: MediaQuery.of(context).size.height *
                //     0.23,
                decoration: BoxDecoration(
                  color: const Color(0xB3FF00E0),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xB3FFC4FA),
                    width: 5,
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                          child: Text(
                            'PRECAUTIONS',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF00ECFF),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        10.heightBox,
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),

                          child: Column(
                              children: _buildList(
                                  widget.disease!.precautions ?? [])),
                          //   ],
                          // ),
                        ),
                      ],
                    ),
                    // 15.heightBox
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
