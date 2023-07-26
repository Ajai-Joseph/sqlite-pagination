class LocalModelClass {
  String name;
  String email;
  String body;
  int id;
  LocalModelClass({required this.email, required this.name, required this.body,required this.id,});

  static LocalModelClass fromMap(Map<String, Object?> map) {
    final String email = map['email'] as String;
    final String name = map['name'] as String;
    final int id = map['id'] as int;
    final String body=map['body'] as String ;
    return LocalModelClass(email: email, name: name, id: id,body:body );
  }
}
