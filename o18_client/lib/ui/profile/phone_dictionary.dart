import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneDictionary extends StatelessWidget {
  const PhoneDictionary({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Другие телефоны'),
        ),
        body: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                      'ЕДДС города Ижевска — Служба реагирования в чрезвычайных ситуациях:'),
                  gestureDetector('+7 (3412) 57-25-12'),
                  gestureDetector('+7 (3412) 57-21-14'),
                  gestureDetector('+7 (3412) 57-21-15'),
                  gestureDetector('+7 (3412) 57-21-19'),
                  gestureDetector('112'),
                  const Divider(),
                  textWidget(
                      'МБУ "Поисково-спасательная служба города Ижевска":'),
                  gestureDetector('+7 (3412) 65-53-13'),
                  const Divider(),
                  textWidget(
                      'ГУ УР "Поисково-спасательная служба Удмуртской Республики":'),
                  gestureDetector('+7 (3412) 56-72-42'),
                  const Divider(),
                  textWidget(
                      'ФКУ "ЦУКС ГУ МЧС России по Удмуртской Республике":'),
                  Row(children: [
                    gestureDetector('112'),
                    const Text(', '),
                    gestureDetector('101')
                  ]),
                  const Divider(),
                  textWidget('Дежурная часть УМВД по городу Ижевску:'),
                  Row(children: [
                    gestureDetector('+7 (3412) 416-001'),
                    const Text(', '),
                    gestureDetector('102')
                  ]),
                  const Divider(),
                  textWidget('Отдел полиции №1 (Ленинский район):'),
                  gestureDetector('+7 (3412) 69-53-00'),
                  gestureDetector('+7 (3412) 69-53-01'),
                  const Divider(),
                  textWidget('Отдел полиции №2 (Октябрьский район):'),
                  gestureDetector('+7 (3412) 41-56-20'),
                  gestureDetector('+7 (3412) 41-56-82'),
                  const Divider(),
                  textWidget('Отдел полиции №3 (Первомайский район):'),
                  gestureDetector('+7 (3412) 69-80-02'),
                  gestureDetector('+7 (3412) 69-80-23'),
                  const Divider(),
                  textWidget('Отдел полиции №4 (Устиновский район):'),
                  gestureDetector('+7 (3412) 69-60-00'),
                  gestureDetector('+7 (3412) 46-33-34'),
                  const Divider(),
                  textWidget('Отдел полиции №2 (Индустриальный район):'),
                  gestureDetector('+7 (3412) 41-55-00'),
                  gestureDetector('+7 (3412) 41-60-39'),
                  const Divider(),
                  textWidget('Управление ФСБ России по Удмуртской Республике:'),
                  gestureDetector('+7 (3412) 78-61-33'),
                  const Divider(),
                  textWidget('ГИБДД МВД УР:'),
                  gestureDetector('+7 (3412) 41-57-00'),
                  gestureDetector('+7 (3412) 41-57-01'),
                  const Divider(),
                  textWidget(
                      'Управление федеральной службы по борьбе с незаконным оборотом наркотиков:'),
                  gestureDetector('+7 (3412) 44-77-33'),
                  const Divider(),
                  textWidget('БУЗ УР "Станция скорой медицинской помощи":'),
                  Row(children: [
                    gestureDetector('+7 (3412) 72-29-09'),
                    const Text(', '),
                    gestureDetector('103')
                  ]),
                  const Divider(),
                  textWidget('РОАО "Удмуртгаз" предприятие "Ижевскгаз":'),
                  Row(children: [
                    gestureDetector('+7 (3412) 43-30-57'),
                    const Text(', '),
                    gestureDetector('104')
                  ]),
                  const Divider(),
                  textWidget('ОАО "Ижевские электрические сети":'),
                  gestureDetector('+7 (3412) 78-30-31'),
                  const Divider(),
                  textWidget('МУП "Горсвет":'),
                  gestureDetector('+7 (3412) 79-60-60'),
                  const Divider(),
                  textWidget('МАУ МФЦ:'),
                  gestureDetector('+7 (3412) 90-80-72'),
                  const Divider(),
                  textWidget('МУП "Ижводоканал":'),
                  gestureDetector('+7 (3412) 78-75-92'),
                  gestureDetector('+7 (3412) 78-25-32'),
                  const Divider(),
                  textWidget('ООО "Удмуртские коммунальные системы":'),
                  gestureDetector('+7 (3412) 90-35-62'),
                  const Divider(),
                  textWidget('МУП "ИжГЭТ":'),
                  gestureDetector('+7 (3412) 51-43-80'),
                  const Divider(),
                  textWidget('ОАО "ИПОПАТ":'),
                  gestureDetector('+7 (3412) 45-54-37'),
                  const Divider(),
                  textWidget(
                      'Телефон доверия МВД России по Удмуртской Республике:'),
                  gestureDetector('+7 (3412) 41-93-73'),
                  gestureDetector('+7 (3412) 41-94-74'),
                  gestureDetector('+7 (3412) 41-95-75'),
                  const Divider(),
                  textWidget(
                      'Круглосуточная диспетчерская служба — Информационно-аналитический отдел МКУ г.Ижевска "Служба технологического обеспечения ЖКХ":'),
                  const Text('072',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
      );

  Text textWidget(
    String text,
  ) =>
      Text(
        text,
        style: const TextStyle(fontSize: 16),
      );

  GestureDetector gestureDetector(
    String phoneNumber,
  ) =>
      GestureDetector(
        child: Text(
          phoneNumber,
          style: const TextStyle(fontSize: 16, color: Colors.blue),
        ),
        onTap: () => _callPhone(
          phoneNumber: phoneNumber
              .replaceAll(' ', '')
              .replaceAll('(', '')
              .replaceAll(')', '')
              .replaceAll('-', ''),
        ),
      );

  void _callPhone({
    required String phoneNumber,
  }) async {
    final phone = 'tel:$phoneNumber';

    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not Call Phone';
    }
  }
}
