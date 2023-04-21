import 'package:heal_the_health_app/constants/imports.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  AuthNotifier? authNotifier;
  final Widget? leading;
  final List<Widget>? actions;
  GradientAppBar(
      {super.key,
      this.title = '',
      this.authNotifier,
      this.leading,
      this.actions});

  @override
  Widget build(BuildContext context) {
    if (authNotifier != null && authNotifier!.isDoctor == true) {
      return AppBar(
        actions: actions,
        backgroundColor: Colors.transparent,
        // elevation: 0,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        leading: leading ??
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded),
              color: Colors.white,
            ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 255, 130, 40),
            Color.fromARGB(255, 255, 238, 87)
          ])),
        ),
      );
    } else {
      return AppBar(
        actions: actions,
        backgroundColor: Colors.transparent,
        // elevation: 0,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        leading: leading ??
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded),
              color: Colors.white,
            ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Color.fromARGB(255, 167, 255, 172)])),
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 56);
}
