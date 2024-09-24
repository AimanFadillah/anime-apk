import 'dart:convert';
import 'package:animan/model/Anime.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AnimeController extends GetxController{
  RxList<Anime> listAnime = RxList([]);
  RxBool isLoading = RxBool(false);

  @override
  void onInit () {
    getAnimes();
    super.onInit();
  }


  getAnimes () async {
    try{
      isLoading.value = true;
      listAnime.value = [];
      final response = await http.get(Uri.parse("https://samehadaku-api-man.vercel.app/anime"));
      for(Map<String,dynamic> anime in jsonDecode(response.body)){
        listAnime.add(Anime.fromJson(anime));
      }
      isLoading.value = false;
    }catch(e){
      print(e);
    }
  }

}