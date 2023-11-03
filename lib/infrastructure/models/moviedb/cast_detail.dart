// this json response model is for the details of the actor

class CastDetails {
  List<String> alsoKnownAs;
  String biography;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String? profilePath;

  CastDetails({
    required this.alsoKnownAs,
    required this.biography,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.profilePath,
  });

  factory CastDetails.fromJson(Map<String, dynamic> json) => CastDetails(
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"],
        id: json["id"],
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
        "biography": biography,
        "id": id,
        "imdb_id": imdbId,
        "known_for_department": knownForDepartment,
        "name": name,
        "profile_path": profilePath,
      };
}
