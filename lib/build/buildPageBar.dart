import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Padding buildPageBar(String pagename) {
  return Padding(
    padding: EdgeInsets.only(top: 74, left: 55, right: 41),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.bars,),
        ),
        Text(pagename),
        IconButton(onPressed: () { },
          icon: FaIcon(FontAwesomeIcons.cartShopping,),
        ),
      ],
    ),
  );
}