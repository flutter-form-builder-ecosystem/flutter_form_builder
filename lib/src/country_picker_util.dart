import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';

class CountryPickerUtil {
  static Country _getCountryByField(
      String Function(Country) fieldAccessor, String query) {
    final queryUpperCase = query.toUpperCase();
    return countryList.firstWhere(
        (country) => fieldAccessor(country).toUpperCase() == queryUpperCase,
        orElse: () => null);
  }

  static Country getCountryByIso3Code(String iso3Code) {
    return _getCountryByField((country) => country.iso3Code, iso3Code);
  }

  static Country getCountryByIsoCode(String isoCode) {
    return _getCountryByField((country) => country.isoCode, isoCode);
  }

  static Country getCountryByName(String name) {
    return _getCountryByField((country) => country.name, name);
  }

  static Country getCountryByPhoneCode(String phoneCode) {
    return _getCountryByField((country) => country.phoneCode, phoneCode);
  }

  static Country getCountryByCodeOrName(String codeOrName) {
    return getCountryByIso3Code(codeOrName) ??
        getCountryByIsoCode(codeOrName) ??
        getCountryByName(codeOrName) ??
        getCountryByPhoneCode(codeOrName);
  }
}
