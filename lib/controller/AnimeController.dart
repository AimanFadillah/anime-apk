import 'dart:convert';
import 'package:animan/model/Anime.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AnimeController extends GetxController{
  RxList<Anime> listAnime = RxList([]);
  RxBool loadingStop = RxBool(false);
  RxInt page = RxInt(1);

  @override
  void onInit () {
    getAnimes();
    super.onInit();
  }

  getAnimes () async {
    try{
      listAnime.value = [];
      final response = await http.get(Uri.parse("https://samehadaku-api-man.vercel.app/anime?page=$page"));
      for(Map<String,dynamic> anime in jsonDecode(response.body)){
        listAnime.add(Anime.fromJson(anime));
      }
      page.value = page.value + 1;
    }catch(e){
      print(e);
    }
  }

  getAnimesMore () async {
    print(page.value);
    try{
      final response = await http.get(Uri.parse("https://samehadaku-api-man.vercel.app/anime?page=$page"));
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      if(jsonResponse.length == 0){
        loadingStop.value = true;
      }
      for (Map<String, dynamic> anime in jsonResponse) {
        listAnime.add(Anime.fromJson(anime));
      }
      page.value = page.value + 1;
    }catch(e){
      print(e);
    }
  }


}