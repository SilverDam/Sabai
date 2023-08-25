import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sabai/view/pdfreadr.dart';

import '../model/books.dart';



class MyBooks extends StatelessWidget {
  const MyBooks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: CustomScrollView(
          slivers: <Widget>[
          /*  SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
         
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(20),
                  centerTitle: true,
                  title: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
      
                    
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          child: Image.asset(
                            'asset/images/user.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                             
                            const  SizedBox(width: 10,),
                         RichText(
                      text: TextSpan(
                        text: 'Hi,',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Emerson',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary)),
                        ],
                      ),
                    ),
                      ],
                    ),
                   
                    SizedBox(
                      height: 20,
                      child: SvgPicture.asset(
                        'asset/images/notification.svg',
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  ]),
                ),
              ), */
       const SliverToBoxAdapter(
                   child: SizedBox(height: 30,),
            ),
           
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
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
                                  color: Theme.of(context).colorScheme.onSurface),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15),
                            child: SvgPicture.asset('asset/images/search.svg',
                                // ignore: deprecated_member_use
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                        )),
                  ),
                ),
              ),
            ),
      
      
      
           const SliverToBoxAdapter(
                   child: SizedBox(height: 30,),
            ),
      
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1 / 2),
                delegate:
                    SliverChildBuilderDelegate((BuildContext context, int index) {
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 500 * index),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>  BookPDF(index)));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  book[index].bookCover,
                                  fit: BoxFit.cover,
                                ))),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 100,
                            child: Text(
                              book[index].bookTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          book[index].bookAuthor,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface),
                        )
                      ],
                    ),
                  );
                }, childCount: book.length),
              ),
            )
          ],
        ),
      ),
    );
  }
}
