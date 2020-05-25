import 'package:vecinapp/core/models/community.dart';
import 'package:vecinapp/core/models/users.dart';


class ApartmentEmbedded {
  int pk;
  String slug;
  int owner;

  ApartmentEmbedded({
    this.pk,
    this.slug,
    this.owner
  });

  factory ApartmentEmbedded.fromJson(Map<String, dynamic> json) {
    return ApartmentEmbedded(
        pk: json['pk'],
        slug: json['slug'],
        owner: json['owner']
    );
  }
}

class Apartment {
  int pk;
  UserEmbedded owner;
  List<UserEmbedded> renters;
  CommunityEmbedded community;
  int piso;
  String puerta;


  Apartment({this.pk, this.owner, this.renters, this.community, this.piso, this.puerta});

  factory Apartment.fromJson(Map<String, dynamic> json) {
    var renters = json['renter'] as List;
    print(renters);
    List<UserEmbedded> rentersList = renters.map((e) => UserEmbedded.fromJson(e)).toList();
    return Apartment(
      pk: json['pk'],
      owner: UserEmbedded.fromJson(json['owner']),
      renters: rentersList,
      piso: json['piso'],
      puerta: json['puerta'],
      community: CommunityEmbedded.fromJson(json['community'])
    );
  }

  Map<String, dynamic> toUpdateJson() =>
    {
      'pk' : pk,
      'piso' : piso,
      'puerta' : puerta
    };

  Map<String, dynamic> toCreateJson() =>
    {
      'piso' : piso,
      'puerta' : puerta
    };
}