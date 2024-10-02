class Episode {
  String? title;
  String? image;
  String? episode;
  String? posted;
  String? date;
  String? slug;

  Episode(
      {this.title,
        this.image,
        this.episode,
        this.posted,
        this.date,
        this.slug});

  Episode.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    episode = json['episode'];
    posted = json['posted'];
    date = json['date'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['episode'] = this.episode;
    data['posted'] = this.posted;
    data['date'] = this.date;
    data['slug'] = this.slug;
    return data;
  }
}
