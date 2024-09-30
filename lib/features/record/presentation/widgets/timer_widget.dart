import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _result = "00:00:00";
  List<int> _records = [];
  int _sum = 0;
  bool _isRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _pauseTimer();
      } else {
        _startTimer();
      }
      _isRunning = !_isRunning;
    });
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        _result = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    });
  }

  void _pauseTimer() {
    _stopwatch.stop();
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _stopwatch.reset();
      _timer?.cancel();
      _result = "00:00:00";
      _isRunning = false;
    });
  }

  void _recordTime() {
    if (!_stopwatch.isRunning) {
      setState(() {
        _records.add(_stopwatch.elapsedMilliseconds);
        _updateSum();
      });
    }
  }

  void _updateSum() {
    _sum = _records.reduce((value, element) => value + element);
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  Widget _buildTimeDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _result.split('').map((char) {
        return Container(
          width: char == ':' ? 22 : 38, // 콜론은 더 좁게
          alignment: Alignment.center,
          child: Text(
            char,
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: ColorBox.switchColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ColorBox.secondColor,
            ),
            child: Column(
              children: [
                _buildTimeDisplay(),
                const CustomGap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _toggleTimer,
                      child: Text(_isRunning ? '일시 정지' : '바로 시작'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isRunning ? Colors.orange : Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                    const CustomGap(16),
                    ElevatedButton(
                      onPressed: _resetTimer,
                      child: Text('리셋'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    const CustomGap(16),
                    ElevatedButton(
                      onPressed: _recordTime,
                      child: Text('기록'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text('오늘 공부한 시간'),
          SizedBox(height: 20),
          Text('기록된 시간:'),
          Container(
            height: 100,
            child: ListView.builder(
              itemCount: _records.length,
              itemBuilder: (context, index) {
                return Text(_formatTime(_records[index]));
              },
            ),
          ),
          Text('합계: ${_formatTime(_sum)}'),
        ],
      ),
    );
  }
}