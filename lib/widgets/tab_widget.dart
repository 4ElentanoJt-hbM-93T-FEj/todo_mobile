import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  TabWidget({
    super.key,
    this.labels,
    this.selected,
  });

  List<String>? labels = [];
  int? selected = 0;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      height: 50,
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 49, 24, 99),
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Row(
        children: [
          for (int i = 0; i < (widget.labels ?? []).length; i++) ...[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selected = i;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.selected == i
                        ? const Color.fromARGB(255, 128, 104, 175)
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.labels![i],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
