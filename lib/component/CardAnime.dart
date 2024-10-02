import 'package:animan/component/PlaceHolderCard.dart';
import 'package:flutter/material.dart';

class CardAnime extends StatelessWidget {
  final String nama;
  final String image;
  const CardAnime({required this.nama,required this.image,super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        children: [
          Image.network(
            image,
            fit: BoxFit.cover, // Isi sesuai kontainer
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Image.asset("images/biru.png");
            },
            // height: MediaQuery.of(context).size.height * 0.288,
          ),
          Positioned(
            bottom: 0, // Posisi teks di bawah gambar
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
              ),
              child: Text(
                truncateText(nama,cutoff: 19),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

String truncateText(String text, {int cutoff = 20}) {
  if (text.length <= cutoff) {
    return text;
  } else {
    return '${text.substring(0, cutoff)}...';
  }
}