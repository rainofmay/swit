import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swit/shared/constant/color_box.dart';
import 'package:swit/shared/constant/font_box.dart';
import 'package:swit/shared/constant/icon_size.dart';
import 'package:swit/shared/widgets/custom_gap.dart';

class StudyLogCard extends StatefulWidget {
  final String initialContent;
  final Duration initialStudyTime;
  final DateTime createdAt;
  final Function(String, Duration) onSave;

  const StudyLogCard({
    super.key,
    this.initialContent = '',
    this.initialStudyTime = Duration.zero,
    required this.createdAt,
    required this.onSave,
  });

  @override
  State<StudyLogCard> createState() => _EditableStudyJournalCardState();
}

class _EditableStudyJournalCardState extends State<StudyLogCard> {
  late TextEditingController _contentController;
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.initialContent);
    _hoursController = TextEditingController(text: widget.initialStudyTime.inHours.toString());
    _minutesController = TextEditingController(text: (widget.initialStudyTime.inMinutes % 60).toString());
  }

  @override
  void dispose() {
    _contentController.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isEditing) {
          final hours = int.tryParse(_hoursController.text) ?? 0;
          final minutes = int.tryParse(_minutesController.text) ?? 0;
          final studyTime = Duration(hours: hours, minutes: minutes);
          widget.onSave(_contentController.text, studyTime);
        }
        setState(() {
          _isEditing = !_isEditing;
        });
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: ColorBox.white,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: ColorBox.primaryColor, width: 4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isEditing) ...[
                  TextField(
                    controller: _contentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: '공부 내용을 입력하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _hoursController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '시간',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _minutesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '분',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Text(
                    _contentController.text,
                    style: FontBox.H5,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const CustomGap(12),
                  Row(
                    children: [
                      Icon(CupertinoIcons.clock, size: IconSize.xs, color: ColorBox.black),
                      const CustomGap(4),
                      Text(
                        '공부시간: ${_formatDuration()}',
                        style: FontBox.B2,
                      ),
                    ],
                  ),
                ],
                const CustomGap(8),
                _isEditing ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  TextButton(onPressed: () {}, child: Text('수정')),
                  TextButton(onPressed: () {}, child: Text('삭제')),
                ],) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration() {
    final hours = int.tryParse(_hoursController.text) ?? 0;
    final minutes = int.tryParse(_minutesController.text) ?? 0;
    return '${hours}시간 ${minutes}분';
  }
}