// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) {
  return CreditCard(
    cardNumber: json['cardNumber'] as String,
    cvv: json['cvv'] as String,
    date: json['date'] as String,
    expiryDate: json['expiryDate'] as String,
    id: json['id'] as String,
    user: json['user'] == null
        ? null
        : BelongsTo.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardNumber': instance.cardNumber,
      'cvv': instance.cvv,
      'date': instance.date,
      'expiryDate': instance.expiryDate,
      'user': instance.user,
    };

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $CreditCardLocalAdapter on LocalAdapter<CreditCard> {
  @override
  Map<String, Map<String, Object>> relationshipsFor([CreditCard model]) => {
        'user': {'type': 'users', 'kind': 'BelongsTo', 'instance': model?.user}
      };

  @override
  CreditCard deserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key)],
      };
    }
    return _$CreditCardFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model) => _$CreditCardToJson(model);
}

// ignore: must_be_immutable
class $CreditCardHiveLocalAdapter = HiveLocalAdapter<CreditCard>
    with $CreditCardLocalAdapter;

class $CreditCardRemoteAdapter = RemoteAdapter<CreditCard> with NothingMixin;

//

final creditCardLocalAdapterProvider = Provider<LocalAdapter<CreditCard>>(
    (ref) => $CreditCardHiveLocalAdapter(ref));

final creditCardRemoteAdapterProvider = Provider<RemoteAdapter<CreditCard>>(
    (ref) =>
        $CreditCardRemoteAdapter(ref.read(creditCardLocalAdapterProvider)));

final creditCardRepositoryProvider =
    Provider<Repository<CreditCard>>((ref) => Repository<CreditCard>(ref));

final _watchCreditCard = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<CreditCard>, WatchArgs<CreditCard>>((ref, args) {
  return ref.watch(creditCardRepositoryProvider).watchOne(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierStateProvider<DataState<CreditCard>> watchCreditCard(
    dynamic id,
    {bool remote = true,
    Map<String, dynamic> params = const {},
    Map<String, String> headers = const {},
    AlsoWatch<CreditCard> alsoWatch}) {
  return _watchCreditCard(WatchArgs(
          id: id,
          remote: remote,
          params: params,
          headers: headers,
          alsoWatch: alsoWatch))
      .state;
}

final _watchCreditCards = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<List<CreditCard>>, WatchArgs<CreditCard>>(
        (ref, args) {
  ref.maintainState = false;
  return ref.watch(creditCardRepositoryProvider).watchAll(
      remote: args.remote, params: args.params, headers: args.headers);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<CreditCard>>>
    watchCreditCards(
        {bool remote,
        Map<String, dynamic> params,
        Map<String, String> headers}) {
  return _watchCreditCards(
      WatchArgs(remote: remote, params: params, headers: headers));
}

extension CreditCardX on CreditCard {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Pass:
  ///  - A `BuildContext` if using Flutter with Riverpod or Provider
  ///  - Nothing if using Flutter with GetIt
  ///  - A Riverpod `ProviderContainer` if using pure Dart
  ///  - Its own [Repository<CreditCard>]
  CreditCard init(context) {
    final repository = context is Repository<CreditCard>
        ? context
        : internalLocatorFn(creditCardRepositoryProvider, context);
    return repository.internalAdapter.initializeModel(this, save: true)
        as CreditCard;
  }
}
