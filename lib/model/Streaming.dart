import 'package:animan/model/Episode.dart';
import 'package:animan/model/Quality.dart';

class Streaming {
  String? title;
  String? slug;
  String? image;
  String? synopsis;
  List<Genre>? genre;
  List<Episode>? episode;
  Downloads? downloads;
  List<Iframe>? iframe;

  Streaming(
      {this.title,
        this.slug,
        this.image,
        this.synopsis,
        this.genre,
        this.episode,
        this.downloads,
        this.iframe});

  Streaming.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    synopsis = json['synopsis'];
    if (json['genre'] != null) {
      genre = <Genre>[];
      json['genre'].forEach((v) {
        genre!.add(new Genre.fromJson(v));
      });
    }
    if (json['episode'] != null) {
      episode = <Episode>[];
      json['episode'].forEach((v) {
        episode!.add(new Episode.fromJson(v));
      });
    }
    downloads = json['downloads'] != null
        ? new Downloads.fromJson(json['downloads'])
        : null;
    if (json['iframe'] != null) {
      iframe = <Iframe>[];
      json['iframe'].forEach((v) {
        iframe!.add(new Iframe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['synopsis'] = this.synopsis;
    if (this.genre != null) {
      data['genre'] = this.genre!.map((v) => v.toJson()).toList();
    }
    if (this.episode != null) {
      data['episode'] = this.episode!.map((v) => v.toJson()).toList();
    }
    if (this.downloads != null) {
      data['downloads'] = this.downloads!.toJson();
    }
    if (this.iframe != null) {
      data['iframe'] = this.iframe!.map((v) => v.toJson()).toList();
    }
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

class Downloads {
  Mkv? mkv;
  Mkv? mp4;
  Mkv? x265;

  Downloads({this.mkv, this.mp4, this.x265});

  Downloads.fromJson(Map<String, dynamic> json) {
    mkv = json['mkv'] != null ? new Mkv.fromJson(json['mkv']) : null;
    mp4 = json['mp4'] != null ? new Mkv.fromJson(json['mp4']) : null;
    x265 = json['x265'] != null ? new Mkv.fromJson(json['x265']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mkv != null) {
      data['mkv'] = this.mkv!.toJson();
    }
    if (this.mp4 != null) {
      data['mp4'] = this.mp4!.toJson();
    }
    if (this.x265 != null) {
      data['x265'] = this.x265!.toJson();
    }
    return data;
  }
}

class Mkv {
  List<Quality>? d360p;
  List<Quality>? d480p;
  List<Quality>? d720p;
  List<Quality>? d1080p;

  Mkv({this.d360p, this.d480p, this.d720p, this.d1080p});

  Mkv.fromJson(Map<String, dynamic> json) {
    if (json['d360p'] != null) {
      d360p = <Quality>[];
      json['d360p'].forEach((v) {
        d360p!.add(new Quality.fromJson(v));
      });
    }
    if (json['d480p'] != null) {
      d480p = <Quality>[];
      json['d480p'].forEach((v) {
        d480p!.add(new Quality.fromJson(v));
      });
    }
    if (json['d720p'] != null) {
      d720p = <Quality>[];
      json['d720p'].forEach((v) {
        d720p!.add(new Quality.fromJson(v));
      });
    }
    if (json['d1080p'] != null) {
      d1080p = <Quality>[];
      json['d1080p'].forEach((v) {
        d1080p!.add(new Quality.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.d360p != null) {
      data['d360p'] = this.d360p!.map((v) => v.toJson()).toList();
    }
    if (this.d480p != null) {
      data['d480p'] = this.d480p!.map((v) => v.toJson()).toList();
    }
    if (this.d720p != null) {
      data['d720p'] = this.d720p!.map((v) => v.toJson()).toList();
    }
    if (this.d1080p != null) {
      data['d1080p'] = this.d1080p!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class D360p {
  String? title;
  String? link;

  D360p({this.title, this.link});

  D360p.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    return data;
  }
}

class Iframe {
  String? title;
  String? post;
  int? nume;

  Iframe({this.title, this.post, this.nume});

  Iframe.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    post = json['post'];
    nume = json['nume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['post'] = this.post;
    data['nume'] = this.nume;
    return data;
  }
}
