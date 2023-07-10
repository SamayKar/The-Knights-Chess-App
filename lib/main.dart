import 'package:chess_final_final/provider/room_data_provider.dart';
import 'package:chess_final_final/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:chess_final_final/screens/create_room_screen.dart';
import 'package:chess_final_final/screens/game_screen.dart';
import 'package:chess_final_final/screens/join_room_screen.dart';
import 'package:chess_final_final/screens/main_menu_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'The Knights Chess App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routeName,
      ),
    );
  }
}
