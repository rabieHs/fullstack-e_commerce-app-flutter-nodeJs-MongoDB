import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_e_commerce_app/constants/global_variables.dart';

class CarouselImages extends StatelessWidget {
  const CarouselImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.carouselImages.map((i) {
          return Builder(
              builder: (BuildContext context) => Image.network(
                    i,
                    fit: BoxFit.cover,
                    height: 200,
                  ));
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
        ));
  }
}
