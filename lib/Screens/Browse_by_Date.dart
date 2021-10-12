import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/Widgets/task_by_Date_item_List.dart';
import 'package:table_calendar/table_calendar.dart';

class BrowseTaskByDate extends StatefulWidget {

  @override
  _BrowseTaskByDateState createState() => _BrowseTaskByDateState();
}

class _BrowseTaskByDateState extends State<BrowseTaskByDate> {

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/home_back.jpg'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Color(0x22FFFFFF),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Browse ToDo\'s by Date',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 27),
            ),
            backgroundColor: Color.fromRGBO(50, 69, 88,1),
            elevation: 50.0,
          ),
          body: Column(
              children: [
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      color: Colors.white.withOpacity(0.8),

                      child: TableCalendar(
                      firstDay: DateTime(DateTime.now().year-2),
                      lastDay: DateTime(2220),
                      focusedDay: DateTime.now(),

                        headerStyle: HeaderStyle(
                          decoration: BoxDecoration(color: Color.fromRGBO(
                              50, 69, 88, 0.7),),
                          titleCentered: true,
                          titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 27),
                          formatButtonShowsNext: false,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          formatButtonTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        ),

                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: true,
                          selectedDecoration: BoxDecoration(
                            color: Colors.pink,
                            shape: BoxShape.circle,
                          ),

                        selectedTextStyle: TextStyle(color: Colors.white),
                        todayDecoration: BoxDecoration(
                          color: Color.fromRGBO(50, 69, 88,1),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        ),

                        calendarFormat: format,
                        onFormatChanged: (CalendarFormat _currentformat) {
                          setState(() {
                            format = _currentformat;
                          });
                        },

                        onDaySelected: (_currentSelectedDay, _currentFocusedDay) {
                          setState(() {
                            selectedDay=_currentSelectedDay;
                            focusedDay=_currentFocusedDay;// update `_focusedDay` here as well
                          });
                        },

                        selectedDayPredicate: (DateTime _currDate) {
                          return isSameDay(selectedDay, _currDate);
                        },

                    ),
                    ),
        Padding(padding: EdgeInsets.only(top: 10,left: 20,right: 20),
            child: Container(
              color: Colors.orangeAccent.withOpacity(0.5),
              height: 50,
              width: 50,
              child: task_by_Date_item_List(currSelectedDate: selectedDay,),
            ),
          ),

              ],),
          ),
      ),
    );
  }
}

