import 'package:driver/core/classes/account_type.dart';

String accountTypeToString(AccountType accountType) {
  return accountType.toString().split('.').last;
}

AccountType stringToAccountType(String str) {
  switch (str) {
    case 'company':
      return AccountType.company;
    case 'traveller':
      return AccountType.traveller;
    case 'unknown':
      return AccountType.unknown;
    default:
      throw ArgumentError('Invalid string value for AccountType: $str');
  }
}

AccountType accountTypeFromArabicString(String str) {
  switch (str) {
    case 'شركة':
      return AccountType.company;
    case 'مسافر':
      return AccountType.traveller;
    case 'غير معروف':
      return AccountType.unknown;
    default:
      throw ArgumentError('Invalid Arabic string value for AccountType: $str');
  }
}

String accountTypeToArabic(AccountType accountType) {
  switch (accountType) {
    case AccountType.company:
      return 'شركة';
    case AccountType.traveller:
      return 'مسافر';
    case AccountType.unknown:
      return 'غير معروف';
    default:
      throw ArgumentError('Invalid AccountType value: $accountType');
  }
}
