import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';

class FilterWidget {
  const FilterWidget(this.choice);

  final String choice;
}

class SearchFilter extends StatefulWidget {
  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  List<FilterWidget> _filters;
  List<String> _choices;

  @override
  void initState() {
    super.initState();
    _choices = <String>[];
    _filters = <FilterWidget>[
      FilterWidget('기술 스택'),
      FilterWidget('잔여 포지션'),
      FilterWidget('활동 기간'),
    ];
  }

  Iterable<Widget> get filterChoices sync* {
    for (FilterWidget filter in _filters) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          backgroundColor: Colors.grey[200],
          side: BorderSide(
            color: Colors.black45, width: 0.5
          ),
          label: Text(
            filter.choice,
          ),
          selected: _choices.contains(filter.choice),
          selectedColor: Colors.green[300],
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _choices.add(filter.choice);
                /* 각 필터별 세부 선택지 컨테이너 표출 */
              } else {
                _choices.removeWhere((String choice) {
                  return choice == filter.choice;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Wrap(children: filterChoices.toList()),
    ]);
  }
}
