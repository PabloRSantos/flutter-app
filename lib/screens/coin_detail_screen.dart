import 'package:cointacao/models/coin_detail_model.dart';
import 'package:cointacao/stores/coin_detail_store.dart';
import 'package:cointacao/stores/user_store.dart';
import 'package:cointacao/widgets/appbar_widget.dart';
import 'package:cointacao/widgets/button_widget.dart';
import 'package:cointacao/widgets/card_widget.dart';
import 'package:cointacao/widgets/dialog_widget.dart';
import 'package:cointacao/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class CoinDetailScreen extends StatefulWidget {
  final String code;
  const CoinDetailScreen({super.key, required this.code});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  late CoinDetailStore coinDetailStore;
  late UserStore userStore;
  late bool isFavorite;
  bool _isLoading = false;

  String formatDate(String timestamp) {
    final DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    return DateFormat('dd/MM').format(date);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userStore = Provider.of<UserStore>(context, listen: false);
    coinDetailStore = Provider.of<CoinDetailStore>(context, listen: false);
    coinDetailStore.getCoin(code: widget.code);

    isFavorite = userStore.user?.coins.contains(widget.code) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation:
          Listenable.merge([coinDetailStore.isLoading, coinDetailStore.state]),
      builder: (context, child) {
        if (coinDetailStore.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final coin = coinDetailStore.state.value!;
        final lowestValue =
            coin.statements.map((e) => e.value).reduce((a, b) => a < b ? a : b);
        final highestValue =
            coin.statements.map((e) => e.value).reduce((a, b) => a > b ? a : b);

        String formatCurrency(double value) {
          final NumberFormat currencyFormat =
              NumberFormat.currency(symbol: 'R\$');

          if (value >= 1e9) {
            return '${currencyFormat.currencySymbol}${(value / 1e9).toStringAsFixed(1)}B';
          } else if (value >= 1e6) {
            return '${currencyFormat.currencySymbol}${(value / 1e6).toStringAsFixed(1)}M';
          } else if (value >= 1e3) {
            return '${currencyFormat.currencySymbol}${(value / 1e3).toStringAsFixed(1)}K';
          } else {
            return currencyFormat.format(value);
          }
        }

        return Scaffold(
          appBar: AppBarWidget(
            title: coinDetailStore.state.value!.name,
          ),
          backgroundColor: colorScheme.secondaryContainer,
          body: Column(
            children: [
              const SizedBox(height: 15.0),
              CardWidget(
                pressable: false,
                code: coin.code,
                name: coin.name,
                value: coin.statements[coin.statements.length - 1].value,
                varBid: coin.statements[coin.statements.length - 1].varBid,
                pctChange:
                    coin.statements[coin.statements.length - 1].pctChange,
              ),
              Container(
                height: 500,
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 64.0, 16.0, 0),
                    child: LineChart(
                      LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final int index = value.toInt();
                                  final bool isFirst = index == 0;
                                  final bool isLast =
                                      index == coin.statements.length - 1;

                                  if (isFirst || isLast) {
                                    final EdgeInsets margin = isFirst
                                        ? const EdgeInsets.only(left: 40.0)
                                        : const EdgeInsets.only(right: 40.0);

                                    return Container(
                                      margin: margin,
                                      child: Text(
                                        formatDate(
                                            coin.statements[index].timestamp),
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 50,
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value == highestValue ||
                                      value == lowestValue) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 32.0),
                                      child: Text(
                                        formatCurrency(value),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          overflow: TextOverflow
                                              .visible, // Permitir overflow
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          backgroundColor: colorScheme.surface,
                          borderData: FlBorderData(
                            show: false,
                            border: Border.all(
                                color: const Color(0xff37434d), width: 1),
                          ),
                          minX: 0,
                          maxX: coin.statements.length.toDouble() - 1,
                          minY: lowestValue,
                          maxY: highestValue,
                          lineBarsData: [
                            LineChartBarData(
                              spots:
                                  coin.statements.asMap().entries.map((entry) {
                                int index = entry.key;
                                StatementModel statement = entry.value;
                                return FlSpot(
                                    index.toDouble(), statement.value);
                              }).toList(),
                              isCurved: true,
                              color: colorScheme.primary,
                              barWidth: 2,
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                                getTooltipItems:
                                    (List<LineBarSpot> touchedSpots) {
                              return touchedSpots
                                  .map((LineBarSpot touchedSpot) {
                                final textStyle = TextStyle(
                                  color: touchedSpot.bar.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                );
                                return LineTooltipItem(
                                  formatCurrency(touchedSpot.y),
                                  textStyle,
                                );
                              }).toList();
                            }),
                            handleBuiltInTouches: true,
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomButton(
                    text: isFavorite ? "Desfavoritar" : "Favoritar",
                    isLoading: _isLoading,
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        if (isFavorite) {
                          await coinDetailStore.unfavorite(
                              widget.code, userStore.user?.id);
                          setState(() {
                            isFavorite = false;
                          });
                        } else {
                          await coinDetailStore.favorite(
                              widget.code, userStore.user?.id);
                          setState(() {
                            isFavorite = true;
                          });
                        }
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const DialogWidget(
                              title: 'Erro',
                              content: 'Erro ao fazer operação',
                            );
                          },
                        );
                      } finally {
                        userStore.fetchUser();
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    type: 'primary'),
              )
            ],
          ),
        );
      },
    );
  }
}
