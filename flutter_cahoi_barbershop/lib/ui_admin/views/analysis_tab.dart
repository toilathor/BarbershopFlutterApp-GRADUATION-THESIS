import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnalysisTab extends StatefulWidget {
  const AnalysisTab({Key? key}) : super(key: key);

  @override
  State<AnalysisTab> createState() => _AnalysisTabState();
}

class _AnalysisTabState extends State<AnalysisTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Analysis')
    );
  }
}
