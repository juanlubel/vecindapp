
class User {
  int pk;
  String slug;
  String email;
  String name;
  String token;
  String password;

  User({this.pk, this.slug, this.email,this.name, this.token, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        pk: json['pk'],
        slug: json['slug'],
        email: json['email'],
        name: json['first_name'],
        token: json['token'],
        password: json['password']
    );
  }

  User.map(dynamic obj) {
    this.pk = obj['pk'];
    this.email = obj['email'];
    this.token = obj['token'];
  }

  Map<dynamic, dynamic> toMap() {
    var map = new Map<dynamic, dynamic>();
    map['pk'] = pk;
    map['slug'] = slug;
    map['email'] = email;
    map['name'] = name;
    map['token'] = token;
    map['password'] = password;

    return map;
  }

  Map<String, dynamic> toJson() =>{
    "email": this.email
  };
}

class HomeLogin {
  final int pk;
  final String slug;

  HomeLogin({this.pk, this.slug});

  factory HomeLogin.fromJson(Map<String, dynamic> json) {
    return HomeLogin(
        pk: json['pk'],
        slug: json['slug'],
    );
  }
}

class UserEmbedded {
  final int pk;
  final String name;

  UserEmbedded({this.pk, this.name});

  factory UserEmbedded.fromJson(Map<String, dynamic> json) {
    return UserEmbedded(
      pk: json['pk'],
      name: json['name'],
    );
  }
}


