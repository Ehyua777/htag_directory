part of 'add_hashtag_bloc.dart';

abstract class AddHashtagState extends Equatable {
  const AddHashtagState();

  @override
  List<Object> get props => [];
}

class AddHashtagInitial extends AddHashtagState {}

class AddHashtagSuccessState extends AddHashtagState {
  final int timestamp;

  const AddHashtagSuccessState({
    required this.timestamp,
  });

  @override
  List<Object> get props => [
        timestamp,
      ];
}
