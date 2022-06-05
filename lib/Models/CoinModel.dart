

class CoinModel {
  CoinModel({
    this.name,
    this.s,
    this.sanitizedName,
    this.baseCurrency,
    this.baseCurrencyName,
    this.baseCurrencyType,
    this.baseCurrencyLogo,
    this.quoteCurrency,
    this.quoteCurrencyName,
    this.quoteCurrencyType,
    this.basePrecision,
    this.quotePrecision,
    this.minTradeSize,
    this.maxTradeSize,
    this.minTradeValue,
    this.maxTradeValue,
    this.baseTickerSize,
    this.quoteTickerSize,
    this.status,
    this.tradeStatus,
    this.buyOrderStatus,
    this.sellOrderStatus,
    this.cancelOrderStatus,
    this.chartEnabled,
    this.last,
    this.change,
    this.high,
    this.low,
    this.volume,
  });

  String? name;
  bool? s;
  String? sanitizedName;
  String? baseCurrency;
  String? baseCurrencyName;
  String? baseCurrencyType;
  String? baseCurrencyLogo;
  String? quoteCurrency;
  String? quoteCurrencyName;
  String? quoteCurrencyType;
  int? basePrecision;
  int? quotePrecision;
  String? minTradeSize;
  String? maxTradeSize;
  String? minTradeValue;
  String? maxTradeValue;
  String? baseTickerSize;
  String? quoteTickerSize;
  bool? status;
  bool? tradeStatus;
  bool? buyOrderStatus;
  bool? sellOrderStatus;
  bool? cancelOrderStatus;
  bool? chartEnabled;
  String? last;
  String? change;
  String? high;
  String? low;
  String? volume;

  factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
    name: json["name"],
    s: json["s"],
    sanitizedName: json["sanitized_name"],
    baseCurrency: json["base_currency"],
    baseCurrencyName: json["base_currency_name"],
    baseCurrencyType: json["base_currency_type"],
    baseCurrencyLogo: json["base_currency_logo"],
    quoteCurrency: json["quote_currency"],
    quoteCurrencyName: json["quote_currency_name"],
    quoteCurrencyType: json["quote_currency_type"],
    basePrecision: json["base_precision"],
    quotePrecision: json["quote_precision"],
    minTradeSize: json["min_trade_size"],
    maxTradeSize: json["max_trade_size"],
    minTradeValue: json["min_trade_value"],
    maxTradeValue: json["max_trade_value"],
    baseTickerSize: json["base_ticker_size"],
    quoteTickerSize: json["quote_ticker_size"],
    status: json["status"],
    tradeStatus: json["trade_status"],
    buyOrderStatus: json["buy_order_status"],
    sellOrderStatus: json["sell_order_status"],
    cancelOrderStatus: json["cancel_order_status"],
    chartEnabled: json["chart_enabled"],
    last: json["last"],
    change: json["change"],
    high: json["high"],
    low: json["low"],
    volume: json["volume"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "s": s,
    "sanitized_name": sanitizedName,
    "base_currency": baseCurrency,
    "base_currency_name": baseCurrencyName,
    "base_currency_type": baseCurrencyType,
    "base_currency_logo": baseCurrencyLogo,
    "quote_currency": quoteCurrency,
    "quote_currency_name": quoteCurrencyName,
    "quote_currency_type": quoteCurrencyType,
    "base_precision": basePrecision,
    "quote_precision": quotePrecision,
    "min_trade_size": minTradeSize,
    "max_trade_size": maxTradeSize,
    "min_trade_value": minTradeValue,
    "max_trade_value": maxTradeValue,
    "base_ticker_size": baseTickerSize,
    "quote_ticker_size": quoteTickerSize,
    "status": status,
    "trade_status": tradeStatus,
    "buy_order_status": buyOrderStatus,
    "sell_order_status": sellOrderStatus,
    "cancel_order_status": cancelOrderStatus,
    "chart_enabled": chartEnabled,
    "last": last,
    "change": change,
    "high": high,
    "low": low,
    "volume": volume,
  };
}
