import 'dart:convert';

import 'package:animan/model/Episode.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EpisodeController extends GetxController{
  RxList<Episode> listEpisode = RxList([]);
  RxBool loadingStop = RxBool(false);
  RxInt page = RxInt(1);
  
  @override
  void onInit () {
    getEpisode();
    super.onInit();
  }
  
  getEpisode () async {
    try{
      listEpisode.value = [];
      final response = await http.get(Uri.parse("https://samehadaku-api-man.vercel.app/?page=$page"));
      for(Map<String,dynamic> episode in jsonDecode(response.body)){
          listEpisode.add(Episode.fromJson(episode));
      }
      page.value = page.value + 1;
    }catch(e){
      print(e);
    }
  }

  getEpisodeMore () async {
    try{
      final response = await http.get(Uri.parse("https://samehadaku-api-man.vercel.app/?page=$page"));
      for(Map<String,dynamic> episode in jsonDecode(response.body)){
        listEpisode.add(Episode.fromJson(episode));
      }
      page.value = page.value + 1;
    }catch(e){
      print(e);
    }
  }
  
}