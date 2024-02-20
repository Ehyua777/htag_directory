import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htag_directory/models/hashtag_model.dart';
import 'package:htag_directory/services/hashtag_list/hashtag_list_bloc.dart';
import 'package:htag_directory/services/remove_hashtag/remove_hashtag_bloc.dart';

class HashtagListView extends StatelessWidget {
  const HashtagListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoveHashtagBloc, RemoveHashtagState>(
      listener: (context, state) {
        print(state);
        if (state is RemoveHashtagSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item removed'),
            ),
          );
        }
      },
      child: BlocConsumer<HashtagListBloc, HashtagListState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<HashtagModel> hashtagsList = [];
          if (state is HashtagListInitialState) {
            hashtagsList = state.hashtagList;
          }

          return hashtagsList.isEmpty
              ? const Center(
                  child: Text("No #Tag"),
                )
              : ListView.builder(
                  itemCount: hashtagsList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (direction) {
                        context
                            .read<RemoveHashtagBloc>()
                            .add(OnRemoveHashtagEvent(
                              hashtagModel: hashtagsList[index],
                            ));
                      },
                      key: Key(
                        "${index.toString()}-${DateTime.now().millisecondsSinceEpoch}",
                      ),
                      background: Container(
                        color: Colors.red,
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            "#${hashtagsList[index].name}",
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
