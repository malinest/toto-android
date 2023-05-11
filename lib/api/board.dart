class Board {
    final String name;
    final String abbreviation;
    final String collectionName;

    Board({
    required this.name, required this.abbreviation, required this.collectionName});

    factory Board.fromJson(Map<String, dynamic> json) {
        return Board(
            name: json['name'],
            abbreviation: json['abbreviation'],
            collectionName: json['collection_name'],
        );
    }
}