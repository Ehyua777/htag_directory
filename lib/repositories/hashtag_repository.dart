import 'dart:async';

import 'package:htag_directory/main.dart';
import 'package:htag_directory/models/hashtag_model.dart';
import 'package:htag_directory/services/generate_hashtag/generate_hashtag_bloc.dart';
import 'package:sqflite/sqflite.dart';

class HashtagRepository {
  final Database database;

  final List<Map<String, dynamic>> hashtagsList = [];

  int numberHashtags;

  HashtagRepository({
    required this.database,
    this.numberHashtags = 0,
  });

  final StreamController<List<HashtagModel>> _hashtagController =
      StreamController<List<HashtagModel>>();

  int get number => numberHashtags;

  set number(int value) => numberHashtags = value;

  Stream<List<HashtagModel>> get hashtags => _hashtagController.stream;

  Future<void> initialize() async {
    List<Map<String, dynamic>> map = await database.query("hashtags");

    hashtagsList.addAll(map);

    List<HashtagModel> hashtags = hashtagsList
        .map(
          (e) => HashtagModel(
            id: e["id"],
            name: e["name"],
          ),
        )
        .toList();

    _hashtagController.add(hashtags);
  }

  Future<void> addNewHashtag(Map<String, dynamic> data) async {
    final HashtagModel hashtag = HashtagModel(
      id: hashtagsList.length + 1,
      name: data["name"],
    );

    int id = await database.insert(
      "hashtags",
      hashtag.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    hashtagsList.add({
      ...data,
      ...{"id": id}
    });

    List<HashtagModel> hashtags = hashtagsList
        .map(
          (e) => HashtagModel(
            id: e["id"],
            name: e["name"],
          ),
        )
        .toList();

    _hashtagController.add(hashtags);
  }

  Future<void> removeHashtag(HashtagModel hashtagModel) async {
    await database.delete(
      "hashtags",
      where: "id = ?",
      whereArgs: [
        hashtagModel.id,
      ],
    );

    hashtagsList.removeWhere((e) => e["id"] == hashtagModel.id);

    List<HashtagModel> hashtags = hashtagsList
        .map(
          (e) => HashtagModel(
            id: e["id"],
            name: e["name"],
          ),
        )
        .toList();

    _hashtagController.add(hashtags);
  }

  Future<List<HashtagModel>> generate() async {
    hashtagsList.shuffle();

    final int n = numberHashtags > hashtagsList.length
        ? hashtagsList.length
        : numberHashtags;

    int i = 0;

    List<HashtagModel> hashtags = hashtagsList
        .sublist(0, n)
        .map(
          (e) => HashtagModel(
            id: i++,
            name: e["name"],
          ),
        )
        .toList();

    return hashtags;
  }
}
