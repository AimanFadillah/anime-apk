class Anime {
  String? title;
  String? image;
  String? rating;
  String? status;
  String? type;
  String? synopsis;
  List<Genre>? genre;
  String? slug;

  Anime(
      {this.title,
        this.image,
        this.rating,
        this.status,
        this.type,
        this.synopsis,
        this.genre,
        this.slug});

  Anime.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    rating = json['rating'];
    status = json['status'];
    type = json['type'];
    synopsis = json['synopsis'];
    if (json['genre'] != null) {
      genre = <Genre>[];
      json['genre'].forEach((v) {
        genre!.add(new Genre.fromJson(v));
      });
    }
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['type'] = this.type;
    data['synopsis'] = this.synopsis;
    if (this.genre != null) {
      data['genre'] = this.genre!.map((v) => v.toJson()).toList();
    }
    data['slug'] = this.slug;
    return data;
  }
}

class Genre {
  String? title;
  String? slug;

  Genre({this.title, this.slug});

  Genre.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    return data;
  }
}
