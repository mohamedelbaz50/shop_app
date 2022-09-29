class HomeModel {
  bool? status;
  HomeDataMoldel? data;
  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = HomeDataMoldel.fromjson(json["data"]);
  }
}

class HomeDataMoldel {
  List<dynamic> banners = [];
  List<dynamic> products = [];
  HomeDataMoldel.fromjson(Map<String, dynamic> json) {
    json["banners"].forEach((element) {
      banners.add(BannersModel.fromjson(element));
    });
    json["products"].forEach((element) {
      products.add(ProductModel.fromjson(element));
    });
  }
}

class BannersModel {
  int? id;
  String? image;
  BannersModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? favorites;
  bool? inCard;
  ProductModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    favorites = json["in_favorites"];
    inCard = json["in_cart"];
  }
}
