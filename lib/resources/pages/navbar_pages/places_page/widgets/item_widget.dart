import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../../../../app/models/comment.dart';

class ItemWidget extends StatelessWidget {
  final _scrollController = ScrollController();

  final String title;
  final String description;
  final String? image;

  final List<CommentModel> comments = [
    CommentModel(
      'public/assets/images/image.png',
      'Иван',
      'Обожаю эти леса... Такой классный дуб!',
      5,
    ),
    CommentModel(
      'public/assets/images/image.png',
      'Мария',
      '4 звезды потому что 3 дня до дедлайна, а так все классно',
      4,
    ),
    CommentModel(
      'public/assets/images/image.png',
      'Сергей',
      'В целом норма, все нравится, просто пускай здесь будет длинный текст для проверки. Владислав Алексеевич похож на колобка',
      3,
    ),
  ];

  ItemWidget({
    super.key,
    this.image,
    required this.description,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20.0),
              image == null
                  ? SizedBox()
                  : CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 88, 181, 255),
                      radius: 50.0,
                      backgroundImage: NetworkImage("${getEnv("SERVER_URL")}/uploads/$image"),
                    ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.caveat(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      description,
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 65, 65, 65)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 20,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage(comments[index].userPhotoUrl),
                              radius: 40.0,
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comments[index].userName,
                                    style: GoogleFonts.caveat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    comments[index].text,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 5.0),
                                  Row(
                                    children: List.generate(
                                      comments[index].rating,
                                      (i) => Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //SizedBox(height: 10.0),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
