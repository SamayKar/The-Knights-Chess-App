import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import 'create_room_screen.dart';
import 'join_room_screen.dart';

class MainMenuScreen extends StatefulWidget {
  static String routeName = '/main-menu';

  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => MainMenuScreenState();
}

class MainMenuScreenState extends State<MainMenuScreen> {
  final TextEditingController _nameController = TextEditingController();

  void createRoom(BuildContext context, String text) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context, String text) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () {
                createRoom(context, _nameController.text);
              },
              text: 'Create Room',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () {
                joinRoom(context, _nameController.text);
              },
              text: 'Join Room',
            ),
          ],
        ),
      ),
    );
  }
}
