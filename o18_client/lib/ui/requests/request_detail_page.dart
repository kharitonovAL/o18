import 'package:database_repository/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';

class RequestDetailPage extends StatefulWidget {
  final UserRequest request;

  const RequestDetailPage({
    required this.request,
  });

  @override
  _RequestDetailPage createState() => _RequestDetailPage();
}

class _RequestDetailPage extends State<RequestDetailPage> {
  String requestDate = '', responseDate = '', status = '';
  final dateFormat = DateFormat('dd.MM.yyyy в HH:mm');
  final _cancelReasonTEC = TextEditingController();
  bool _cancelReasonValidator = false;
  ImageRepository imageFileRepository = ImageRepository();

  @override
  void initState() {
    super.initState();

    final reqDate = DateTime.fromMillisecondsSinceEpoch(widget.request.requestDate!.millisecondsSinceEpoch);
    requestDate = dateFormat.format(reqDate);

    if (widget.request.responseDate != null) {
      final respDate = DateTime.fromMillisecondsSinceEpoch(widget.request.responseDate!.millisecondsSinceEpoch);
      responseDate = dateFormat.format(respDate);
    }

    status = widget.request.status!;
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(title: const Text('Запрос')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Вы писали $requestDate:\n',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.request.userRequest!,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 5,
                      ),
                      Text(
                        '\nСтатус: $status',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ответ:', style: TextStyle(fontSize: 16)),
                      Text(
                        widget.request.response ?? 'Занимаемся Вашей заявкой...',
                        style: const TextStyle(fontSize: 16),
                      ),
                      if (status == RS.closed)
                        Text(
                          '\nОтвет получен $responseDate',
                          style: const TextStyle(fontSize: 16),
                        ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text('Посмотреть фото'),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Фото к заявке'),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: FutureBuilder<List<ImageFile>>(
                          future: imageFileRepository.getImageListForRequestId(requestId: widget.request.objectId!),
                          builder: (context, future) {
                            if (future.hasData) {
                              final list = future.data;

                              // fixing url address
                              list!.forEach((image) {
                                final url = image.file!.url!.replaceAll('http://', 'https://');
                                image.file!.url = url;
                              });

                              return ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) => GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: Image.network(
                                        list[index].file!.url!,
                                        loadingBuilder: (context, child, progress) => progress == null
                                            ? child
                                            : Center(
                                                child: CircularProgressIndicator(
                                                  value: progress.expectedTotalBytes != null
                                                      ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (context) => GestureDetector(
                                        child: Image.network(
                                          list[index].file!.url!,
                                          loadingBuilder: (context, child, progress) => progress == null
                                              ? child
                                              : Center(
                                                  child: CircularProgressIndicator(
                                                    value: progress.expectedTotalBytes != null
                                                        ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                                                        : null,
                                                  ),
                                                ),
                                        ),
                                        onTap: () => Navigator.of(context).pop(),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }

                            return const Center(
                              child: Text('Нет фото к заявке...'),
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: Navigator.of(context).pop,
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              widget.request.status == RS.closed || widget.request.status == RS.canceled
                  ? Container()
                  : ElevatedButton(
                      child: const Text('Отменить заявку'),
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                              title: const Text('Введите причину отмены'),
                              content: TextField(
                                keyboardType: TextInputType.text,
                                controller: _cancelReasonTEC,
                                decoration: InputDecoration(
                                  labelText: 'Причина отмены',
                                  errorText: _cancelReasonValidator ? 'Введите причину отмены' : null,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: const Text('Назад'),
                                ),
                                TextButton(
                                  child: const Text('Отменить заявку'),
                                  onPressed: () {
                                    setState(() => _cancelReasonValidator = _cancelReasonTEC.text.isEmpty);
                                    if (!_cancelReasonValidator) {
                                      widget.request.status = RS.canceled;
                                      widget.request.cancelReason = _cancelReasonTEC.text;
                                      widget.request.response = 'Заявка отозвана заявителем';
                                      widget.request.responseDate = DateTime.now().toLocal();
                                      widget.request.update();

                                      Navigator.of(context).pop();
                                      _cancelReasonTEC.clear();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ).then((_) => Navigator.of(context).pop());
                      },
                    ),
            ],
          ),
        ),
      );
}
