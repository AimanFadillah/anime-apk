import 'dart:convert';
import 'package:animan/model/Anime.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AnimeController extends GetxController{
  RxList<Anime> listAnime = RxList([]);
  RxBool is_loading = RxBool(false);

  @override
  void onInit () {
    getAnimes();
    super.onInit();
  }

  getAnimes () async {
    try{
      is_loading.value = true;
      listAnime.value = [];
      final response = await http.get(Uri.parse("https://samehadaku-api-man.vercel.app/anime"));
      for(Map<String,dynamic> anime in jsonDecode(response.body)){
        listAnime.add(Anime.fromJson(anime));
      }
      is_loading.value = false;
    }catch(e){
      print(e);
    }
  }

}