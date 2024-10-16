class CoinModel {
  final String code;
  final String name;
  final String pctChange;
  final double varBid;
  final double value;
  final double high;
  final double low;
  final int timestamp;

  CoinModel(
      {required this.code,
      required this.name,
      required this.pctChange,
      required this.varBid,
      required this.value,
      required this.high,
      required this.low,
      required this.timestamp});

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
      code: map['code'],
      name: map['name'].split('/')[0],
      pctChange: map['pctChange'],
      varBid: double.parse(map['varBid']),
      value: double.parse(map['bid']),
      high: double.parse(map['high']),
      low: double.parse(map['low']),
      timestamp: int.parse(map['timestamp']),
    );
  }
}
