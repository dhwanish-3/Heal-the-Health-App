import 'package:heal_the_health_app/constants/imports.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  const GradientAppBar(
      {super.key, this.title = '', this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
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
                colors: [Colors.blue, Color.fromARGB(255, 110, 250, 115)])),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 56);
}
