import 'package:flutter/material.dart';

class DateInput extends StatefulWidget {
  final String title;
  final bool isDisbursed;
  final TextEditingController dateController;
  const DateInput({super.key, required this.title, required this.isDisbursed, required this.dateController});

  @override
  // ignore: library_private_types_in_public_api
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {

  @override
  void dispose() {
    widget.dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: widget.isDisbursed ? now : DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        widget.dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.dateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: widget.title,
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
