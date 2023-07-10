import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/room_data_provider.dart';
import '../resources/socket_methods.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({Key? key}) : super(key: key);
  @override
  ChessBoardState createState() => ChessBoardState();
}

class ChessBoardState extends State<ChessBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(
        index, roomDataProvider.roomData['_id'], roomDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    AssetImage FindImage(int i, int j, RoomDataProvider roomDataProvider) {
      String piece = roomDataProvider.ChessPieceIndexes[i][j];
      return AssetImage('images/$piece.png');
    }

    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    final size = MediaQuery.of(context).size;

    return AbsorbPointer(
      absorbing: roomDataProvider.roomData['turn']['socketID'] !=
          _socketMethods.socketClient.id,
      child: GridView.builder(
        itemCount: 64,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => tapped(index, roomDataProvider),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: roomDataProvider.colorindexes[index ~/ 8][index % 8],
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          FindImage(index ~/ 8, index % 8, roomDataProvider)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
