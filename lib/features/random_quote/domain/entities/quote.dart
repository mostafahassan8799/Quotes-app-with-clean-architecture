import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String msg;

  const Quote({
    required this.msg,
  });
  @override
  List<Object?> get props => [msg];
}
