import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htag_directory/services/add_hashtag/add_hashtag_bloc.dart';

class AddHashtagComponent extends StatefulWidget {
  const AddHashtagComponent({super.key});

  @override
  State<AddHashtagComponent> createState() => _AddHashtagComponentState();
}

class _AddHashtagComponentState extends State<AddHashtagComponent> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _modal(BuildContext context) => showModalBottomSheet(
      context: context,
      builder: (context) => BlocListener<AddHashtagBloc, AddHashtagState>(
            listener: (context, state) {
              if (state is AddHashtagSuccessState) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Hashtag Added"),
                  duration: Duration(seconds: 1),
                ));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "#tag creator",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Enter your #tag",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel".toUpperCase()),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              context
                                  .read<AddHashtagBloc>()
                                  .add(OnAddHashtagEvent(
                                    hashtag: _controller.text,
                                  ));
                              _controller.clear();
                            } else {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Hashtag cannont be empty."),
                                ),
                              );
                            }
                            print(_controller.text);
                          },
                          child: Text("Add".toUpperCase()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _modal(context),
      child: const Icon(Icons.add),
    );
  }
}
