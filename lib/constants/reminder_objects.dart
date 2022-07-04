const List<Map<String, dynamic>> quickMins = <Map<String, dynamic>>[
  {'name': '1 minute', 'value': Duration(minutes: 1)},
  {'name': '5 minutes', 'value': Duration(minutes: 5)},
  {'name': '10 minutes', 'value': Duration(minutes: 10)},
  {'name': '15 minutes', 'value': Duration(minutes: 15)},
  {'name': '20 minutes', 'value': Duration(minutes: 20)},
  {'name': '25 minutes', 'value': Duration(minutes: 25)},
  {'name': '30 minutes', 'value': Duration(minutes: 30)},
  {'name': '35 minutes', 'value': Duration(minutes: 35)},
  {'name': '40 minutes', 'value': Duration(minutes: 40)},
  {'name': '45 minutes', 'value': Duration(minutes: 45)},
  {'name': '50 minutes', 'value': Duration(minutes: 50)},
  {'name': '55 minutes', 'value': Duration(minutes: 55)},
  {'name': '1 hour', 'value': Duration(hours: 1)},
  {'name': '2 hours', 'value': Duration(hours: 2)},
  {'name': '5 hours', 'value': Duration(hours: 5)},
  {'name': '12 hours', 'value': Duration(hours: 12)},
  {'name': '1 day', 'value': Duration(days: 1)},
  {'name': '2 day', 'value': Duration(days: 2)},
];

const List<Map<String, dynamic>> days = <Map<String, dynamic>>[
  {'name': 'Sun', 'value': false},
  {'name': 'Mon', 'value': false},
  {'name': 'Tue', 'value': false},
  {'name': 'Wed', 'value': false},
  {'name': 'Thu', 'value': false},
  {'name': 'Fri', 'value': false},
  {'name': 'Sat', 'value': false},
];

const Map<String, int> weekDaysValue = <String, int>{
  'Mon': 1,
  'Tue': 2,
  'Wed': 3,
  'Thu': 4,
  'Fri': 5,
  'Sat': 6,
  'Sun': 7,
};

const List<Map<String, dynamic>> repeat = <Map<String, dynamic>>[
  {'name': 'Once', 'desc': 'Once'},
  {'name': 'Daily', 'desc': 'Every day'},
  {'name': 'Weekly', 'desc': 'Every'},
  {'name': 'Monthly', 'desc': 'Every month'},
  {'name': 'Yearly', 'desc': 'Every year'},
];
