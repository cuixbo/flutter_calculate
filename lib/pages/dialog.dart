import 'package:flutter/material.dart';
import 'package:flutter_calculate/models/salary.dart';

class TaxRateDialog extends StatefulWidget {
  final bool touchOutSide;
  final TaxRate taxRate;

  TaxRateDialog({this.touchOutSide = false, this.taxRate});

  @override
  State<StatefulWidget> createState() => TaxRateDialogState();
}

class TaxRateDialogState extends State<TaxRateDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        child: _buildDialog(),
      ),
      onTap: widget.touchOutSide ? dismiss : null,
    );
  }

  _buildDialog() {
    TextStyle textStyle = Theme.of(context).textTheme.caption;
    var getRow = (index) {
      TaxRate rate = TaxRate.rates[index];
      return Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Text(
              '${rate.level}',
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
          Expanded(
            flex: 20,
            child: Text('${rate.amountRange}',
                textAlign: TextAlign.start, style: textStyle),
          ),
          Expanded(
            flex: 8,
            child: Text('${(rate.rate * 100).toInt()}%',
                textAlign: TextAlign.center, style: textStyle),
          ),
          Expanded(
            flex: 10,
            child: Text('${rate.quickDeduction}',
                textAlign: TextAlign.center, style: textStyle),
          ),
        ],
      );
    };

    var current = (index, item) {
      return Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 4.0,
                height: 40.0,
                child: Text(''),
                color: Colors.blue,
              ),
              Expanded(
                child: Container(
                  height: 40.0,
                  color: Colors.lightBlueAccent.withOpacity(0.1),
                ),
              )
            ],
          ),
          item
        ],
      );
    };

    Widget widget = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), color: Colors.white),
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.only(top: 16.0, bottom: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              '税率表',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          //todo
          Container(
            height: 32.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text(
                    '级数',
                    textAlign: TextAlign.center,
                    style: textStyle.copyWith(color: Colors.black87),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Text('应纳税所得额',
                      textAlign: TextAlign.start,
                      style: textStyle.copyWith(color: Colors.black87)),
                ),
                Expanded(
                  flex: 8,
                  child: Text('税率(%)',
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(color: Colors.black87)),
                ),
                Expanded(
                  flex: 10,
                  child: Text('速算扣除数',
                      textAlign: TextAlign.center,
                      style: textStyle.copyWith(color: Colors.black87)),
                ),
              ],
            ),
          ),
          ListView.builder(
              itemCount: TaxRate.rates.length * 2 + 1,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                int itemIndex = index ~/ 2;
                if (index % 2 == 0) {
                  return Divider(
                    height: 1.0,
                    indent: (index != 0 && index != TaxRate.rates.length * 2)
                        ? 16.0
                        : 0.0,
                  );
                }
                Widget item = Container(
                  height: 40.0,
                  child: getRow(itemIndex),
                );
                if (itemIndex == this.widget.taxRate.level - 1) {
                  return current(itemIndex, item);
                } else {
                  return item;
                }
              }),
          FlatButton(
//            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Container(
              height: 48.0,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text('我知道了'),
            ),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(4.0))),
            textColor: Colors.white,
//                    disabledColor: Colors.black12,
            onPressed: dismiss,
          ),
        ],
      ),
    );

    widget = InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        child: widget,
      ),
      onTap: () {},
    );
    return widget;
  }

  dismiss() {
    Navigator.of(context).pop();
  }
}

class DialogTip {
  static showSocialTip(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: const Text('社保基数'),
            children: <Widget>[
              new SimpleDialogOption(
                onPressed: () {},
                child: const Text(
                    '首次参加工作和变动工作单位的职工，为进单位首月全月税前工资收入。其他职工当年个人缴费基数为职工上一年度1月至12月的所有税前工资收入所得的月平均额'),
              ),
            ],
          );
        });
  }

  static showFundTip(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: const Text('公积金基数'),
            children: <Widget>[
              new SimpleDialogOption(
                onPressed: () {},
                child: const Text(
                    '首次参加工作和变动工作单位的职工，为进单位首月全月税前工资收入。其他职工当年个人缴费基数为职工上一年度1月至12月的所有税前工资收入所得的月平均额。'),
              ),
            ],
          );
        });
  }

  static showTaxAmountTip(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: const Text('应纳税所得额'),
            children: <Widget>[
              new SimpleDialogOption(
                onPressed: () {},
                child: const Text(
                  '是交税的计算依据。计算公式是:\n收入-准予扣除的金额',
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          );
        });
  }
}
