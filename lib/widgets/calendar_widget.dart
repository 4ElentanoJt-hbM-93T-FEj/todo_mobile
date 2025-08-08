import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends ConsumerStatefulWidget {
  // final CalendarViewModel? vm;
  const CalendarWidget({
    super.key,
  });

  @override
  ConsumerState<CalendarWidget> createState() => _MkCalendarWidgetState();
}

class _MkCalendarWidgetState extends ConsumerState<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 1),
            color: Color(0x0D000000),
            blurRadius: 5,
          ),
          BoxShadow(
            offset: Offset(8, 4),
            color: Color(0x0A000000),
            blurRadius: 9,
          ),
        ],
      ),
      child: Column(
        children: [
          // Заголовок с месяцем и годом
          buildHeader(),
          const SizedBox(height: 15),
          // Дни недели
          buildWeekDays(),
          // Ячейки календаря
          buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.chevron_left),
        Text(
          "Month",
          // '${getMonthName(ref.read(calendarEventsViewProvider).selectedDate!.month)} ${ref.read(calendarEventsViewProvider).selectedDate!.year}',
          style: const TextStyle(
            fontSize: 14,
            fontFamily: "Pt-Sans",
            fontWeight: FontWeight.w600,
            // color: ,
          ),
        ),
        const Icon(Icons.chevron_right),
      ],
    );
  }

  void changeMonth(int offset, {DateTime? nextDate}) async {
    // ref.read(calendarEventsViewProvider.notifier).clear();
    // ref.read(calendarEventsViewProvider.notifier).changeMonth(
    //       offset: offset,
    //       nextDate: nextDate!,
    //     );
  }

  // Генератор дней недели, добавить локализацию
  Widget buildWeekDays() {
    const weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return Row(
      children: [
        for (var day in weekDays) ...[
          Expanded(
            child: Center(
              child: Text(
                day,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 153, 161, 183),
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }

  Widget buildCalendarGrid() {
    // final DateTime firstDayOfMonth = DateTime(
    //     ref.read(calendarEventsViewProvider).selectedDate!.year,
    //     ref.read(calendarEventsViewProvider).selectedDate!.month,
    //     1);
    // final int daysInMonth = DateTime(
    //         ref.read(calendarEventsViewProvider).selectedDate!.year,
    //         ref.read(calendarEventsViewProvider).selectedDate!.month + 1,
    //         0)
    //     .day;

    final DateTime firstDayOfMonth = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      1,
    );
    final int daysInMonth = DateTime(
      DateTime.now().year,
      DateTime.now().month + 1,
      0,
    ).day;

    // День недели начала месяца
    final int startingWeekday = firstDayOfMonth.weekday;

    return Stack(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            // mainAxisExtent: 40,
            childAspectRatio: 0.8,
            // crossAxisSpacing: 20,
            // mainAxisSpacing: 20,
          ),
          // Пропуск дней прошлого месяца
          itemCount: daysInMonth + startingWeekday - 1,
          itemBuilder: (context, index) {
            if (index < startingWeekday - 1) {
              // Пустые ячейки в начале
              return const SizedBox();
            }

            final int day = index - startingWeekday + 2;
            // новая выбранная дата
            final DateTime date = DateTime(
              DateTime.now().year,
              DateTime.now().month + 1,
              DateTime.now().day,
            );

            return GestureDetector(
              // onTap: () => ref
              //     .read(calendarEventsViewProvider.notifier)
              //     .selectDate(date),
              child: Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  // color: isSelectDay(date,
                  //         ref.read(calendarEventsViewProvider).currentDate!)
                  //     ? UIColors.background_container_blue_rating
                  //     : isSelectDay(
                  //                 date,
                  //                 ref
                  //                     .read(calendarEventsViewProvider)
                  //                     .selectedDate!) &&
                  //             ref.read(calendarEventsViewProvider).isSelectDate!
                  //         ? UIColors.background_container_blue_rating
                  //         : Colors.transparent,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                  border: Border.all(
                    width: 1,
                    // color: isSelectDay(
                    //             date,
                    //             ref
                    //                 .read(calendarEventsViewProvider)
                    //                 .selectedDate!) &&
                    //         ref.read(calendarEventsViewProvider).isSelectDate!
                    //     ? UIColors.active_element
                    //     : Colors.transparent,
                  ),
                ),
                child: SizedBox(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          day.toString(),
                          style: TextStyle(
                            // color: isSelectDay(
                            //         date,
                            //         ref
                            //             .read(calendarEventsViewProvider)
                            //             .currentDate!)
                            //     ? UIColors.active_element
                            //     : UIColors.back_bth_title,
                            fontSize: 14,
                            fontFamily: "Pt-Sans",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: getEvents(widget.vm, date),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // ref.read(calendarEventsViewProvider).current! ==
        //         CalendarViewModelStatus.loading
        //     ? const Center(
        //         child: MTCircleProgressIndicator(),
        //       )
        //     : const SizedBox()
      ],
    );
  }

  String getMonthName(int month) {
    const months = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь'
    ];
    return month > 0 ? months[month - 1] : "";
  }

  bool isSelectDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

//   Widget getEvents(CalendarViewModel? vm, DateTime currentDay) {
//     // int count = 0;
//     // int countTraining = 0;
//     // var eventsList = ref.read(calendarEventsViewProvider.notifier).eventsList;
//     // String trainingStatus = "";

//     // // Инициализация дня в eventsList если его нет
//     // var needInsertEvents = !eventsList.containsKey(currentDay);
//     // if (needInsertEvents) {
//     //   eventsList[currentDay] = {
//     //     'events': [],
//     //     'trainings': [],
//     //     'performance_review': [],
//     //     'meetings': [],
//     //     'birthdays': [],
//     //     "end_probation_day": [],
//     //     "locations": [],
//     //   };
//     // }

//     // // Функция для преобразования даты из timestamp
//     // DateTime parseBirthdayDate(int timestamp) {
//     //   return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//     // }

//     // // Функция для парсинга даты из строки формата "dd.MM.yyyy"
//     // DateTime parsePerfomanceReviewDate(String dateStr) {
//     //   DateFormat format = DateFormat("dd.MM.yyyy HH:mm");
//     //   DateTime result = format.parse(dateStr);
//     //   return result;
//     // }

//     // // Функция для проверки совпадения дня (без учета времени)
//     // bool isSameDay(DateTime date1, DateTime date2) {
//     //   return date1.year == date2.year &&
//     //       date1.month == date2.month &&
//     //       date1.day == date2.day;
//     // }

//     // // Функция для проверки вхождения текущего дня в диапазон события
//     // bool isInEventRange(DateTime current, DateTime? start, DateTime? end) {
//     //   if (start == null || end == null) return false;
//     //   final currentDate = DateTime(current.year, current.month, current.day);
//     //   final startDate = DateTime(start.year, start.month, start.day);
//     //   final endDate = DateTime(end.year, end.month, end.day);

//     //   return (currentDate.isAfter(startDate) ||
//     //           currentDate.isAtSameMomentAs(startDate)) &&
//     //       (currentDate.isBefore(endDate) ||
//     //           currentDate.isAtSameMomentAs(endDate));
//     // }

//     // // Обработка обычных событий
//     // for (Event event in vm?.data?.data?.events ?? []) {
//     //   if (isInEventRange(currentDay, event.startDate, event.endDate)) {
//     //     if (needInsertEvents) {
//     //       eventsList[currentDay]!['events']!.add(event);
//     //     }
//     //     count++;
//     //   }
//     // }

//     // // Обработка тренингов
//     // for (Trainings training in vm?.data?.data?.trainings ?? []) {
//     //   try {
//     //     final startDate =
//     //         DateFormat('dd.MM.yyyy').parse(training.startDateFormat!);
//     //     final endDate = DateFormat('dd.MM.yyyy').parse(training.endDateFormat!);

//     //     if (isInEventRange(currentDay, startDate, endDate)) {
//     //       if (needInsertEvents) {
//     //         eventsList[currentDay]!['trainings']!.add(training);
//     //       }
//     //       countTraining++;
//     //       trainingStatus = training.status!.code!;
//     //     }
//     //   } catch (e) {
//     //     debugPrint('Error parsing training date: $e');
//     //   }
//     // }

//     // // Обработка дней рождений
//     // for (Birthday birthday in vm?.data?.data?.birthdays ?? []) {
//     //   final birthdayDate = parseBirthdayDate(birthday.date!);
//     //   if (isSameDay(currentDay, birthdayDate)) {
//     //     if (needInsertEvents) {
//     //       eventsList[currentDay]!['birthdays']!.add(birthday);
//     //     }
//     //     count++;
//     //   }
//     // }

//     // // Обработка дней окончания испытательного срока
//     // for (final probationDay in vm?.data?.data?.endProbationDays ?? []) {
//     //   final probationDate = parseBirthdayDate(probationDay.date!);
//     //   if (isSameDay(currentDay, probationDate)) {
//     //     if (needInsertEvents) {
//     //       eventsList[currentDay]!['end_probation_day']!.add(probationDay);
//     //     }
//     //     count++;
//     //   }
//     // }

//     // for (Location location in vm?.data?.data?.locations ?? []) {
//     //   try {
//     //     final startDate = location.startDate;
//     //     final endDate = location.endDate;
//     //     if (isInEventRange(currentDay, startDate, endDate)) {
//     //       if (needInsertEvents) {
//     //         eventsList[currentDay]!['locations']!.add(location);
//     //       }
//     //       count++;
//     //     }
//     //   } catch (e) {
//     //     debugPrint('Error parsing date: $e');
//     //   }
//     // }

//     // for (PerformanceReview perfomanceReview
//     //     in vm?.data?.data?.performanceReviews ?? []) {
//     //   final probationDate =
//     //       parsePerfomanceReviewDate(perfomanceReview.startDateFormat ?? "");
//     //   if (isSameDay(currentDay, probationDate)) {
//     //     if (needInsertEvents) {
//     //       eventsList[currentDay]!['performance_review']!.add(perfomanceReview);
//     //     }
//     //     count++;
//     //   }
//     // }

//     // Отображение счетчика событий
//     return (count + countTraining) > 0
//         ? Row(
//             mainAxisAlignment: countTraining != 0
//                 ? MainAxisAlignment.spaceAround
//                 : MainAxisAlignment.center,
//             children: [
//               if (countTraining != 0) ...[
//                 // ожидание
//                 if (trainingStatus == "published") ...[
//                   SvgPicture.asset("assets/Icons/Achievements/waiting.svg"),
//                 ] else if (trainingStatus == "cancel") ...[
//                   SvgPicture.asset("assets/Icons/HomePage/Failed.svg"),
//                 ] else if (trainingStatus == "completed") ...[
//                   SizedBox(
//                     width: 15,
//                     height: 15,
//                     child: SvgPicture.asset(
//                         "assets/Icons/HomePage/CompletedAnswer.svg"),
//                   ),
//                 ],
//               ],
//               // Здесь можно добавить иконку тренинга
//               Container(
//                 margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                 padding: const EdgeInsets.all(4),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color.fromARGB(184, 212, 221, 233),
//                 ),
//                 child: Center(
//                   child: Text(
//                     (count + countTraining).toString(),
//                     style: const TextStyle(
//                       fontFamily: 'Pt-Sans',
//                       fontSize: 9,
//                       color: Color.fromARGB(255, 29, 29, 29),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           )
//         : const SizedBox();
//   }
}
