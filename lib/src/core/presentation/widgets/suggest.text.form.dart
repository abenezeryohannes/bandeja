import 'package:flutter/material.dart';

class SuggestTextForm<T extends Object> extends StatefulWidget {
  const SuggestTextForm(
      {Key? key,
      this.value,
      required this.onChange,
      required this.options,
      required this.label,
      this.placeholder,
      required this.radius,
      required this.elevation,
      this.validator,
      required this.search})
      : super(key: key);
  final List<Map<String, T>> options;
  final T? value;
  final String? Function(T)? validator;
  final double radius;
  final Function({String search}) search;
  final double elevation;
  final Function(String key, T? value) onChange;

  final String label;
  final String? placeholder;

  @override
  State<SuggestTextForm> createState() => _SuggestTextFormState<T>();
}

class _SuggestTextFormState<T extends Object> extends State<SuggestTextForm> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
      child: Autocomplete<T>(
        optionsBuilder: (TextEditingValue textEditingValue) async {
          // FutureOr<Iterable<T>>;
          if (textEditingValue.text == '') {
            return Iterable<T>.empty();
          }
          return (await widget.search(
                  search: textEditingValue.text.toLowerCase()))
              .where((element) => true);
        },
        displayStringForOption: (T option) => getKey(widget.options) ?? '',
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
        },
        initialValue: TextEditingValue(text: getKey(widget.value) ?? ''),
        onSelected: (Object? selection) {
          widget.onChange(getKey(selection) ?? '', selection);
          // print('Selected: ${getKey(selection)}');
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              child: Container(
                width: 300,
                color: Colors.cyan,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final T option = options.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(getKey(option) ?? '',
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String? getKey(Object? value) {
    if (value == null) return widget.placeholder;
    try {
      return widget.options
          .firstWhere((element) => element.containsValue(value))
          .keys
          .first;
    } on Exception {
      return widget.placeholder;
    }
  }
}
