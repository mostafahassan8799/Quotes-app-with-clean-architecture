import 'package:clean_architecture/features/random_quote/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({
    required String msg,
  }) : super(msg: msg);

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        msg: json["message"],
      );
}
