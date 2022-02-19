//todo: implement or find implementation for pluralize

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_test/config/constants.dart';

String pluralize(String word, int count) {
  if (count < 2) {
    return word;
  } else {
    return word + 's';
  }
}

String formatWithCurrency(num value,
    {String? currencySign,
    bool leading = false,
    bool addSpace = true,
    int fractionDigits = 0}) {
  String res;
  String _currencySign = currencySign ?? CURRENCY_SIGN;

  if (leading == true) {
    res = _currencySign +
        (addSpace == true ? ' ' : '') +
        value.toStringAsFixed(fractionDigits);
  } else {
    res = value.toStringAsFixed(fractionDigits) +
        (addSpace == true ? ' ' : '') +
        _currencySign;
  }

  return res;
}

DateTime? tryExtractDate(dynamic arg) {
  if (arg == null) return null;

  DateTime? res;

  try {
    res = arg.toDate();
  } on NoSuchMethodError {
    res = DateTime.parse(arg);
  } catch (e) {
    print(e.toString());
    return null;
  }

  return res;
}
