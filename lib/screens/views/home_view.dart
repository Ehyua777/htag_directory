import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:htag_directory/components/number_text_field_component.dart';
import 'package:htag_directory/services/generate_hashtag/generate_hashtag_bloc.dart';

import '../../models/hashtag_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Future<void> _copyToClipBoard(BuildContext context,
      GenerateHashtagSuccessState state, List<HashtagModel> hashtags) async {
    final String hashtagsList =
        state.hashtags.map((e) => "#${e.name}").join("");
    Clipboard.setData(ClipboardData(text: hashtagsList));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Hashtags copied to clipboard",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: NumberTextFieldComponent(),
          ),
          SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: () => context
                  .read<GenerateHashtagBloc>()
                  .add(OnGenerateHashtagsEvent()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: Text('Generate'),
                  ),
                  Icon(
                    Icons.copy,
                    size: 18,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<GenerateHashtagBloc, GenerateHashtagState>(
              listener: (context, state) {
                if (state is GenerateHashtagSuccessState) {
                  _copyToClipBoard(context, state, state.hashtags);
                  // final String hashtagsList =
                  //     state.hashtags.map((e) => "#${e.name}").join("");
                  // Clipboard.setData(ClipboardData(text: hashtagsList));

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text(
                  //       "Hashtags copied to clipboard",
                  //     ),
                  //   ),
                  // );
                }
              },
              builder: (context, state) {
                if (state is GenerateHashtagSuccessState) {
                  return ListView.builder(
                    itemCount: state.hashtags.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key("$index-${DateTime.now().microsecond}"),
                        child: Card(
                          child: ListTile(
                            title: Text(state.hashtags[index].name),
                          ),
                        ),
                        background: Container(
                          color: Colors.red,
                        ),
                        onDismissed: (direction) {
                          state.hashtags.removeAt(index);
                          _copyToClipBoard(context, state, state.hashtags);
                        },
                      );
                    },
                  );
                }
                return Container(
                  height: 50.0,
                  child: Center(
                    child: Text("No ashtag generated"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
