import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
const HeroBanner({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
      height: 280,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/blabla_home.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.only(top: 40),
          child: Text(
            'Your pick of rides at low prices',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 3,
                  color: Colors.black26,
                )
              ]
            ),
          ),
        ),
      )
    );
  }
}