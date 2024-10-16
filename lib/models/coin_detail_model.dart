class CoinDetailModel {
  final String code;
  final String name;
  final List<StatementModel> statements;

  CoinDetailModel(
      {required this.code, required this.name, required this.statements});

  factory CoinDetailModel.fromMap(Map<String, dynamic> map) {
    return CoinDetailModel(
      code: map['code'],
      name: map['name'].split('/')[0],
      statements: (map['statements'] as List)
          .map((statement) => StatementModel.fromMap(statement))
          .toList(),
    );
  }
}

class StatementModel {
  final String pctChange;
  final double varBid;
  final double value;
  final double high;
  final double low;
  final int timestamp;

  StatementModel(
      {required this.pctChange,
      required this.varBid,
      required this.value,
      required this.high,
      required this.low,
      required this.timestamp});

  factory StatementModel.fromMap(Map<String, dynamic> map) {
    return StatementModel(
      pctChange: map['pctChange'],
      varBid: double.parse(map['varBid']),
      value: double.parse(map['bid']),
      high: double.parse(map['high']),
      low: double.parse(map['low']),
      timestamp: int.parse(map['timestamp']),
    );
  }
}
