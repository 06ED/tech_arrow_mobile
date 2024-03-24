import 'package:nylo_framework/nylo_framework.dart';

class CommentModel extends Model {
  final String userPhotoUrl;
  final String userName;
  final String text;
  final int rating;

  CommentModel(
    this.userPhotoUrl,
    this.userName,
    this.text,
    this.rating,
  );
}
