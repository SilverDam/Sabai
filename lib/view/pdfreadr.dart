// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../model/books.dart';
import '../viewmodel/bookmodels.dart';
import 'logoanimation.dart';

/// Represents Homepage for Navigation
class BookPDF extends StatefulWidget {
  int index;
  BookPDF(this.index, );

  @override
  // ignore: library_private_types_in_public_api
  _BookPDFState createState() => _BookPDFState();
}

class _BookPDFState extends State<BookPDF> {
  bool _isPdfLoading = true;
  bool isMenuOpen = false;
  bool isMenuBeingDismissed = false;

  void showPop(translatedValue, details, define, speak) {
    if (!isMenuOpen && !isMenuBeingDismissed) {
      setState(() {
        isMenuOpen = true;
      });

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
      ).then((value) {
        if (value == null) {
          setState(() {
            isMenuOpen = false;
            isMenuBeingDismissed = true;
          });
        }
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isMenuBeingDismissed = false;
        });
      });
    }
  }

  PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? selected =
        Provider.of<MyFavoriteProvider>(context, listen: false).selectedValue;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            SfPdfViewer.asset(
              book[widget.index].pdf,
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                setState(() {
                  _isPdfLoading = false;
                });
              },
              // pageLayoutMode: PdfPageLayoutMode.single,
              onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
                if (details.selectedText == null) {
                  setState(() {
                    selected = 'No text was selected';
                  });
                } else {
                  setState(() {
                    selected = details.selectedText;
                    Provider.of<MyFavoriteProvider>(context, listen: false)
                        .selectedText = selected!.split(" ");
                  });
                }

                Provider.of<MyFavoriteProvider>(context, listen: false)
                    .translate(details, context);
                Provider.of<MyFavoriteProvider>(context, listen: false)
                    .fetchWordDefinition(selected!);

                //  _showContextMenu(context, details);
              },

              enableTextSelection: true,
              controller: _pdfViewerController,
            ),
            _isPdfLoading
                ? const Center(child: LogoAnimation())
                : const SizedBox(),
          ],
        ));
  }
}

//BOTTOM modal sheet

//Bottom sheet
bottomSheet(
  context,
  selectedValue,
  String definition,
  speak,
  translatedValue,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30))),
    context: context,
    builder: (context) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        color: Colors.grey[200],
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.5),
        child: Column(
          children: [

// Selected Text

            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.1,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'English(US)',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      GestureDetector(
                          onTap: () {
                            speak('en-US', selectedValue);
                          },
                          child: const Icon(
                            Icons.play_circle_filled,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      selectedValue == null
                          ? 'No text selected'
                          : selectedValue!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Thai Translation

            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.1,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thai',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      GestureDetector(
                          onTap: () {
                            speak('th', selectedValue);
                          },
                          child: Icon(
                            Icons.play_circle_filled,
                            color: Theme.of(context).colorScheme.secondary,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      selectedValue == null
                          ? 'No text selected'
                          : translatedValue!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Dictionary

            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.1,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Defintion',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        definition,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.grey),
                      ),
                    )
                  ]),
                ],
              ),
            ),

            // Add to Favorite

            const SizedBox(
              height: 10,
            ),

            // Dictionary

            GestureDetector(
              onTap: () {
                Provider.of<MyFavoriteProvider>(context, listen: false)
                    .addToFavorite(
                        favWord: selectedValue,
                        translatedFav: translatedValue,
                        translatedDefine: definition);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add to Favorites',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
