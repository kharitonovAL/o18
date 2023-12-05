part of 'message_cubit.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {
  @override
  String toString() => 'MessageInitial';
}

class MessageLoading extends MessageState {
  @override
  String toString() => 'MessageLoading';
}

class MessageLoaded extends MessageState {
  final List<ParseMessage> messageList;

  const MessageLoaded(this.messageList);

  @override
  String toString() => 'MessageLoaded';

  @override
  List<Object> get props => [messageList];
}

class MessageLoadFailure extends MessageState {
  final String error;

  const MessageLoadFailure({required this.error});

  @override
  String toString() => 'MessageLoadFailure { error: $error }';
}

class MessageWasRead extends MessageState {
  final List<ParseMessage> messageList;

  const MessageWasRead(this.messageList);

  @override
  String toString() => 'MessageWasRead';

  @override
  List<Object> get props => [messageList];
}

class MessageWasReadFailure extends MessageState {
  final String error;

  const MessageWasReadFailure({required this.error});

  @override
  String toString() => 'MessageWasReadFailure { error: $error }';
}
