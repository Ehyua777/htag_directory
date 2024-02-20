part of 'hashtag_list_bloc.dart';

abstract class HashtagListState extends Equatable {
  const HashtagListState();

  @override
  List<Object> get props => [];
}

class HashtagListInitialState extends HashtagListState {
  final List<HashtagModel> hashtagList;
  const HashtagListInitialState({
    required this.hashtagList,
  });

  @override
  List<Object> get props => [
        hashtagList,
      ];
}
