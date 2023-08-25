import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../view/pdfreadr.dart';
import './favoritemodels.dart';

class MyFavoriteProvider extends ChangeNotifier {
  List myFavoriteList = [];
  String? define;
  String? selectedValue;
  String? translatedValue;
  List selectedText = [];
  List<Myfavorite> favList = [];
  bool isPopupMenu = false;

  void updatedList(String newFavorite) {
    myFavoriteList.add(newFavorite);
    notifyListeners();
  }

  Future<String> fetchWordDefinition(String word) async {
    final apiUrl = Uri.parse('https://owlbot.info/api/v4/dictionary/$word');
    const apiKey = 'cded899a9a089ba2a7f4fdea851c2adb09505141';
    String? definition;
    final response =
        await http.get(apiUrl, headers: {'Authorization': 'Token $apiKey'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      definition = data['definitions'][0]['definition'];
      print(definition);

      if (definition == null) {
        define = "There is no dictionary definition found for the selected text";
      } else {
        define = definition;
      }

      notifyListeners();
    }

    return 'No definition found.';
  }

  //speak

  Future speak(String languageCode, String text) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(1);
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

//Translate
  void translate(details, context) {
    GoogleTranslator translator = GoogleTranslator();
    translator
        .translate(details.selectedText, from: 'en', to: 'th')
        .then((output) {
      translatedValue = output.text;

      notifyListeners();
  
    }).then((_) {
showMenu(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        position: RelativeRect.fromLTRB(
            details.globalSelectedRegion!.bottomLeft.dx,
            details.globalSelectedRegion!.center.dy - 70,
            details.globalSelectedRegion!.bottomLeft.dx,
            details.globalSelectedRegion!.center.dy - 70),
        items: [
          PopupMenuItem(
              value: translatedValue,
              child: GestureDetector(
                  onTap: () {
                    Provider.of<MyFavoriteProvider>(context, listen: false)
                        .updatedList('add me to your favorite');
                    bottomSheet(context, details.selectedText, define!, speak,
                        translatedValue);
                  },
                  child: SizedBox(
                      child: Text(translatedValue!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold))))),
        ],
      );
        speak('th', translatedValue!);


    });
  }

  void addToFavorite(
      {required String favWord,
      required String translatedFav,
      required String translatedDefine}) {
    List<Myfavorite> myList = [
      Myfavorite(favWord, translatedFav, translatedDefine)
    ];

    favList.addAll(myList);
    notifyListeners();
  }
}
