import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sabai/view/pdfreadr.dart';

import '../viewmodel/bookmodels.dart';

//favorite widget
class Favorite extends StatefulWidget {
  const Favorite();

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    List favorite = Provider.of<MyFavoriteProvider>(context, listen: false).favList;

    final height = MediaQuery.of(context).size.height;
   
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(
                top: 40, left: 30, right: 30, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<MyFavoriteProvider>(context, listen: false)
                        .updatedList('add me up');
                  },
                  child: Text(
                    'My Favorite',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: height * 0.055,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    // Email input
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).colorScheme.onSurface,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(decoration: TextDecoration.none),
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).colorScheme.onSurface,
                          contentPadding:
                              const EdgeInsets.only(left: 18.0, right: 18),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          labelText: 'Search',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15),
                            child: SvgPicture.asset('asset/images/search.svg',
                                // ignore: deprecated_member_use
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: favorite.length,
                        itemBuilder: ((context, index) {
                          return TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                             curve: Curves.easeInOut,
                           duration:  Duration(milliseconds:  500 * index),
                           builder: (context, double value,  child) {
                             return Opacity(
                              
                              opacity: value,
                             child:  child,
                             
                             
                             );
                           },
                            child: GestureDetector(
                                onTap: () {
                          
                                        bottomSheet(context, favorite[index].favoriteWord, favorite[index].favoriteDefinition, Provider.of<MyFavoriteProvider>(context, listen: false).speak, favorite[index].favoriteTranslated);
                          
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: slidable(
                                      context,
                                      favorite[index].favoriteWord,
                                      favorite[index].favoriteTranslated,
                                      favorite[index].favoriteDefinition),
                                )),
                          );
                        })))
              ],
            )));
  }

  //Slidable Widget

  // ignore: non_constant_identifier_names
  Widget slidable(context, String favWord, String translation, String Define) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),
      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        dragDismissible: true,
        dismissible: DismissiblePane(onDismissed: () {}),
        motion: const ScrollMotion(),
        children: const [
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.1,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 12,
                    spreadRadius: 3)
              ]),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'English(US)',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      favWord,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thai',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.blueAccent),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      translation,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

    );
  }
}
