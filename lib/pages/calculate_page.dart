import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculate/models/salary.dart';
import 'package:flutter_calculate/page_router.dart';
import 'package:flutter_calculate/pages/result_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _salaryBefore;
  int _taxThreshold;
  int _houseFunds;
  int _socialSecurity;
  final _formKey = new GlobalKey<FormState>();
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  TextEditingController _textEditController1 = TextEditingController();
  TextEditingController _textEditController2 = TextEditingController();
  TextEditingController _textEditController3 = TextEditingController();
  TextEditingController _textEditController4 = TextEditingController();
  bool _btnCalculateEnabled = false;

  @override
  void initState() {
    super.initState();
    _textEditController1.addListener(() {
      _textEditController4.text = _textEditController1.text;
      _textEditController3.text = _textEditController1.text;
      _checkBtnEnable();
    });
    _textEditController2.addListener(_checkBtnEnable);
    _textEditController3.addListener(_checkBtnEnable);
    _textEditController4.addListener(_checkBtnEnable);
    f3.addListener(() {
      //leave
      if (!f3.hasFocus && _textEditController3.text.isNotEmpty) {
        int val = int.parse(_textEditController3.text);
        if (val < 3387 || val > 25401) {
          Fluttertoast.showToast(
            msg: '据北京的政策，公积金缴纳范围:3387 - 25401',
          );
        }
      }
    });
    f4.addListener(() {
      //leave
      if (!f4.hasFocus && _textEditController4.text.isNotEmpty) {
        int val = int.parse(_textEditController4.text);
        if (val < 2273 || val > 25401) {
          Fluttertoast.showToast(
            msg: '据北京的政策，公积金缴纳范围:2273 - 25401',
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBg(),
    );
  }

  _buildBg() {
    return SingleChildScrollView(
      child: Stack(
        alignment: FractionalOffset(0.0, 0.0),
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 160.0,
                color: Colors.blue,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: _buildBody(),
          )
        ],
      ),
    );
  }

  _buildBody() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildPart0(),
            _buildPart1(),
            _buildPart2(),
            _buildPart3(),
          ],
        ),
      ),
    );
  }

  _buildPart0() {
    return Column(
      children: <Widget>[
        Text(
          '月薪计算',
          style: Theme.of(context).textTheme.title.apply(color: Colors.white),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          padding:
              EdgeInsets.only(left: 8.0, top: 2.0, right: 8.0, bottom: 4.0),
          decoration: BoxDecoration(
            color: Color(0X20000000),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text('因雇佣关系而得的工资、奖金、津贴、薪金、补贴等',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .apply(color: Colors.white)),
        ),
      ],
    );
  }

  _buildPart1() {
    return Container(
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
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          //税前工资
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '税前工资:',
                  style: Theme.of(context).textTheme.body1,
                ),
                TextFormField(
                  maxLines: 1,
                  focusNode: f1,
                  decoration: InputDecoration(
                    hintText: '请输入税前工资',
                    prefixText: '¥',
                    prefixStyle: Theme.of(context).textTheme.subhead,
                  ),
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) =>
                      FocusScope.of(context).requestFocus(f2),
                  onSaved: (val) => _salaryBefore = int.parse(val),
                  controller: _textEditController1,
                ),
              ],
            ),
          ),
          //个税起征点
          Container(
            margin: EdgeInsets.only(bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '起征点:',
                  style: Theme.of(context).textTheme.body1,
                ),
                TextFormField(
                  maxLines: 1,
                  focusNode: f2,
                  decoration: InputDecoration(hintText: '请输入个税起征点'),
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) =>
                      FocusScope.of(context).requestFocus(f3),
                  onSaved: (val) => _taxThreshold = int.parse(val),
                  controller: _textEditController2,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text.rich(TextSpan(
                        style: Theme.of(context).textTheme.caption,
                        children: [
                          TextSpan(text: '2018之前起征点'),
                          TextSpan(
                              text: '3500',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .apply(color: Colors.blue)),
                          TextSpan(text: '，2018.10之后起征点'),
                          TextSpan(
                              text: '5000',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .apply(color: Colors.blue)),
                        ]))),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _buildPart2() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
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
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                '是否缴纳社保公积金',
                style: Theme.of(context).textTheme.subhead,
              )),
              Switch(
                value: true,
                activeColor: Colors.blue,
                onChanged: (val) {},
              ),
            ],
          ),

          //社保基数
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '社保基数:',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    Icon(Icons.info_outline, size: 14.0, color: Colors.blue),
                  ],
                ),
                TextFormField(
                  maxLines: 1,
                  focusNode: f3,
                  decoration: InputDecoration(
                    hintText: '请输入社保基数',
                    prefixText: '¥',
                    prefixStyle: Theme.of(context).textTheme.body1,
                  ),
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) =>
                      FocusScope.of(context).requestFocus(f4),
                  onSaved: (val) => _socialSecurity = int.parse(val),
                  controller: _textEditController3,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text.rich(TextSpan(
                        style: Theme.of(context).textTheme.caption,
                        children: [
                          TextSpan(text: '据北京的政策，社保缴纳范围: '),
                          TextSpan(
                              text: '3387 - 25401',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .apply(color: Colors.blue)),
                        ]))),
              ],
            ),
          ),
          //公积金基数
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '公积金基数:',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    Icon(Icons.info_outline, size: 14.0, color: Colors.blue),
                  ],
                ),
                TextFormField(
                  maxLines: 1,
                  focusNode: f4,
                  decoration: InputDecoration(
                    hintText: '请输入公积金基数',
                    prefixText: '¥',
                    prefixStyle: Theme.of(context).textTheme.body1,
                  ),
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.done,
                  onSaved: (val) => _houseFunds = int.parse(val),
                  controller: _textEditController4,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text.rich(TextSpan(
                        style: Theme.of(context).textTheme.caption,
                        children: [
                          TextSpan(text: '据北京的政策，公积金缴纳范围:'),
                          TextSpan(
                              text: '2273 - 25401',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .apply(color: Colors.blue)),
                        ]))),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _buildPart3() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: Container(
                child: Text('计算'),
                height: 40.0,
                alignment: Alignment.center,
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              textColor: Colors.white,
              disabledColor: Colors.black12,
              onPressed: _btnCalculateEnabled ? _onSubmit : null,
            ),
          ),
        ],
      ),
    );
  }

  _checkBtnEnable() {
//    print('_checkBtnEnable');
    var enabled = false;
    if (_textEditController1.text.isNotEmpty &&
        _textEditController2.text.isNotEmpty &&
        _textEditController3.text.isNotEmpty &&
        _textEditController4.text.isNotEmpty) {
      enabled = true;
    } else {
      enabled = false;
    }
    setState(() {
      _btnCalculateEnabled = enabled;
    });
//    print('$_btnCalculateEnabled');
  }

  _calculate() {
//   3%  0
//   10% 210
//   20% 1410
//   25% 2660
//   30% 4410
//   35% 7160
//   45% 15160
    //个人所得税=（工资－五险一金个人缴纳部分－免征额）×税率-速算扣除数
    print('_calculate');
    var salaryAfter;
    //社保 养老8%，失业0.2%，医疗2%+3；(工伤和生育 个人不缴)
    var social = _socialSecurity * (0.08 + 0.002 + 0.02) + 3;
    social = num.parse(social.toStringAsFixed(2));
    var funds = _houseFunds * 0.12; //公积金 12%
    funds = num.parse(funds.toStringAsFixed(2));
    //应纳税所得额:（工资－五险一金个人缴纳部分－免征额）
    var taxAmount = _salaryBefore - social - funds - _taxThreshold;
    var tax; //应缴税:应纳税所得额×税率-速算扣除数
    if (taxAmount <= 0) {
      tax = 0;
    } else if (taxAmount <= 3000) {
      tax = taxAmount * 0.03 - 0;
    } else if (taxAmount < 12000) {
      tax = taxAmount * 0.10 - 210;
    } else if (taxAmount < 25000) {
      tax = taxAmount * 0.20 - 1410;
    } else if (taxAmount < 35000) {
      tax = taxAmount * 0.25 - 2660;
    } else if (taxAmount < 55000) {
      tax = taxAmount * 0.30 - 4410;
    } else if (taxAmount < 80000) {
      tax = taxAmount * 0.35 - 7160;
    } else {
      tax = taxAmount * 0.45 - 15160;
    }
    tax = num.parse(tax.toStringAsFixed(2));
    salaryAfter = _salaryBefore - social - funds - tax; //税后所得:税前工资－五险-一金－缴税

    print('税后所得:$salaryAfter');
    var salary = Salary(
      salaryAfter: salaryAfter,
      salaryBefore: _salaryBefore,
      social: social,
      funds: funds,
      taxAmount: taxAmount,
      tax: tax,
    );
    print('salary:$salary');
    Navigator.of(context).push(SlidePageRouter().pageBuilder(ResultPage(
      title: 'Result',
      salary: salary,
    )));
  }

  _onSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _calculate();
    }
  }
}
