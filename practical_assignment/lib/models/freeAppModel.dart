// To parse this JSON data, do
//
//     final freeAppApi = freeAppApiFromJson(jsonString);

class FreeAppApi {
  FreeAppApi({
    this.artistName,
    required this.id,
    this.name,
    this.artworkUrl100,
    this.genres,
    this.url,
  });

  String? artistName;
  String id;
  String? name;
  String? artworkUrl100;
  List<Genre>? genres;
  String? url;

  static FreeAppApi fromJson(Map<String, dynamic> json) => FreeAppApi(
        artistName: json["artistName"] == null ? null : json["artistName"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        artworkUrl100:
            json["artworkUrl100"] == null ? null : json["artworkUrl100"],
        genres: json["genres"] == null
            ? null
            : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
                .toList(),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "artistName": artistName == null ? null : artistName,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "artworkUrl100": artworkUrl100 == null ? null : artworkUrl100,
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "url": url == null ? null : url,
      };
}

class Genre {
  Genre({
    this.genreId,
    this.name,
    this.url,
  });

  String? genreId;
  String? name;
  String? url;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        genreId: json["genreId"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "genreId": genreId,
        "name": name,
        "url": url,
      };
}
