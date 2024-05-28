import 'package:flutter/cupertino.dart';

class localData extends StatefulWidget {
  const localData({super.key});

  @override
  State<localData> createState() => _localDataState();
}

class _localDataState extends State<localData> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Local Data Page"
    );
  }
}