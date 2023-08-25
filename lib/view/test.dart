 import 'dart:async';
 import 'package:epubx/epubx.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
 import 'dart:typed_data';
 import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_html/flutter_html.dart';

// // Define the URL of the EPUB file
// String url = 'https://example.com/sample.epub';

// // Fetch the EPUB file content

// Future fetchEpub () async {

// http.Response response = await http.get(Uri.parse(url));
//   Uint8List bytes = response.bodyBytes;
// }







class EpubDispaly extends StatefulWidget {
   const EpubDispaly();

  @override
   State<EpubDispaly> createState() => _EpubDispalyState();
 }

 class _EpubDispalyState extends State<EpubDispaly> {

  String fileName = 'asset/novels/Storm of war.epub';
  String content = '';

  Future getEpub () async {
   ByteData epubBook = await rootBundle.load(fileName);
   Uint8List bytes = epubBook.buffer.asUint8List();
   EpubBook book = await EpubReader.readBook(bytes);
   
   setState(() {
    content = book.Chapters![0].HtmlContent!;
   });

   print(content);

 }
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEpub();
  }

  @override
   Widget build(BuildContext context) {

   

  
    return  Scaffold(
           
                body : Container()
               );

   }
 }