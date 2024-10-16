import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleSearch() {
    final term = controller.text;
    widget.onSearch(term);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            elevation: 4.0, // Define a elevação do Card

            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      style: const TextStyle(fontSize: 12.0),
                      onSubmitted: (_) => handleSearch(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed:
                        handleSearch, // Chama a função ao clicar no ícone de pesquisa
                  ),
                ],
              ),
            )));
  }
}
