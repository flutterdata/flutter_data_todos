import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todos/models/user.dart';

part 'credit_card.g.dart';

@JsonSerializable()
@DataRepository([])
class CreditCard extends DataModel<CreditCard> {
  @override
  final String id;
  final String cardNumber;
  final String cvv;
  final String date;
  final String expiryDate;
  final BelongsTo<User> user;

  CreditCard({
    this.cardNumber,
    this.cvv,
    this.date,
    this.expiryDate,
    this.id,
    BelongsTo<User> user,
  }) : user = user ?? BelongsTo<User>();
}
