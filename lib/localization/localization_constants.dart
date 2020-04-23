import 'package:commanddelemiter/localization/deliniter_localization.dart';
import 'package:flutter/cupertino.dart';

String getTranslated(BuildContext context, String key) {
  return DelimiterLocalization.of(context).getTranslatedValue(key);
}