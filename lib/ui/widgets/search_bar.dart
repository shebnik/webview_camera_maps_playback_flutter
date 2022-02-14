import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.back,
    required this.forward,
    required this.refresh,
    required this.loadPage,
    required this.textFieldController,
    required this.canGoBack,
    required this.canGoForward,
    required this.isLoading,
  }) : super(key: key);

  final void Function() back;
  final void Function() forward;
  final void Function() refresh;
  final void Function(String) loadPage;
  final TextEditingController textFieldController;
  final bool canGoBack;
  final bool canGoForward;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 60,
      child: Row(
        children: [
          IconButton(
            onPressed: canGoBack ? back : null,
            icon: const Icon(Icons.arrow_back_outlined),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          IconButton(
            onPressed: canGoForward ? forward : null,
            icon: const Icon(Icons.arrow_forward_outlined),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          IconButton(
            onPressed: refresh,
            icon: isLoading
                ? const Icon(Icons.clear_outlined)
                : const Icon(Icons.refresh_outlined),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDD9D4),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: TextField(
                  controller: textFieldController,
                  textInputAction: TextInputAction.go,
                  onSubmitted: loadPage,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10.0,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () => textFieldController.text = '',
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
