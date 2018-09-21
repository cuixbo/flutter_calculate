import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculate/models/salary.dart';
import 'package:flutter_calculate/pages/dialog.dart';
import 'package:flutter_calculate/widgets/icon_span.dart';

class ResultPage extends StatefulWidget {
  final String title;
  final Salary salary;

  ResultPage({Key key, this.title, this.salary}) : super(key: key);

  @override
  _ResultPageState createState() => new _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _formulaOffstage = true;
  var _c1 = Color(0xff0c83ff);
  var _c2 = Color(0xff81c7fb);
  var _c3 = Color(0xffb5ddfa);
  var _c4 = Color(0xffe1f2fd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
      ),
//      appBar: null,
      body: _buildScroll(),
    );
  }

  _buildScroll() {
    return SingleChildScrollView(
      child: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        Stack(
          alignment: FractionalOffset(0.5, 1.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 120.0,
                  color: Colors.blue,
                ),
                Container(
                  height: 60.0,
                  color: Colors.white,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: const Color(0x10000000),
                        offset: new Offset(0.0, 0.0),
                        blurRadius: 6.0,
                      ),
                    ]),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 20.0,
                    ),
                    Text(
                      '月薪税后工资',
                    ),
                    Container(
                      height: 8.0,
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: '¥ ${widget.salary.salaryAfter}',
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .apply(color: Colors.blue),
                      ),
                      TextSpan(text: '元', style: TextStyle(color: Colors.blue)),
                    ])),
                    Container(
                      height: 16.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Divider(
                        height: 1.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '且行且珍惜吧，兄嘚！',
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        ' 税前工资：',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Text(
                        '${widget.salary.salaryBefore}元',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 10000 *
                          widget.salary.salaryAfter ~/
                          widget.salary.salaryBefore,
                      child: Container(
                        decoration: BoxDecoration(
                            color: _c1,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(2.0))),
                        height: 16.0,
                      ),
                    ),
                    Expanded(
                      flex: 10000 *
                          widget.salary.social ~/
                          widget.salary.salaryBefore,
                      child: Container(
                        height: 16.0,
                        color: _c2,
                      ),
                    ),
                    Expanded(
                      flex: 10000 *
                          widget.salary.funds ~/
                          widget.salary.salaryBefore,
                      child: Container(
                        height: 16.0,
                        color: _c3,
                      ),
                    ),
                    Expanded(
                      flex: 10000 *
                          widget.salary.tax ~/
                          widget.salary.salaryBefore,
                      child: Container(
                        decoration: BoxDecoration(
                            color: _c4,
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(2.0))),
                        height: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _rectDot(color: _c1),
                      Text(
                        ' 税后工资',
                        style: _textStyle(),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.salary.salaryAfter}元',
                          textAlign: TextAlign.right,
                          style: _textStyle(),
                        ),
                      )
                    ],
                  )),
              Divider(
                height: 1.0,
                indent: 16.0,
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _rectDot(color: _c2),
                      Text(
                        ' 社保缴纳(个人)',
                        style: _textStyle(),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.salary.social}元',
                          textAlign: TextAlign.right,
                          style: _textStyle(),
                        ),
                      )
                    ],
                  )),
              Divider(
                height: 1.0,
                indent: 16.0,
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _rectDot(color: _c3),
                      Text(
                        ' 公积金缴纳(个人)',
                        style: _textStyle(),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.salary.funds}元',
                          textAlign: TextAlign.right,
                          style: _textStyle(),
                        ),
                      )
                    ],
                  )),
              Divider(
                height: 1.0,
                indent: 16.0,
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _rectDot(color: _c4),
                      Text(
                        ' 个税缴纳',
                        style: _textStyle(),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.salary.tax}元',
                          textAlign: TextAlign.right,
                          style: _textStyle(),
                        ),
                      )
                    ],
                  )),
              Divider(
                height: 1.0,
                indent: 16.0,
              ),
            ],
          ),
        ),
        _buildDetail(),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  child: Container(
                    child: Text('重新计算'),
                    height: 40.0,
                    alignment: Alignment.center,
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  textColor: Colors.white,
                  disabledColor: Colors.black12,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom:16.0),
          child: Text(
            '此应用UI设计参考仁励窝支付宝小程序\n如有侵权请联系cuixbo@qq.com',
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  _buildDetail() {
    Widget detailWidget = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${_formulaOffstage ? '展开' : '收起'}计算公式',
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Colors.blue)),
                Icon(
                  _formulaOffstage
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: Colors.black26,
                ),
              ],
            ),
            onTap: () {
              setState(() {
                _formulaOffstage = !_formulaOffstage;
              });
            },
          ),
        ),
        Offstage(
          offstage: _formulaOffstage,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                //padding: EdgeInsets.all(16.0),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Theme.of(context).dividerColor, width: 0.0),
                  borderRadius: BorderRadius.circular(2.0),
                )),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 4.0,
                      //padding: EdgeInsets.all(16.0),
                      decoration: ShapeDecoration(
                          color: Colors.lightBlueAccent.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.5),
                                topRight: Radius.circular(3.5)),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '税后工资',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.black87),
                              ),
                              Container(
                                width: 8.0,
                              ),
                              Text(
                                '${widget.salary.salaryAfter}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Container(
                            height: 8.0,
                          ),
                          Text(
                            '税前工资(${widget.salary.salaryBefore})-社保个人缴纳(${widget.salary.social})-公积金个人缴纳(${widget.salary.funds})-个人所得税(${widget.salary.tax})',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '个人所得税',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.black87),
                              ),
                              Container(
                                width: 8.0,
                              ),
                              Text(
                                '${widget.salary.tax}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Container(
                            height: 8.0,
                          ),
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      '应纳税所得额(${widget.salary.taxAmount}) *税率(${widget.salary.taxRate.rate * 100}%)',
                                  style: Theme.of(context).textTheme.caption),
                              IconSpan(
                                  icon: Icons.help_outline,
                                  color: Colors.blue,
                                  fontSize: 13.0,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => TaxRateDialog(
                                                taxRate: widget.salary.taxRate,
                                              ));
//                                    DialogTip.showTaxRateDialog(context);
                                    }),
                              TextSpan(
                                  text:
                                      '-速算扣除数(${widget.salary.taxRate.quickDeduction})',
                                  style: Theme.of(context).textTheme.caption),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                '应纳税所得额',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.black87),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.help_outline,
                                  color: Colors.blue,
                                  size: 13.0,
                                ),
                                onTap: () =>
                                    DialogTip.showTaxAmountTip(context),
                              ),
                              Container(
                                width: 8.0,
                              ),
                              Text(
                                '${widget.salary.taxAmount}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Container(
                            height: 8.0,
                          ),
                          Text(
                            '税前工资(${widget.salary.salaryBefore})-社保个人缴纳(${widget.salary.social})-公积金个人缴纳(${widget.salary.funds})-起征点(${widget.salary.taxThreshold})',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
    detailWidget = Container(
      color: Colors.white,
      child: detailWidget,
    );
    return detailWidget;
  }

  _rectDot({Color color}) {
    return Container(
      foregroundDecoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2.0))),
          color: color),
      width: 10.0,
      height: 10.0,
    );
  }

  _textStyle() {
    return TextStyle(color: Color(0xBB000000), fontSize: 13.0);
  }
}
