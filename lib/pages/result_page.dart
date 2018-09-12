import 'package:flutter/material.dart';
import 'package:flutter_calculate/models/salary.dart';

class ResultPage extends StatefulWidget {
  final String title;
  final Salary salary;

  ResultPage({Key key, this.title, this.salary}) : super(key: key);

  @override
  _ResultPageState createState() => new _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
                  padding: EdgeInsets.all(16.0),
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
              Divider(
                height: 1.0,
                indent: 16.0,
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _rectDot(color: Color(0xff0c83ff)),
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
                      _rectDot(color: Color(0xff81c7fb)),
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
                      _rectDot(color: Color(0xffb5ddfa)),
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
                      _rectDot(color: Color(0xffe1f2fd)),
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
      ],
    );
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
