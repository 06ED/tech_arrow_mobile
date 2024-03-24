import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RouteCard extends StatelessWidget {
  final String title;
  final String description;
  final double rating;
  final int time;

  RouteCard({
    super.key,
    required this.title,
    required this.description,
    required this.rating,
    required this.time,
  });

  final _style = GoogleFonts.caveat(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: Color.fromARGB(255, 0, 112, 201),
        )
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: _style,
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Text(description),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(
                      "оценка: $rating",
                      style: _style,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.access_time_filled),
                    Text(
                      "$time минут",
                      style: _style,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
