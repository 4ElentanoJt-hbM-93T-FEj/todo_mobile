import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/calendar_widget.dart';
import 'package:to_do_app/widgets/tab_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          decoration: selected == 0
              ? const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 42, 42, 46),
                      Color.fromARGB(255, 43, 18, 90),
                      Color.fromARGB(255, 0, 0, 0),
                    ],
                  ),
                )
              : const BoxDecoration(),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TO. DO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.more_vert_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),

              // ToDo: Tabs
              const SizedBox(
                height: 44,
              ),
              TabWidget(
                selected: selected,
                labels: const [
                  "Календарь",
                  "Заметки",
                ],
              ),

              // ToDo: Calendar
              CalendarWidget(),
              // ToDo: Cards
            ],
          ),
        ),
      ),
    );
  }
}
