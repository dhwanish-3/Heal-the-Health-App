import 'package:heal_the_health_app/constants/imports.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:bubble/bubble.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final messageInsert = TextEditingController();
  List<Map> messsages = [];
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/Credentials.json").build();
    DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message":
            aiResponse.getListMessage()![0]!["text"]!["text"]![0].toString()
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    return Scaffold(
      appBar: GradientAppBar(
        authNotifier: authNotifier,
        title: 'HealthBot',
      ),
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
                  reverse: true,
                  itemCount: messsages.length,
                  itemBuilder: (context, index) => chat(
                      messsages[index]["message"].toString(),
                      messsages[index]["data"],
                      authNotifier))),
          // const Divider(
          //   height: 6.0,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: TextField(
                    controller: messageInsert,
                    decoration: const InputDecoration.collapsed(
                        hintText: "Send message to the HealthBot",
                        hintStyle: TextStyle(fontSize: 16.0)),
                  )),
                  10.widthBox,
                  IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 30.0,
                        color: authNotifier.isDoctor!
                            ? Colors.amber
                            : Colors.lightBlueAccent,
                      ),
                      onPressed: () {
                        if (messageInsert.text.isEmpty) {
                          Utils().toastMessage('Please enter your message');
                        } else {
                          setState(() {
                            messsages.insert(
                                0, {"data": 1, "message": messageInsert.text});
                          });
                          response(messageInsert.text);
                          messageInsert.clear();
                        }
                      })
                ],
              ),
            ),
          ),
          5.heightBox,
        ],
      ),
    );
  }

  Widget chat(String message, int data, AuthNotifier authNotifier) {
    Color colorMessage(int data) {
      if (authNotifier.isDoctor != null && authNotifier.isDoctor!) {
        return data == 0 ? Colors.lightBlueAccent : Colors.orangeAccent;
      } else {
        return data == 0 ? Colors.orangeAccent : Colors.lightBlueAccent;
      }
    }

    ImageProvider getProfileImage() {
      if (data == 0) {
        return const AssetImage("images/chatbot.png");
      } else {
        if (authNotifier.doctorDetails != null) {
          if (authNotifier.doctorDetails!.imageUrl == '') {
            return const AssetImage("images/default.png");
          } else {
            return NetworkImage(authNotifier.doctorDetails!.imageUrl);
          }
        } else {
          if (authNotifier.patientDetails!.imageUrl == '') {
            return const AssetImage("images/default.png");
          } else {
            return NetworkImage(authNotifier.patientDetails!.imageUrl ?? '');
          }
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Bubble(
          radius: const Radius.circular(15.0),
          color: colorMessage(data),
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 15, backgroundImage: getProfileImage()),
                5.widthBox,
                Flexible(
                    child: Text(
                  message,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 1,
                      fontSize: 16),
                ))
              ],
            ),
          )),
    );
  }
}
