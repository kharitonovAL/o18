import 'package:flutter/material.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/helper/helper.dart';

class AddReadingsPage extends StatefulWidget {
  final List<Counter> counterList;

  const AddReadingsPage({
    required this.counterList,
  });

  @override
  _AddReadingsPage createState() => _AddReadingsPage();
}

class _AddReadingsPage extends State<AddReadingsPage> {
  List<TextEditingController> textEditingControllerList = [];
  List<Counter> counterList = [];
  List<TextFormField> textFormFieldList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // when user go to AddReadingsPage, and then go back to CountersPage
    // by pressing back button, and then again go to AddReadingsPage,
    // `counterList` and `textEditingControllerList` will have extra counter in it.
    // so we have to clear them befor init.
    counterList.clear();
    textEditingControllerList.clear();
    textFormFieldList.clear();

    // create local list of counters
    counterList = widget.counterList;

    if (counterList.any((counter) => counter.serviceTitle == 'Электроснабжение')) {
      // if there is electric counter, then we create it's copy and insert it at index 1
      counterList.insert(1, counterList.first);
    }

    textEditingControllerList = _createTextEditingControllerList();
    textFormFieldList = _generateTextFormFields();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Текущие показания'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: textFormFieldList,
              ),
              const SizedBox(height: 16),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        child: const Text('Подать показания'),
                        onPressed: () async {
                          setState(() => _isLoading = true);

                          if (textEditingControllerList.any((controller) => controller.text.isEmpty)) {
                            setState(() => _isLoading = false);

                            showAlert(
                              title: 'Внимание!',
                              content: 'Заполните все показания приборов!',
                              context: context,
                            );
                          } else {
                            for (var i = 0; i < counterList.length; i++) {
                              // if this counter is electric counter, then second TextEditingController is for it,
                              // and we also check that night readings have to be more then last
                              if (counterList.any((counter) => counter.serviceTitle == 'Электроснабжение') && i == 1) {
                                final nightReadingList = counterList[i].nightReadingList;

                                if (nightReadingList != null) {
                                  final list = nightReadingList.map((dynamic e) => double.parse('$e')).toList();
                                  final lastReading = list.last;

                                  if (lastReading > double.parse(textEditingControllerList[i].text.trim())) {
                                    setState(() => _isLoading = false);

                                    showAlert(
                                      title: 'Внимание!',
                                      content: 'Новые показания не могут быть меньше предыдущих!',
                                      context: context,
                                    );
                                    return;
                                  }
                                }

                                if (textEditingControllerList[i].text.trim().isNotEmpty) {
                                  // adding night reading from second TextEditingController
                                  counterList[i].setAdd(Counter.keyNightReadingList,
                                      double.parse(textEditingControllerList[i].text.trim()));
                                  counterList[i].currentNightReading =
                                      double.parse(textEditingControllerList[i].text.trim());
                                } else {
                                  // if there is no current reading for nightReadingList, set `0` as default value
                                  counterList[i].setAdd(Counter.keyNightReadingList, 0.0);
                                  counterList[i].currentNightReading = 0.0;
                                }
                                // need await for update completed, otherwise there will be collision in writing data to
                                // server, which may casuse data lost and red screen when user will be back to counters list
                                // page
                                await counterList[i].update();
                              } else {
                                final dayReadingList = counterList[i].dayReadingList;

                                if (dayReadingList != null) {
                                  final list = dayReadingList.map((dynamic e) => double.parse('$e')).toList();
                                  final lastReading = list.last;

                                  if (lastReading > double.parse(textEditingControllerList[i].text.trim())) {
                                    setState(() => _isLoading = false);

                                    showAlert(
                                      title: 'Внимание!',
                                      content: 'Новые показания не могут быть меньше предыдущих!',
                                      context: context,
                                    );
                                    return;
                                  }
                                }

                                counterList[i].setAdd(
                                  Counter.keyDayReadingList,
                                  double.parse(textEditingControllerList[i].text.trim()),
                                );
                                counterList[i].setAdd(
                                  Counter.keyReadingDateList,
                                  DateTime.now().toLocal(),
                                );
                                counterList[i].currentDayReading = double.parse(
                                  textEditingControllerList[i].text.trim(),
                                );
                                counterList[i].currentReadingDate = DateTime.now().toLocal();

                                // need await for update completed, otherwise there will be collision in writing data to
                                // server, which may casuse data lost and red screen when user will be back to counters list
                                // page
                                await counterList[i].update();
                              }
                            }

                            _returnToCountersPage();
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      );

  List<TextEditingController> _createTextEditingControllerList() {
    final list = <TextEditingController>[];
    for (var i = 0; i < counterList.length; i++) {
      final controller = TextEditingController();
      list.add(controller);
    }

    return list;
  }

  List<TextFormField> _generateTextFormFields() {
    final list = <TextFormField>[];
    final isElectricCounter = counterList.any((counter) => counter.serviceTitle == 'Электроснабжение');

    for (var i = 0; i < counterList.length; i++) {
      TextFormField textField;

      // if this is electric counter then at index `0` and `1` will be same electric counter
      if (i == 0 && isElectricCounter) {
        textField = TextFormField(
          controller: textEditingControllerList[i],
          decoration: InputDecoration(
            labelText: 'Пред. показание ${counterList[i].serviceTitle} (день):'
                ' ${counterList[i].dayReadingList!.last}',
          ),
          keyboardType: TextInputType.number,
        );

        // if this is electric counter then at index `0` and `1` will be same electric counter
      } else if (i == 1 && isElectricCounter) {
        textField = TextFormField(
          controller: textEditingControllerList[i],
          decoration: InputDecoration(
            labelText: 'Пред. показание ${counterList[i].serviceTitle} (ночь):'
                ' ${counterList[i].nightReadingList!.last}',
          ),
          keyboardType: TextInputType.number,
        );

        // else it will be water counter which have only dayReadingList filled
      } else {
        textField = TextFormField(
          controller: textEditingControllerList[i],
          decoration: InputDecoration(
            labelText: 'Пред. показание ${counterList[i].serviceTitle}:'
                ' ${counterList[i].dayReadingList!.last}',
          ),
          keyboardType: TextInputType.number,
        );
      }

      list.add(textField);
    }

    return list;
  }

  void _returnToCountersPage() {
    setState(() => _isLoading = false);

    Navigator.of(context).pop(true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Данные обновлены!'),
      ),
    );
  }
}
