import 'dart:convert';

import '../../domain/entities/search_entitie.dart';

class ResultSearchModel extends ResultSearchEntitie {
  ResultSearchModel({
    int? id,
    String? uuid,
    required String image,
    required String name,
    required String nickName,
    required String url,
  }) : super(
          image: image,
          name: name,
          nickName: nickName,
          url: url,
          id: id,
          uuid: uuid,
        );

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'nickname': nickName,
      'url': url,
      'id': id,
      'uuid': uuid,
    };
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      image: map['image'],
      name: map['name'],
      nickName: map['nickname'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());
  static ResultSearchModel fromJson(String source) =>
      fromMap(json.decode(source));
}
