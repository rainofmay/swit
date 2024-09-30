import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditableStudyJournalCard extends StatefulWidget {
  final String initialContent;
  final Duration initialStudyTime;
  final DateTime createdAt;
  final Function(String, Duration) onSave;

  const EditableStudyJournalCard({
    super.key,
    this.initialContent = '',
    this.initialStudyTime = Duration.zero,
    required this.createdAt,
    required this.onSave,
  });

  @override
  _EditableStudyJournalCardState createState() => _EditableStudyJournalCardState();
}

class _EditableStudyJournalCardState extends State<EditableStudyJournalCard> {
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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xFFFAF6E1),
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
                style: TextStyle(fontSize: 16),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                '공부시간: ${_formatDuration()}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy.MM.dd').format(widget.createdAt),
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                TextButton(
                  onPressed: () {
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
                  child: Text(_isEditing ? '저장' : '수정'),
                ),
              ],
            ),
          ],
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