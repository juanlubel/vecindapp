import 'package:flutter/material.dart';

class HomeImage extends StatelessWidget {
  const HomeImage({ Key key, this.photo, this.onTap, this.width = 250 }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}