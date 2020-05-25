import 'dart:async';
import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';
import 'package:vecinapp/core/models/users.dart';
import 'package:vecinapp/core/services/service.dart';


class LoginUser {
  ApiService _netUtil = new ApiService();
  static final BASE_URL = "https://vecindapp-server.herokuapp.com";

  Future<User> login(email, password) async{
    debugPrint(email + password);
    var body = {
        "email" : email,
        "password" : password
    };
    await new Future.delayed(const Duration(milliseconds: 1500));
    return _netUtil.post(BASE_URL + "/api/auth/login", body: body).then((dynamic res) {
      if(res["non_field_errors"] != null) throw new Exception(res["non_field_errors"]);
      var user = new User.map(res);
      var userBox = Hive.box('user');
      userBox.put('token', user.token);
      userBox.put('pk', user.pk);
      return user;
    });
  }

  Future<User> register(email, password) {
    var body = {
      "email" : email,
      "password" : password
    };
    return _netUtil.post(BASE_URL + "/api/auth/register", body: body).then((dynamic res) {
      if(res["non_field_errors"] != null) throw new Exception(res["non_field_errors"]);
      var user = new User.map(res);
      var userBox = Hive.box('user');
      userBox.put('token', user.token);
      userBox.put('pk', user.pk);
      return user;
    });
  }
}

class HomeService {
  ApiService _netUtil = new ApiService();
  static final BASE_URL = "https://vecindapp-server.herokuapp.com";
  static final LOGIN_URL = BASE_URL + "/api/auth/";
//  static final _API_KEY = "somerandomkey";


  Future<User> login(email) async {
    await new Future.delayed(const Duration(seconds: 1));
    User user = new User(email: email);
    return _netUtil.post(LOGIN_URL, body: user.toJson())
        .then((dynamic res) {
      if(res["detail"] == 'Not Found') throw new Exception(res["detail"]);
      return new User.map(res);
    })
    ;
  }
}