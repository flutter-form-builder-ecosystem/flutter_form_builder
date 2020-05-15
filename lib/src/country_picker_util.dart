import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';

class CountryPickerUtil {
  static Country getCountryByIso3Code(String iso3Code) {
    try {
      return countryList.firstWhere(
        (country) => country.iso3Code.toLowerCase() == iso3Code.toLowerCase(),
      );
    } catch (error) {
      return null;
    }
  }

  static Country getCountryByIsoCode(String isoCode) {
    try {
      return countryList.firstWhere(
        (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
      );
    } catch (error) {
      return null;
    }
  }

  static Country getCountryByName(String name) {
    try {
      return countryList.firstWhere(
        (country) => country.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (error) {
      return null;
    }
  }

  static Country getCountryByPhoneCode(String phoneCode) {
    try {
      return countryList.firstWhere(
        (country) => country.phoneCode.toLowerCase() == phoneCode.toLowerCase(),
      );
    } catch (error) {
      return null;
    }
  }

  static Country getCountryByCodeOrName(String codeOrName) {
    var country;
    country = getCountryByIso3Code(codeOrName);
    if (country != null) return country;
    country = getCountryByIsoCode(codeOrName);
    if (country != null) return country;
    country = getCountryByName(codeOrName);
    if (country != null) return country;
    country = getCountryByPhoneCode(codeOrName);
    if (country != null) return country;
    return country;
  }
}
