import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/style/app_fonts.dart';
import 'package:o18_web/utils/utils.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintWorkOrderButton extends StatefulWidget {
  final VoidCallback onPressed;

  const PrintWorkOrderButton({
    required this.onPressed,
  });

  @override
  State<PrintWorkOrderButton> createState() => _PrintWorkOrderButtonState();
}

class _PrintWorkOrderButtonState extends State<PrintWorkOrderButton> {
  bool isLoading = false;

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 220.w,
        height: 50.h,
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              isLoading = true;
            });

            widget.onPressed();

            /// if validation failed,
            /// stop CircularProgressIndicator after 3 seconds
            Future.delayed(const Duration(seconds: 3)).then((_) {
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            });
          },
          child: isLoading
              ? SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: const CircularProgressIndicator(),
                )
              : const Text(
                  RequestEditorString.workOrder,
                ),
        ),
      );
}

class PrintWorkOrder {
  static Future<bool> printDocument({
    required UserRequest request,
    required Partner partner,
    required Staff master,
    required Staff staff,
    required double debt,
    required String operatorName,
  }) async {
    /*
  
  ====================================

  DON'T USE SCREENUTIL FOR PW. WIDGETS

  ====================================

  */

    const _titleFontSize = 10.0;
    const _docTitleFontSize = 14.0;
    const _subTitleFontSize = 8.0;
    const _phoneNumberFontSize = 10.0;
    const _addressFontSize = 8.0;
    const _wideRowWidth = 300.0;
    const _rowWidth = 100.0;
    const _headerRowHeight = 50.0;
    const _rowHeight = 15.0;
    const _fSize = 6.0;
    const _insets = 4.0;
    const _rowAmount = 6;
    const _materialsTableWideRowWidth = 400.0;
    const _materialsTableHeaderRowHeight = 15.0;

    final _dateWithTime = DateFormat('dd.MM.yy HH:mm');

    final myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(
        await rootBundle.load(FontPath.openSansReqular),
      ),
      bold: pw.Font.ttf(
        await rootBundle.load(FontPath.openSansBold),
      ),
      italic: pw.Font.ttf(
        await rootBundle.load(FontPath.openSansItalic),
      ),
      boldItalic: pw.Font.ttf(
        await rootBundle.load(FontPath.openSansBoldItalic),
      ),
    );

    request
      ..status = RS.inProgress
      ..partnerId = partner.objectId
      ..masterId = master.objectId
      ..staffId = staff.objectId;

    await request.update();

    return Printing.layoutPdf(
      onLayout: (pageFormat) async {
        final pdf = pw.Document(
          theme: myTheme,
          title: '${PrintString.workOrderForRequest} ${request.requestNumber}',
        );

        pdf.addPage(
          pw.Page(
            build: (context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  PrintString.title,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: _titleFontSize,
                  ),
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.SizedBox(width: 300),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          PrintString.operatorPhone,
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: _phoneNumberFontSize,
                          ),
                        ),
                        pw.Text(
                          partner.fullAddress,
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: _addressFontSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.Center(
                  child: pw.Text(
                    PrintString.workOrder,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: _docTitleFontSize,
                    ),
                  ),
                ),
                pw.Text(
                  PrintString.workOrderSubtitle,
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(
                    fontSize: _subTitleFontSize,
                  ),
                ),
                pw.Text(
                  '\n${PrintString.requestNumber} ${request.requestNumber} ${PrintString.from} ${_dateWithTime.format(request.requestDate!)}',
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(
                    fontSize: _subTitleFontSize,
                  ),
                ),
                pw.Text(
                  '${PrintString.requestAddress}: ${request.address} ${PrintString.flatNumberShort} ${request.flatNumber}',
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(
                    fontSize: _subTitleFontSize,
                  ),
                ),
                pw.Text(
                  '${PrintString.requestOwner}: ${request.userName} ${PrintString.phoneNumberShort}${request.phoneNumber}',
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(
                    fontSize: _subTitleFontSize,
                  ),
                ),
                pw.Text(
                  '${PrintString.requestDetails}: ${request.userRequest}',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: _subTitleFontSize,
                  ),
                ),
                pw.Text(
                  '${PrintString.staff}: ${partner.title}, ${staff.name}',
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(
                    fontSize: _subTitleFontSize,
                  ),
                ),
                pw.Text(
                  '${PrintString.debt} $debt ${PrintString.roubles}',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: _titleFontSize,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '${PrintString.workOrderOperator} $operatorName',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: _titleFontSize,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Divider(height: 2),
                pw.Text(
                  PrintString.requestEndTime,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: _titleFontSize,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Column(
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          height: _headerRowHeight,
                          width: _wideRowWidth,
                          child: pw.Center(
                            child: pw.Padding(
                              padding: const pw.EdgeInsets.all(_insets),
                              child: pw.Text(
                                PrintString.workOrderJobTitle,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  fontSize: _fSize,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                        pw.Container(
                          height: _headerRowHeight,
                          width: _rowWidth,
                          child: pw.Center(
                            child: pw.Padding(
                              padding: const pw.EdgeInsets.all(_insets),
                              child: pw.Text(
                                PrintString.workOrderMeasure,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  fontSize: _fSize,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                        pw.Container(
                          height: _headerRowHeight,
                          width: _rowWidth,
                          child: pw.Center(
                            child: pw.Padding(
                              padding: const pw.EdgeInsets.all(_insets),
                              child: pw.Text(
                                PrintString.workOrderUnit,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  fontSize: _fSize,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0; i < _rowAmount; i++)
                      pw.Row(
                        children: [
                          pw.Container(
                            height: _rowHeight,
                            width: _wideRowWidth,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                          ),
                          pw.Container(
                            height: _rowHeight,
                            width: _rowWidth,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                          ),
                          pw.Container(
                            height: _rowHeight,
                            width: _rowWidth,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                          ),
                        ],
                      ),
                    pw.Row(
                      children: [
                        pw.Container(
                          height: _rowHeight,
                          width: _wideRowWidth,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(_insets),
                            child: pw.Text(
                              PrintString.workOrderCommunication,
                              textAlign: pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: _fSize,
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                        pw.Container(
                          height: _rowHeight,
                          width: _rowWidth * 2,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(_insets),
                            child: pw.Text(
                              PrintString.workOrderStatusDescription,
                              textAlign: pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: _fSize,
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          height: _rowHeight,
                          width: _wideRowWidth,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(_insets),
                            child: pw.Text(
                              PrintString.workOrderWater,
                              textAlign: pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: _fSize,
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                        pw.Container(
                          height: _rowHeight,
                          width: _rowWidth * 2,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          height: _rowHeight,
                          width: _wideRowWidth,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(_insets),
                            child: pw.Text(
                              PrintString.workOrderElectricity,
                              textAlign: pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: _fSize,
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                        pw.Container(
                          height: _rowHeight,
                          width: _rowWidth * 2,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          height: _rowHeight,
                          width: _wideRowWidth,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(_insets),
                            child: pw.Text(
                              PrintString.workOrderBuildingConstruction,
                              textAlign: pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: _fSize,
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                        pw.Container(
                          height: _rowHeight,
                          width: _rowWidth * 2,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          height: _rowHeight,
                          width: _wideRowWidth,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(_insets),
                            child: pw.Text(
                              PrintString.workOrderHouseArea,
                              textAlign: pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: _fSize,
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                        pw.Container(
                          height: _rowHeight,
                          width: _rowWidth * 2,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          height: _rowHeight,
                          width: _wideRowWidth,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(_insets),
                            child: pw.Text(
                              PrintString.workOrderVentilation,
                              textAlign: pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: _fSize,
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                        pw.Container(
                          height: _rowHeight,
                          width: _rowWidth * 2,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(_insets),
                            child: pw.Text(
                              PrintString.workOrderValidation,
                              textAlign: pw.TextAlign.left,
                              style: const pw.TextStyle(
                                fontSize: _fSize,
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  PrintString.contractorSign,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: _titleFontSize,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  PrintString.ownerSign,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: _titleFontSize,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Column(
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          height: _materialsTableHeaderRowHeight,
                          width: _materialsTableWideRowWidth,
                          child: pw.Center(
                            child: pw.Padding(
                              padding: const pw.EdgeInsets.all(_insets),
                              child: pw.Text(
                                PrintString.workOrderMaterials,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  fontSize: _fSize,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                        pw.Container(
                          height: _materialsTableHeaderRowHeight,
                          width: _rowWidth,
                          child: pw.Center(
                            child: pw.Padding(
                              padding: const pw.EdgeInsets.all(_insets),
                              child: pw.Text(
                                PrintString.workOrderAmount,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  fontSize: _fSize,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0; i < 8; i++)
                      pw.Row(
                        children: [
                          pw.Container(
                            height: _rowHeight,
                            width: _materialsTableWideRowWidth,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                          ),
                          pw.Container(
                            height: _rowHeight,
                            width: _rowWidth,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  PrintString.ownerEndSign,
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(
                    fontSize: _subTitleFontSize,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  PrintString.workOrderFeedback,
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(
                    fontSize: _subTitleFontSize,
                  ),
                ),
                pw.Divider(height: 2),
                pw.SizedBox(height: 8),
                pw.Divider(height: 2),
                pw.SizedBox(height: 8),
                pw.Divider(height: 2),
              ],
            ),
          ),
        );

        return pdf.save();
      },
    );
  }
}
