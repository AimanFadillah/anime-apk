import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceHolderEpisode extends StatelessWidget {
  const PlaceHolderEpisode ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      margin:const EdgeInsets.fromLTRB(0,0,0,15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
      ),
      child: Shimmer.fromColors(
        baseColor:const Color(0xFF87A2FF), // Warna dasar
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