import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThreeDateInputFields extends StatefulWidget {
  final Function(String day, String month, String year)? onChanged;
  final String? initialDay;
  final String? initialMonth;
  final String? initialYear;

  const ThreeDateInputFields({
    Key? key,
    this.onChanged,
    this.initialDay,
    this.initialMonth,
    this.initialYear,
  }) : super(key: key);

  @override
  State<ThreeDateInputFields> createState() => _ThreeDateInputFieldsState();
}

class _ThreeDateInputFieldsState extends State<ThreeDateInputFields> {
  late TextEditingController _dayController;
  late TextEditingController _monthController;
  late TextEditingController _yearController;

  late FocusNode _dayFocusNode;
  late FocusNode _monthFocusNode;
  late FocusNode _yearFocusNode;

  @override
  void initState() {
    super.initState();
    _dayController = TextEditingController(text: widget.initialDay ?? '');
    _monthController = TextEditingController(text: widget.initialMonth ?? '');
    _yearController = TextEditingController(text: widget.initialYear ?? '');

    _dayFocusNode = FocusNode();
    _monthFocusNode = FocusNode();
    _yearFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _dayFocusNode.dispose();
    _monthFocusNode.dispose();
    _yearFocusNode.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(
        _dayController.text,
        _monthController.text,
        _yearController.text,
      );
    }
  }

  bool _isValidDate(String day, String month, String year) {
    if (day.isEmpty || month.isEmpty || year.isEmpty) return false;
    try {
      final d = int.parse(day);
      final m = int.parse(month);
      final y = int.parse(year);

      // Limit day and month ranges
      if (d < 1 || d > 31) return false;
      if (m < 1 || m > 12) return false;
      if (y < 1000) return false;

      // Check valid day in month considering leap years
      final date = DateTime(y, m, d);
      return date.day == d && date.month == m && date.year == y;
    } catch (_) {
      return false;
    }
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String placeholder,
    required int maxLength,
    FocusNode? nextFocusNode,
  }) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLength),
          TextInputFormatter.withFunction((oldValue, newValue) {
            final v = int.tryParse(newValue.text);

            if (controller == _dayController) {
              if (newValue.text.length == 2 && (v == null || v < 1 || v > 31)) {
                return oldValue;
              }
            }
            if (controller == _monthController) {
              if (newValue.text.length == 2 && (v == null || v < 1 || v > 12)) {
                return oldValue;
              }
            }
            return newValue;
          }),
        ],
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
          isDense: true,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
          counterText: '',
        ),
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
        onChanged: (value) {
          _onFieldChanged();

          // Auto-move to next field when max length is reached
          if (value.length == maxLength && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
        validator: (value) {
          if (!_isValidDate(
            _dayController.text,
            _monthController.text,
            _yearController.text,
          )) {
            return 'Invalid date';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          _buildDateField(
            controller: _dayController,
            focusNode: _dayFocusNode,
            placeholder: 'dd',
            maxLength: 2,
            nextFocusNode: _monthFocusNode,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              '/',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          _buildDateField(
            controller: _monthController,
            focusNode: _monthFocusNode,
            placeholder: 'mm',
            maxLength: 2,
            nextFocusNode: _yearFocusNode,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              '/',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          _buildDateField(
            controller: _yearController,
            focusNode: _yearFocusNode,
            placeholder: 'yyyy',
            maxLength: 4,
          ),
        ],
      ),
    );
  }
}
