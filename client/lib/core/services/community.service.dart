import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:vecinapp/core/models/apartment.dart';
import 'package:vecinapp/core/models/community.dart';
import 'package:vecinapp/core/services/service.dart';

class CommunityService {
  ApiService _netUtil = new ApiService();
  static final BASE_URL = "https://vecindapp-server.herokuapp.com";

  Future<List<CommunityEmbedded>> getCommunities() async {
    var tokenBox = Hive.box('user');
    var token = tokenBox.get('token');
    return _netUtil.get(
        BASE_URL + "/api/comunidades/",
        token
    ).then((dynamic res) {
      var list = res.map<CommunityEmbedded>((json) => CommunityEmbedded.fromJson(json)).toList();
      return list;
    });
  }

  Future<List<Community>> getCommunitiesByUser() async{
    var tokenBox = Hive.box('user');
    var token = tokenBox.get('token');
    return _netUtil.get(
        BASE_URL + "/api/comunidadesByUser/",
        token
    ).then((dynamic res) {
      var list = res.map<Community>((json) => Community.fromJson(json)).toList();
      return list;
    });
  }

  Future<List<Apartment>> getApartmentsByUser() async{
    var tokenBox = Hive.box('user');
    var token = tokenBox.get('token');
    return _netUtil.get(
        BASE_URL + "/api/viviendasByUser/",
        token
    ).then((dynamic res) {
      debugPrint('getApartmentsByUser');
      print(res);
      var list = res.map<Apartment>((json) => Apartment.fromJson(json)).toList();
      debugPrint('list');
      print(list);
      return list;
    });
  }

  Future<Apartment> getApartmentByPk(pk) async {
    var tokenBox = Hive.box('user');
    var token = tokenBox.get('token');
    return _netUtil.get(
        BASE_URL + "/api/vivienda/" + pk.toString(),
        token
    ).then((dynamic res) {
      debugPrint('getApartmentByPk');
      print(res);
//      var list = res.map<Apartment>((json) => Apartment.fromJson(json)).toList();
//      debugPrint('list');
//      print(list);
      return Apartment.fromJson(res);
    });
  }

  Future<Apartment> updateApartment(Apartment apartment) async {
    var tokenBox = Hive.box('user');
    var token = tokenBox.get('token');
    print(apartment.pk.toString());
    var vivienda =  {
      "vivienda" : apartment.toUpdateJson()
    };
    return _netUtil.put(
        BASE_URL + "/api/vivienda/" + apartment.pk.toString(),
        token,
        body: vivienda
    ).then((dynamic res) {
      debugPrint('getApartmentByPk');
      print(res);
//      var list = res.map<Apartment>((json) => Apartment.fromJson(json)).toList();
//      debugPrint('list');
//      print(list);
      return Apartment.fromJson(res);
    });
  }

  Future<Apartment> createApartment(Apartment apartment, int communityPk) async {
    var tokenBox = Hive.box('user');
    var token = tokenBox.get('token');
    print(apartment.pk.toString());
    var vivienda =  {
      "vivienda" : apartment.toCreateJson(),
      "comunidad" : communityPk
    };
    return _netUtil.postCreate(
        BASE_URL + "/api/vivienda/",
        token,
        body: vivienda
    ).then((dynamic res) {
      debugPrint('getApartmentByPk');
      print(res);
//      var list = res.map<Apartment>((json) => Apartment.fromJson(json)).toList();
//      debugPrint('list');
//      print(list);
      return Apartment.fromJson(res);
    });
  }
}