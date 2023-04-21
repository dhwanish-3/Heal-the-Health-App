import 'package:heal_the_health_app/constants/imports.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url1 =
    Uri.parse('https://www.starhealth.in/health-insurance-plans/');
final Uri _url2 =
    Uri.parse('https://www.nivabupa.com/health-insurance-plans.html');
final Uri _url3 = Uri.parse(
    'https://www.bajajallianz.com/health-insurance-plans/family-health-insurance-india.html');
final Uri _url4 = Uri.parse('https://www.tataaig.com/health-insurance');
final Uri _url5 =
    Uri.parse('https://www.adityabirlacapital.com/healthinsurance/homepage');

class Insurance extends StatefulWidget {
  const Insurance({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<Insurance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Suggested Health Insurances',
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 255, 235, 173)),
                // ignore: prefer_const_constructors
                child: ListTile(
                  leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 70,
                        minHeight: 70,
                        maxWidth: 100,
                        maxHeight: 100,
                      ),
                      child: Image.asset('images/Star.jpeg')),
                  title: const Text('Star Health Insurance',
                      style: TextStyle(fontSize: 25.0)),
                  // subtitle: Text(
                  //   'Among the leading insurancce providers in India, settling over 90% of claims within 2hrs',
                  //   style: TextStyle(fontSize: 20.0)
                  // ),
                  onTap: () async {
                    if (!await launchUrl(_url1)) {
                      throw Exception('Could not launch $_url1');
                    }
                  },
                ),
              ),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        'Among the leading insurance providers in India, settling over 90% of claims within 2hrs',
                        style: TextStyle(fontSize: 17.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 208, 252, 255)),
                // ignore: prefer_const_constructors
                child: ListTile(
                  leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 70,
                        minHeight: 70,
                        maxWidth: 100,
                        maxHeight: 100,
                      ),
                      child: Image.asset('images/Niva.png')),
                  title: const Center(
                    child: Text('Niva Bupa Health Insurance',
                        style: TextStyle(fontSize: 25.0)),
                  ),
                  // subtitle: Text(
                  //   'Standalone insurance company that caters to all medical needs and provides extended coverage plans',
                  //   style: TextStyle(fontSize: 20.0)
                  // ),
                  onTap: () async {
                    if (!await launchUrl(_url2)) {
                      throw Exception('Could not launch $_url2');
                    }
                  },
                ),
              ),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        'Standalone insurance company that caters to all medical needs and provides extended coverage plans',
                        style: TextStyle(fontSize: 17.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 195, 255, 187)),
                // ignore: prefer_const_constructors
                child: ListTile(
                  leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 70,
                        minHeight: 70,
                        maxWidth: 100,
                        maxHeight: 100,
                      ),
                      child: Image.asset('images/Tata.jpeg')),
                  title: const Text('Tata AIG Health Insurance',
                      style: TextStyle(
                        fontSize: 25.0,
                      )),
                  // subtitle: Text(
                  //   'Co-partnership b/w Tata Group and AIG which has been a leading insurance company in India for 20+ years',
                  //   style: TextStyle(fontSize: 20.0)
                  // ),
                  onTap: () async {
                    if (!await launchUrl(_url4)) {
                      throw Exception('Could not launch $_url4');
                    }
                  },
                ),
              ),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'Co-partnership b/w Tata Group and AIG; Has been a leading insurance company in India for over 2 decades',
                      style: TextStyle(fontSize: 17.0)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 255, 187, 178)),
                // ignore: prefer_const_constructors
                child: ListTile(
                  leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 70,
                        minHeight: 70,
                        maxWidth: 100,
                        maxHeight: 100,
                      ),
                      child: Image.asset('images/Aditya.jpeg')),
                  title: const Center(
                    child: Text('Aditya Birla Health Insurance',
                        style: TextStyle(fontSize: 25.0)),
                  ),
                  // subtitle: Text(
                  //   'Standalone insurance company that caters to all medical needs and provides extended coverage plans',
                  //   style: TextStyle(fontSize: 20.0)
                  // ),
                  onTap: () async {
                    if (!await launchUrl(_url5)) {
                      throw Exception('Could not launch $_url5');
                    }
                  },
                ),
              ),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        'A joint venture b/w Aditya Birla Group and MMI Holdings; Bancassurance with Federal Bank',
                        style: TextStyle(fontSize: 17.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.amber[200]),
                // ignore: prefer_const_constructors
                child: ListTile(
                  leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 70,
                        minHeight: 70,
                        maxWidth: 100,
                        maxHeight: 100,
                      ),
                      child: Image.asset('images/Bajaj.jpeg')),
                  title: const Text('Bajaj Allianz Health Insurance',
                      style: TextStyle(fontSize: 25.0)),
                  // subtitle: Text(
                  //   'Co-partnership b/w Bajaj Finserv and Allianz SE which has completed 20 years in the insruance industry',
                  //   style: TextStyle(fontSize: 20.0)
                  // ),
                  onTap: () async {
                    if (!await launchUrl(_url3)) {
                      throw Exception('Could not launch $_url3');
                    }
                  },
                ),
              ),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'Co-partnership b/w Bajaj Finserv and Allianz SE which has completed 20 years in the insurance industry',
                      style: TextStyle(fontSize: 17.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
