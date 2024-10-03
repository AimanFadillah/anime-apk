import 'package:animan/component/PlaceHolderCard.dart';
import 'package:animan/model/Anime.dart';
import 'package:flutter/material.dart';

class CardAnime extends StatelessWidget {
  final Anime anime;
  const CardAnime({required this.anime,super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.2,
            height: 300,
            child: Image.network(
              anime.image as String,
              fit: BoxFit.cover, // Isi sesuai kontainer
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Image.asset("images/biru.png",fit: BoxFit.cover);
              },
              // height: MediaQuery.of(context).size.height * 0.288,
            ),
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
                truncateText(anime.title as String,cutoff: 19),
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