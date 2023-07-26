class RemoteModelClass {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  RemoteModelClass({this.postId, this.id, this.name, this.email, this.body});

  RemoteModelClass.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['that'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['that'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }
}
