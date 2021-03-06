import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculate/models/salary.dart';
import 'package:flutter_calculate/page_router.dart';
import 'package:flutter_calculate/pages/dialog.dart';
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
  int _taxThreshold = 5000;
  int _houseFunds;
  int _socialSecurity;
  final _formKey = new GlobalKey<FormState>();
  FocusNode f1 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  TextEditingController _textEditController1 = TextEditingController();
  TextEditingController _textEditController3 = TextEditingController();
  TextEditingController _textEditController4 = TextEditingController();
  bool _btnCalculateEnabled = false;
  bool _switchValue = true;

  @override
  void initState() {
    super.initState();
    _textEditController1.addListener(() {
      _textEditController4.text = _textEditController1.text;
      _textEditController3.text = _textEditController1.text;
      _checkBtnEnable();
    });
    _textEditController3.addListener(_checkBtnEnable);
    _textEditController4.addListener(_checkBtnEnable);
    f3.addListener(() {
      if (!f3.hasFocus) {
        _checkSocial();
      }
    });
    f4.addListener(() {
      if (!f4.hasFocus) {
        _checkFunds();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
      appBar: null,
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
                    hintStyle: Theme.of(context)
                        .textTheme
                        .body1
                        .apply(color: Theme.of(context).hintColor),
                    prefixText: '¥',
                    prefixStyle: Theme.of(context).textTheme.subhead,
                  ),
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) =>
                      FocusScope.of(context).requestFocus(f3),
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
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    decoration: ShapeDecoration(
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                      width: 0.5,
                      color: Theme.of(context).dividerColor,
                    ))),
                    child: Text(
                        _taxThreshold == null
                            ? '请输入个税起征点'
                            : _taxThreshold.toString(),
                        style: _taxThreshold == null
                            ? Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Theme.of(context).hintColor)
                            : Theme.of(context).textTheme.subhead),
                  ),
                  onTap: () {
                    _showBottomSheet();
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text.rich(TextSpan(
                        style: Theme.of(context).textTheme.caption,
                        children: [
                          TextSpan(text: '2018年10月之前为'),
                          TextSpan(
                              text: '3500',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .apply(color: Colors.blue)),
                          TextSpan(text: '，2018年10月之后为'),
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
        padding:
            EdgeInsets.only(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                '是否缴纳社保公积金',
                style: Theme.of(context).textTheme.subhead,
              )),
              Switch(
                value: _switchValue,
                activeColor: Colors.blue,
                onChanged: (val) {
                  setState(() {
                    _switchValue = val;
                  });
                },
              ),
            ],
          ),
          Offstage(
            offstage: !_switchValue,
            child: Column(children: <Widget>[
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
                        InkWell(
                          child: Icon(Icons.info_outline,
                              size: 14.0, color: Colors.blue),
                          onTap: () => DialogTip.showSocialTip(context),
                        ),
                      ],
                    ),
                    TextFormField(
                      maxLines: 1,
                      focusNode: f3,
                      decoration: InputDecoration(
                        hintText: '请输入社保基数',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .body1
                            .apply(color: Theme.of(context).hintColor),
                        prefixText: '¥',
                        prefixStyle: Theme.of(context).textTheme.body1,
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
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
                        InkWell(
                          child: Icon(Icons.info_outline,
                              size: 14.0, color: Colors.blue),
                          onTap: () => DialogTip.showFundTip(context),
                        ),
                      ],
                    ),
                    TextFormField(
                      maxLines: 1,
                      focusNode: f4,
                      decoration: InputDecoration(
                        hintText: '请输入公积金基数',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .body1
                            .apply(color: Theme.of(context).hintColor),
                        prefixText: '¥',
                        prefixStyle: Theme.of(context).textTheme.body1,
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
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
    var enabled = false;
    if (_textEditController1.text.isNotEmpty &&
        _textEditController3.text.isNotEmpty &&
        _textEditController4.text.isNotEmpty) {
      enabled = true;
    } else {
      enabled = false;
    }
    setState(() {
      _btnCalculateEnabled = enabled;
    });
  }

  _checkSocial() {
    if (_switchValue) {
      if (_textEditController3.text.isNotEmpty) {
        int val = int.parse(_textEditController3.text);
        if (val < 3387 || val > 25401) {
          Fluttertoast.showToast(
            msg: '据北京的政策，社保缴纳范围:3387 - 25401',
          );
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  _checkFunds() {
    if (_switchValue) {
      if (_textEditController4.text.isNotEmpty) {
        int val = int.parse(_textEditController4.text);
        if (val < 2273 || val > 25401) {
          Fluttertoast.showToast(
            msg: '据北京的政策，公积金缴纳范围:2273 - 25401',
          );
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  //个人所得税=（工资－五险一金个人缴纳部分－免征额）×税率-速算扣除数
  _calculate() {
    //社保 养老8%，失业0.2%，医疗2%+3；(工伤和生育 个人不缴)
    num social = _socialSecurity * (0.08 + 0.002 + 0.02) + 3;
    social = _switchValue ? social : 0.0;
    social = num.parse(social.toStringAsFixed(2));

    //公积金
    num funds = _houseFunds * 0.12; //公积金 12%
    funds = _switchValue ? funds : 0.0;
    funds = num.parse(funds.toStringAsFixed(2));

    //应纳税所得额:（工资－五险一金个人缴纳部分－免征额）
    num taxAmount = _salaryBefore - social - funds - _taxThreshold;
    taxAmount <= 0
        ? taxAmount = 0.0
        : taxAmount = num.parse(taxAmount.toStringAsFixed(2));

    //对应税率
    TaxRate taxRate = TaxRate.whichTaxRate(taxAmount);

    //应缴税:应纳税所得额×税率-速算扣除数
    num tax = taxAmount * taxRate.rate - taxRate.quickDeduction;
    tax = num.parse(tax.toStringAsFixed(2));

    //税后所得:税前工资－五险-一金－缴税
    num salaryAfter = _salaryBefore - social - funds - tax;
    salaryAfter = num.parse(salaryAfter.toStringAsFixed(2));

    var salary = Salary(
      salaryBefore: _salaryBefore,
      salaryAfter: salaryAfter,
      social: social,
      funds: funds,
      taxAmount: taxAmount,
      tax: tax,
      taxThreshold: _taxThreshold,
      taxRate: taxRate,
    );
    print('salary:$salary');

    //检查税前工资是否足以缴纳社保公积金
    if (_salaryBefore < social + funds) {
      Fluttertoast.showToast(msg: '你的税前工资还不足以缴纳社保公积金？加油吧，兄嘚！');
      return;
    }

    Navigator.of(context).push(SlidePageRouter().pageBuilder(ResultPage(
      title: '税后工资',
      salary: salary,
    )));
  }

  _onSubmit() {
    final form = _formKey.currentState;
    if (_checkSocial() && _checkFunds() && form.validate()) {
      form.save();
      _calculate();
    }
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 0.0, bottom: 16.0),
//            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  heightFactor: 2.5,
                  child: Text('请选择个税起征点'),
                ),
                Divider(
                  height: 1.0,
                ),
                new SimpleDialogOption(
                    child: Container(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      width: double.infinity,
                      child: Text(
                        '3500元',
                        style: Theme.of(context).textTheme.subhead,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _taxThreshold = 3500;
                      });
                      Navigator.of(context).pop(true);
                    }),
                new SimpleDialogOption(
                    child: Container(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      width: double.infinity,
                      child: Text(
                        '4800元',
                        style: Theme.of(context).textTheme.subhead,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _taxThreshold = 4800;
                      });
                      Navigator.of(context).pop(true);
                    }),
                new SimpleDialogOption(
                    child: Container(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      width: double.infinity,
                      child: Text(
                        '5000元',
                        style: Theme.of(context).textTheme.subhead,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _taxThreshold = 5000;
                      });
                      Navigator.of(context).pop(true);
                    }),
              ],
            ),
          );
        });
  }
}
