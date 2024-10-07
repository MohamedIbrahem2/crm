import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
Widget buildShimmer(int crossAxis) {
  return Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.white,
    child: GridView.builder(
      reverse: true,
      shrinkWrap: true,
      itemCount: 6, // Example item count
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(13)
            ),
          ),
        );
      }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,childAspectRatio: .6,),
    ),
  );
}