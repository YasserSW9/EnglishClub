import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String? value;
  final String hintText;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? errorText;

  const CustomDropdownField({
    super.key,
    this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: const Color(0xFF673AB7), width: 1.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              hint: _buildHintText(),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),

              selectedItemBuilder: (BuildContext context) {
                return items.map((String item) {
                  if (value == null) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: _buildHintText(),
                    );
                  }

                  return Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$hintText: ',
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: item,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList();
              },

              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12.0),
            ),
          ),
      ],
    );
  }

  Widget _buildHintText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$hintText: ',
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          const TextSpan(
            text: 'SELECT',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
