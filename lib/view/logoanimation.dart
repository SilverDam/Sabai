import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
class LogoAnimation extends StatelessWidget {
  const LogoAnimation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RippleAnimation(
           
            color: Theme.of(context).colorScheme.onPrimary,
            delay: const Duration(milliseconds: 400),
            repeat: true,
            minRadius: 75,
            ripplesCount: 6,
            duration: const Duration(milliseconds: 6 * 300),
             child: Center(
              child: Container(
                    height:  100,
                    width: 100,
                 decoration: BoxDecoration(
                         
                         color:  Theme.of(context).colorScheme.onPrimary,
                         shape: BoxShape.circle

                 ),
                
                child: Center(child: Image.asset('asset/images/logowhite.png', height: 40,))),
            ),
          ),
    );

  }
}