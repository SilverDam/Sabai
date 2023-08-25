// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class Delegate extends SliverPersistentHeaderDelegate {
 

  Delegate();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
                height: MediaQuery.of(context).size.height * 0.055,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: Center(
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
                                color: Theme.of(context).colorScheme.onSurface)),
                        labelText: 'Search',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset('asset/images/search.svg',
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      )),
                ),
              );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}