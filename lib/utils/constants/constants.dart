import 'package:flutter/material.dart';
import 'package:wetix/model/cart_model.dart';

import '../../model/user_model.dart';

const backgroundColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 1],
    colors: [Colors.grey, Colors.black]);
List<String> sliderImg = [
  "assets/images/rectangle.jpg",
  "assets/images/rectangle.jpg",
  "assets/images/rectangle.jpg",
];
List<String> slider = [
  "https://e0.pxfuel.com/wallpapers/175/583/desktop-wallpaper-retro-nostalgic-black-and-white-beauty-salon-background-hair-salon.jpg",
  "https://thumbs.dreamstime.com/b/interior-empty-modern-hair-beauty-salon-decorated-gray-fuchsia-colors-51874829.jpg",
  "https://e0.pxfuel.com/wallpapers/284/652/desktop-wallpaper-creative-warm-color-wood-grain-hair-salon-beauty-salon-barber-shop-background-3d-fashion-modeling-decorative-mural-150cmx105cm-saloon.jpg",
  "https://media.istockphoto.com/id/1341429602/photo/hair-beauty-salon.jpg?s=170667a&w=0&k=20&c=HNAzmsnM-f2DlOxB6VGlen0njVHUly6GHcwPs1WE4m4=",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtoVOt-Ab3ya2b7wWNfkqcOl7I1LNIx4KyVL2vdtWKEbRgbydCwIk-5Z7GKmrE4-DnfDw&usqp=CAU",
  "https://img.freepik.com/free-vector/cute-rabbit-holding-carrot-cartoon-vector-icon-illustration-animal-nature-icon-isolated-flat_138676-7315.jpg?w=2000",
  "https://img.freepik.com/free-vector/cute-bad-cat-wearing-suit-sunglasses-with-baseball-bat-cartoon-icon-illustration-animal-fashion-icon-concept-isolated-flat-cartoon-style_138676-2170.jpg?w=2000",
  "https://img.freepik.com/free-vector/cute-cool-baby-holding-teddy-bear-doll-cartoon-vector-icon-illustration-people-holiday-isolated_138676-5356.jpg",
];
UserModel? userModel;
String? token;
String? specificUserId;
CartModel? cartModel;

String? cartId;
String? eventId;
