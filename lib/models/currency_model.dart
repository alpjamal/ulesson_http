class CurrencyResponse {
  String? result;
  String? documentation;
  String? termsOfUse;
  num? timeLastUpdateUnix;
  String? timeLastUpdateUtc;
  num? timeNextUpdateUnix;
  String? timeNextUpdateUtc;
  String? baseCode;
  List<Currency>? conversionRates;

  CurrencyResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    documentation = json['documentation'];
    termsOfUse = json['terms_of_use'];
    timeLastUpdateUnix = json['time_last_update_unix'];
    timeLastUpdateUtc = json['time_last_update_utc'];
    timeNextUpdateUnix = json['time_next_update_unix'];
    timeNextUpdateUtc = json['time_next_update_utc'];
    baseCode = json['base_code'];

    if (json['conversion_rates'] != null) {
      conversionRates = [];
      (json['conversion_rates'] as List).forEach((element) {
        conversionRates!.add(
          Currency(
            name: element['name'],
            exchangeValue: element['rate'],
            time: element['time'],
          ),
        );
      });
    }
  }
}

class Currency {
  final String name;
  final num exchangeValue;
  final String time;

  Currency({
    required this.name,
    required this.exchangeValue,
    required this.time,
  });
}
