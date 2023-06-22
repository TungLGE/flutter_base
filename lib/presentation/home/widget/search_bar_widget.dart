import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearch;
  final FocusNode? focusNode;
  final bool loading;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    this.focusNode,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.white,
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, color: Colors.black38),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search your city',
                hintStyle: TextStyle(color: Colors.black26),
              ),
              maxLines: 1,
              onChanged: (newText) {
                onSearch.call(newText);
              },
              focusNode: focusNode,
            ),
          ),
          if (loading) ...[
            const SizedBox(width: 8),
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
