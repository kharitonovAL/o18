import 'dart:developer';
import 'dart:io';

import 'package:auth_repository/auth_repository.dart';
import 'package:database_repository/database_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o18_client/helper/helper.dart';
import 'package:storage_repository/storage_repository.dart';

class AddRequestPage extends StatefulWidget {
  final AuthRepository authRepo;
  final UserRequestRepository userRequestRepository;
  final OwnerRepository ownerRepository;
  final FlatRepository flatRepository;
  final HouseRepository houseRepository;
  final AccountRepository accountRepository;
  final RequestNumberRepository requestNumberRepository;
  final ImageRepository imageFileRepository;

  const AddRequestPage({
    required this.authRepo,
    required this.userRequestRepository,
    required this.ownerRepository,
    required this.flatRepository,
    required this.houseRepository,
    required this.accountRepository,
    required this.requestNumberRepository,
    required this.imageFileRepository,
  });

  @override
  _AddRequestPage createState() => _AddRequestPage();
}

class _AddRequestPage extends State<AddRequestPage> {
  TextEditingController textController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  File? _image1;
  File? _image2;
  File? _image3;
  File? _image4;
  File? _image5;

  bool _isLoading = false;

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Запрос'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Опишите причину обращения здесь',
                ),
                controller: textController,
                maxLines: 5,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      width: 100,
                      height: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          setImage1(),
                          _image1 != null ? const Positioned(child: Icon(Icons.cancel)) : Container()
                        ],
                      ),
                    ),
                    onTap: () async {
                      _image1 == null ? await getImage1() : setState(() => _image1 = null);
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      width: 100,
                      height: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          setImage2(),
                          _image2 != null ? const Positioned(child: Icon(Icons.cancel)) : Container()
                        ],
                      ),
                    ),
                    onTap: () async {
                      _image2 == null ? await getImage2() : setState(() => _image2 = null);
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      width: 100,
                      height: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          setImage3(),
                          _image3 != null ? const Positioned(child: Icon(Icons.cancel)) : Container()
                        ],
                      ),
                    ),
                    onTap: () async {
                      _image3 == null ? await getImage3() : setState(() => _image3 = null);
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      width: 100,
                      height: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          setImage4(),
                          _image4 != null ? const Positioned(child: Icon(Icons.cancel)) : Container()
                        ],
                      ),
                    ),
                    onTap: () async {
                      _image4 == null ? await getImage4() : setState(() => _image4 = null);
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      width: 100,
                      height: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          setImage5(),
                          _image5 != null ? const Positioned(child: Icon(Icons.cancel)) : Container()
                        ],
                      ),
                    ),
                    onTap: () async {
                      _image5 == null ? await getImage5() : setState(() => _image5 = null);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              FutureBuilder<int>(
                future: widget.requestNumberRepository.getLastRequestNumber(),
                builder: (context, future) {
                  if (future.hasData) {
                    final _requestNumber = future.data;

                    return _requestNumber != null
                        ? Center(
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    child: const Text('Отправить заявку'),
                                    onPressed: () async {
                                      setState(() => _isLoading = true);
                                      if (textController.text.isEmpty) {
                                        setState(() => _isLoading = false);

                                        showAlert(
                                          title: 'Внимание!',
                                          content: 'Заполните причину обращения!',
                                          context: context,
                                        );
                                        return;
                                      }

                                      final isRequestWasSend = await widget.userRequestRepository.sendRequest(
                                        keyToken: StorageRepository.getString(keyToken),
                                        requestNumber: _requestNumber,
                                        authRepo: widget.authRepo,
                                        ownerRepository: widget.ownerRepository,
                                        accountRepository: widget.accountRepository,
                                        flatRepository: widget.flatRepository,
                                        houseRepository: widget.houseRepository,
                                        textController: textController,
                                        requestNumberRepository: widget.requestNumberRepository,
                                        imageFileRepository: widget.imageFileRepository,
                                        image1: _image1,
                                        image2: _image2,
                                        image3: _image3,
                                        image4: _image4,
                                        image5: _image5,
                                      );
                                      if (!isRequestWasSend) {
                                        setState(() => _isLoading = false);

                                        showAlert(
                                          title: 'Внимание!',
                                          content:
                                              'Заявка не отправлена! Обратитесь в управляющую компанию по телефону',
                                          context: context,
                                        );
                                      } else {
                                        setState(() => _isLoading = false);

                                        Navigator.of(context).pop(true);

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            duration: Duration(seconds: 3),
                                            content: Text('Заявка отправлена!'),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                          )
                        : const Center(child: Text('Подлючаюсь...'));
                  }

                  return const Center(child: Text('Подлючаюсь...'));
                },
              ),
            ],
          ),
        ),
      );

  Future getImage1() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        log(
          'No image1 selected',
          name: 'AddRequestPage',
        );
        return;
      }
    });
  }

  Future getImage2() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
      } else {
        log(
          'No image2 selected',
          name: 'AddRequestPage',
        );

        return;
      }
    });
  }

  Future getImage3() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path);
      } else {
        log(
          'No image3 selected',
          name: 'AddRequestPage',
        );

        return;
      }
    });
  }

  Future getImage4() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image4 = File(pickedFile.path);
      } else {
        log(
          'No image4 selected',
          name: 'AddRequestPage',
        );

        return;
      }
    });
  }

  Future getImage5() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image5 = File(pickedFile.path);
      } else {
        log(
          'No image5 selected',
          name: 'AddRequestPage',
        );

        return;
      }
    });
  }

  Widget setImage1() {
    if (_image1 != null) {
      if (kIsWeb) {
        return Image.network(_image1!.path, fit: BoxFit.fill);
      } else {
        return Image.file(File(_image1!.path), fit: BoxFit.fill);
      }
    } else {
      return const Icon(Icons.add_a_photo);
    }
  }

  Widget setImage2() {
    if (_image2 != null) {
      if (kIsWeb) {
        return Image.network(_image2!.path, fit: BoxFit.fill);
      } else {
        return Image.file(File(_image2!.path), fit: BoxFit.fill);
      }
    } else {
      return const Icon(Icons.add_a_photo);
    }
  }

  Widget setImage3() {
    if (_image3 != null) {
      if (kIsWeb) {
        return Image.network(_image3!.path, fit: BoxFit.fill);
      } else {
        return Image.file(File(_image3!.path), fit: BoxFit.fill);
      }
    } else {
      return const Icon(Icons.add_a_photo);
    }
  }

  Widget setImage4() {
    if (_image4 != null) {
      if (kIsWeb) {
        return Image.network(_image4!.path, fit: BoxFit.fill);
      } else {
        return Image.file(File(_image4!.path), fit: BoxFit.fill);
      }
    } else {
      return const Icon(Icons.add_a_photo);
    }
  }

  Widget setImage5() {
    if (_image5 != null) {
      if (kIsWeb) {
        return Image.network(_image5!.path, fit: BoxFit.fill);
      } else {
        return Image.file(File(_image5!.path), fit: BoxFit.fill);
      }
    } else {
      return const Icon(Icons.add_a_photo);
    }
  }
}
