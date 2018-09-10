import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculate/models/salary.dart';
import 'package:flutter_calculate/page_router.dart';
import 'package:flutter_calculate/pages/result_page.dart';

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
  FocusNode f1 = FocusNode(),
      f2 = FocusNode(),
      f3 = FocusNode(),
      f4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildPart1(),
              _buildPart2(),
            ],
          ),
        ),
        onChanged: null,
      ),
    );
  }

  _buildScrollView() {}

  _buildPart1() {
    return Container(
      child: Column(children: <Widget>[
        //税前工资
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '税前工资:',
                style: Theme.of(context).textTheme.subhead,
              ),
              TextFormField(
                maxLines: 1,
                focusNode: f1,
                decoration: InputDecoration(
                  hintText: '请输入税前工资',
                ),
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (text) =>
                    FocusScope.of(context).requestFocus(f2),
                onSaved: (val) => _salaryBefore = int.parse(val),
              ),
            ],
          ),
        ),
        //个税起征点
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '起征点:',
                style: Theme.of(context).textTheme.subhead,
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
              ),
            ],
          ),
        ),
      ]),
    );
  }

  _buildPart2() {
    return Container(
      child: Column(children: <Widget>[
        //社保基数
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '社保基数:',
                style: Theme.of(context).textTheme.subhead,
              ),
              TextFormField(
                maxLines: 1,
                focusNode: f3,
                decoration: InputDecoration(hintText: '请输入社保基数'),
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (text) =>
                    FocusScope.of(context).requestFocus(f4),
                onSaved: (val) => _socialSecurity = int.parse(val),
              ),
            ],
          ),
        ),
        //公积金基数
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '公积金基数:',
                style: Theme.of(context).textTheme.subhead,
              ),
              TextFormField(
                maxLines: 1,
                focusNode: f4,
                decoration: InputDecoration(hintText: '请输入公积金基数'),
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
                onSaved: (val) => _houseFunds = int.parse(val),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
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
                  onPressed: _onSubmit,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
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
    //应纳税所得额:（工资－五险一金个人缴纳部分－免征额）
    var taxAmount = _salaryBefore - social - funds - _taxThreshold;
    var tax; //应缴税:应纳税所得额×税率-速算扣除数
    if (taxAmount <= 3000) {
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

  _onChange() {
//    print('_onChange');
  }

  _onSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(
          '_onSubmit:$_salaryBefore,$_taxThreshold,$_socialSecurity,$_houseFunds');
      _calculate();
    }
  }
}
