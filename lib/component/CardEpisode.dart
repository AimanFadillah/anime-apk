import 'package:animan/model/Episode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardEpisode extends StatelessWidget{
  final Episode episode;
  final Function onTap;
  const CardEpisode ({required this.episode,required this.onTap,super.key});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        margin:const EdgeInsets.fromLTRB(0,0,0,15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8), // Warna bayangan
                spreadRadius: 2, // Radius penyebaran bayangan
                blurRadius: 7,   // Radius blur bayangan
                offset:const Offset(0, 3), // Geser posisi bayangan (x, y)
              ),
            ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child:SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 230,
                child: Transform.scale(
                  scale: 1.02,
                  child: Image.network(episode.image as String,
                    fit: BoxFit.cover,
                    loadingBuilder: (context,image,progress){
                      if(progress == null){
                        return image;
                      }

                      return Image.asset("images/biru2.png", fit:BoxFit.cover);
                    },
                  ),
                )
              ),
            ),
            Positioned(
              bottom: 0, // Posisi teks di bawah gambar
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6))
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(episode.title as String,style:const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white)),
                    Text(episode.date as String,style:const TextStyle(fontSize: 10,color: Colors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}