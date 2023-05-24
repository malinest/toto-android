/// Model of a Board
class Board {
  // Name of the Board
  final String name;
  // Abbreviation of the Board (example: Toto --> tt)
  final String abbreviation;
  // Name of the collection of the Board in the database (example: Toto --> Board_Toto)
  final String collectionName;

  Board(
      {required this.name,
      required this.abbreviation,
      required this.collectionName});

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      name: json['name'],
      abbreviation: json['abbreviation'],
      collectionName: json['collection_name'],
    );
  }
}
