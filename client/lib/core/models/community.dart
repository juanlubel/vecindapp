import 'package:vecinapp/core/models/apartment.dart';

class President {
  int pk;
  String name;

  President({this.pk, this.name});

  factory President.fromJson(Map<String, dynamic> json) {
    print(json);
    var pk = -1;
    var name = '';
    if (json != null) {
      pk = json['pk'];
      name = json['name'];
    }
    return President(
        pk: pk,
        name: name
    );
  }
}

class Community {
  int pk;
  String slug;
  String instalaciones;
  String name;
  List<ApartmentEmbedded> apartments;
  President president;

  Community({
    this.pk,
    this.slug,
    this.instalaciones,
    this.name,
    this.apartments,
    this.president
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    var apartments = json['apartments'] as List;
    List<ApartmentEmbedded> apartmentList = apartments.map((e) => ApartmentEmbedded.fromJson(e)).toList();
    var president = President.fromJson(json['president']);
    return Community(
        pk: json['pk'],
        slug: json['slug'],
        instalaciones: json['instalaciones'],
        name: json['name'],
        apartments: apartmentList,
        president: president
    );
  }
}

class CommunityEmbedded {
  int pk;
  String slug;
  String name;

  CommunityEmbedded({this.pk, this.slug, this.name});

  factory CommunityEmbedded.fromJson(Map<String, dynamic> json) {
    return CommunityEmbedded(
      pk: json['pk'],
      slug: json['slug'],
      name: json['name']
    );
  }
}


