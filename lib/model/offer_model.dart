class OfferModel {
  OfferModel({
    required this.message,
    required this.data,
    required this.success,
  });
  late final String message;
  late final List<Offer> data;
  late final bool success;

  OfferModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = List.from(json['data']).map((e)=>Offer.fromJson(e)).toList();
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['success'] = success;
    return _data;
  }
}

class Offer {
  Offer({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.couponCode,
    required this.discription,
    required this.services,
    required this.active,
  });
  late final int id;
  late final String name;
  late final String imageUrl;
  late final String startDate;
  late final String endDate;
  late final String couponCode;
  late final String discription;
  late final Services services;
  late final bool active;

  Offer.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    name = json['name']??'';
    imageUrl = json['imageUrl']??'';
    startDate = json['startDate']??'';
    endDate = json['endDate']??'';
    couponCode = json['couponCode']??'';
    discription = json['discription']??'';
    services = Services.fromJson(json['services']);
    active = json['active']??true;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageUrl'] = imageUrl;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['couponCode'] = couponCode;
    _data['discription'] = discription;
    _data['services'] = services.toJson();
    _data['active'] = active;
    return _data;
  }
}

class Services {
  Services({
    required this.id,
    required this.created,
    required this.createdBy,
    required this.updated,
    required this.updatedBy,
    required this.active,
    required this.name,
    required this.description,
    required this.shortDiscribtion,
    required this.photosUrl,
    required this.tackingTimeForService,
    required this.serviceWarranty,
  });
  late final int id;
  late final String created;
  late final String createdBy;
  late final String updated;
  late final String updatedBy;
  late final bool active;
  late final String name;
  late final String description;
  late final String shortDiscribtion;
  late final String photosUrl;
  late final String tackingTimeForService;
  late final String serviceWarranty;

  Services.fromJson(Map<String, dynamic> json){
    id = json['id'];
    created = json['created'];
    createdBy = json['createdBy'];
    updated = json['updated'];
    updatedBy = json['updatedBy'];
    active = json['active'];
    name = json['name'];
    description = json['description'];
    shortDiscribtion = json['short_discribtion'];
    photosUrl = json['photos_url'];
    tackingTimeForService = json['tackingTimeForService'];
    serviceWarranty = json['serviceWarranty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created'] = created;
    _data['createdBy'] = createdBy;
    _data['updated'] = updated;
    _data['updatedBy'] = updatedBy;
    _data['active'] = active;
    _data['name'] = name;
    _data['description'] = description;
    _data['short_discribtion'] = shortDiscribtion;
    _data['photos_url'] = photosUrl;
    _data['tackingTimeForService'] = tackingTimeForService;
    _data['serviceWarranty'] = serviceWarranty;
    return _data;
  }
}