class Player {
  final String nickname;
  final String socketID;
  final String playerType;
  Player({
    required this.nickname,
    required this.socketID,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'playerType': playerType,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ?? '',
      socketID: map['socketID'] ?? '',
      playerType: map['playerType'] ?? '',
    );
  }

  Player copyWith({
    String? nickname,
    String? socketID,
    String? playerType,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      playerType: playerType ?? this.playerType,
    );
  }
}
