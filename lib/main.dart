import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htag_directory/components/add_hashtag_component.dart';
import 'package:htag_directory/repositories/hashtag_repository.dart';
import 'package:htag_directory/screens/home_screen.dart';
import 'package:htag_directory/services/generate_hashtag/generate_hashtag_bloc.dart';
import 'package:htag_directory/services/hashtag_list/hashtag_list_bloc.dart';
import 'package:htag_directory/services/add_hashtag/add_hashtag_bloc.dart';
import 'package:htag_directory/services/remove_hashtag/remove_hashtag_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Database database = await openDatabase(
    join(
      await getDatabasesPath(),
      "hd.db",
    ),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE hashtags (id INTEGER PRIMARY KEY, name TEXT)",
      );
    },
    version: 1,
  );

  final HashtagRepository hashtagRepository = HashtagRepository(
    database: database,
  );

  runApp(
    HashtagDirectoryApp(
      hashtagRepository: hashtagRepository,
    ),
  );
}

class HashtagDirectoryApp extends StatelessWidget {
  final HashtagRepository hashtagRepository;
  const HashtagDirectoryApp({
    Key? key,
    required this.hashtagRepository,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HashtagListBloc>(
          lazy: false,
          create: (context) => HashtagListBloc(
            hashtagRepository,
          )..add(OnInitializeHashtagListEvent()),
        ),
        BlocProvider(
          create: (context) => AddHashtagBloc(
            hashtagRepository,
          ),
        ),
        BlocProvider(
          create: (context) => RemoveHashtagBloc(
            hashtagRepository,
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => GenerateHashtagBloc(
            hashtagRepository,
          )..add(const OnChangeNumberHastagEvent(0)),
        ),
      ],
      child: const MaterialApp(
        title: 'Hashtag Directory',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
