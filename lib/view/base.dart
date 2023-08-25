import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'booksliver.dart';
import 'favorite.dart';


class BaseScreen extends StatelessWidget {
  const BaseScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          indicatorColor: Theme.of(context).colorScheme.secondary,
          labelColor: Theme.of(context).colorScheme.secondary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
          isScrollable: false,
          labelPadding: EdgeInsets.zero,
          tabs: [
            Tab(
              icon: SvgPicture.asset(
                'asset/images/home.svg',
              ),
              text: "Home",
            ),
            Tab(
              icon: SvgPicture.asset(
                'asset/images/favorite.svg',
              ),
              text: "Favorites",
            ),
          ],
        ),
        body:  const TabBarView(
            physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            children: [MyBooks(),  Favorite()]),
      ),
    );
  }
}



//comics widget
class Comics extends StatelessWidget {
  const Comics();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Comics'),
    );
  }
}

