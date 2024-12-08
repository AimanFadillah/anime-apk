class LinkIframe {
  String? iframe;

  LinkIframe({this.iframe});

  LinkIframe.fromJson(Map<String, dynamic> json) {
    iframe = json['iframe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iframe'] = this.iframe;
    return data;
  }
}
