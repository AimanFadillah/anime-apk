import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceHolderCard extends StatelessWidget{
  const PlaceHolderCard ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 10),
      child: Shimmer.fromColors(
        baseColor: const Color(0xFF87A2FF)!, // Warna dasar
        highlightColor: Colors.white, // Warna highlight
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey[300], // Warna background placeholder
          ),
        ),
      ),
    );
  }
}