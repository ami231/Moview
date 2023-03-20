import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomAppBar bottomNavBar(context,bool isHomePage) {
  return BottomAppBar(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          child: IconButton(
            onPressed:() {Navigator.pop(context);},
            icon: Icon(
              Icons.home,
              color: isHomePage ? Colors.purpleAccent : Colors.white,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          height: 25.0,
          width: 0.5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/FavoritesPage',);
              },
              icon: Icon(CupertinoIcons.heart_fill, color: isHomePage ? Colors.white : Colors.purpleAccent,)),
        )
      ],
    ),
  );
}