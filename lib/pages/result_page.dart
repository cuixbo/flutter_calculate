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
        Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('税前工资：'),
                Expanded(
                  child: Text(
                    '${widget.salary.salaryBefore}元',
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            )),
        Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('税后工资：'),
                Expanded(
                  child: Text(
                    '${widget.salary.salaryAfter}元',
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            )),
        Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('社保缴纳(个人)：'),
                Expanded(
                  child: Text(
                    '${widget.salary.social}元',
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            )),
        Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('公积金缴纳(个人)：'),
                Expanded(
                  child: Text(
                    '${widget.salary.funds}元',
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            )),
        Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('个税缴纳：'),
                Expanded(
                  child: Text(
                    '${widget.salary.tax}元',
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            )),
      ],
    );
  }
}
