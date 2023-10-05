import 'package:authentication_repository/authentication_repository.dart';
import 'package:database_repository/database_repository.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/requests_tab/cubit/cubit.dart';
import 'package:o18_web/features/requests_tab/widgets/widgets.dart';
import 'package:o18_web/features/tab_page/widgets/widgets.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RequestsTab extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback onNewRequestPressed;
  final User user;

  const RequestsTab({
    required this.textController,
    required this.onNewRequestPressed,
    required this.user,
  });

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  List<DropdownMenuItem<String>> _sortItems = [];
  List<String> _items = [];
  String? _selectedValue;

  // variables for logs
  DateFormat shortDateFormat = DateFormat('dd.MM.yy');
  DateFormat longDateFormat = DateFormat('dd.MM.yy HH:mm');
  double rowFontSize = 14;
  String? _selectedAddress;

  @override
  void didChangeDependencies() {
    _sortItems = [
      DropdownMenuItem<String>(
        value: RequestTabString.sortNewFirst,
        child: Text(
          RequestTabString.sortNewFirst,
          style: AppFonts.dropDownBlack,
        ),
      ),
      DropdownMenuItem<String>(
        value: RequestTabString.sortOldFirst,
        child: Text(
          RequestTabString.sortOldFirst,
          style: AppFonts.dropDownBlack,
        ),
      ),
      DropdownMenuItem<String>(
        value: RequestTabString.sortFailureOnly,
        child: Text(
          RequestTabString.sortFailureOnly,
          style: AppFonts.dropDownBlack,
        ),
      ),
    ];

    _items = [
      TabViewString.log_1,
      TabViewString.log_2,
      TabViewString.log_3,
      TabViewString.log_4,
      TabViewString.log_5,
      TabViewString.log_6,
    ];

    super.didChangeDependencies();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 40.h,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      RequestTabString.requests,
                      style: AppFonts.heading_0,
                    ),
                    SizedBox(width: 11.w),
                    NewRequestButton(
                      onPressed: widget.onNewRequestPressed,
                    ),
                    SizedBox(width: 11.w),
                    RefreshButton(
                      onPressed: context.read<RequestsTabCubit>().loadUserRequestList,
                    ),
                  ],
                ),
                SearchField(
                  title: RequestTabString.searchRequest,
                  textController: widget.textController,
                  onChanged: context.read<RequestsTabCubit>().searchRequest,
                ),
                Row(
                  children: [
                    Text(
                      RequestTabString.sortBy,
                      style: AppFonts.searchBar,
                    ),
                    SizedBox(width: 11.w),
                    BlocBuilder<SortingCubit, SortingState>(
                      buildWhen: (previous, current) => previous.props.first != current.props.first,
                      builder: (context, state) => DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            padding: EdgeInsets.only(left: 28.w),
                            width: 300.w,
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height: 35.h,
                            padding: EdgeInsets.only(
                              left: 28.w,
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          iconStyleData: IconStyleData(
                            icon: Padding(
                              padding: EdgeInsets.only(right: 14.w),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20.w,
                                color: AppColors.green_0,
                              ),
                            ),
                          ),
                          items: _sortItems,
                          value: state.sorting,
                          onChanged: (val) {
                            context.read<SortingCubit>().selectSorting(val.toString());

                            if (val == _sortItems[0].value) {
                              context.read<RequestsTabCubit>().sortFromNewToOld();
                            }

                            if (val == _sortItems[1].value) {
                              context.read<RequestsTabCubit>().sortFromOldToNew();
                            }

                            if (val == _sortItems[2].value) {
                              context.read<RequestsTabCubit>().sortFailureOnly();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    dropdownStyleData: DropdownStyleData(
                      width: 418.w,
                      maxHeight: 233.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Padding(
                        padding: EdgeInsets.only(right: 14.w),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20.w,
                          color: AppColors.green_0,
                        ),
                      ),
                    ),
                    hint: Text(
                      TabViewString.requestsLogs,
                      style: AppFonts.menuUnselected,
                    ),
                    items: _items
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: AppFonts.dropDownBlack,
                            ),
                          ),
                        )
                        .toList(),
                    value: _selectedValue,
                    onChanged: (log) async {
                      final list = context.read<RequestsTabCubit>().requestList;

                      if (log == TabViewString.log_1) {
                        final _list = list;
                        _list
                          ..retainWhere((request) => request.status != RS.closed)
                          ..retainWhere((request) => request.status != RS.canceled);

                        await _printDayRequestLog(
                          title: '${TabViewString.log_1_full} ${shortDateFormat.format(DateTime.now())}',
                          requestList: list,
                          onlyInProgress: true,
                        );
                      }

                      if (log == TabViewString.log_2) {
                        await _printDayRequestLog(
                          title: '${TabViewString.log_2_full} ${shortDateFormat.format(DateTime.now())}',
                          requestList: list,
                          requestType: RequestType.maintenance,
                        );
                      }

                      if (log == TabViewString.log_3) {
                        final _list = list;
                        final houseRep = HouseRepository();
                        final houseList = await houseRep.getHouseList();
                        final addresses = houseList.map((e) => e.addressToString).toList();
                        addresses.sort((a, b) => a.toString().compareTo(b.toString()));

                        await showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26.r),
                              ),
                              title: const Text(TabViewString.selectAddress),
                              content: SizedBox(
                                width: 430.w,
                                height: 56.h,
                                child: DropdownSearch<String>(
                                  selectedItem: _selectedAddress,
                                  onChanged: (value) => setState(() => _selectedAddress = value.toString()),
                                  items: addresses,
                                  dropdownButtonProps: DropdownButtonProps(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20.w,
                                      color: AppColors.green_0,
                                    ),
                                    iconSize: 20.h,
                                  ),
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: const InputDecoration(
                                      hintText: TabViewString.selectFromList,
                                    ),
                                    baseStyle: AppFonts.dropDownGrey,
                                  ),
                                  dropdownBuilder: (context, address) => address == null
                                      ? Text(
                                          TabViewString.selectFromList,
                                          style: AppFonts.dropDownGrey,
                                        )
                                      : Text(
                                          address,
                                          style: AppFonts.dropDownBlack,
                                        ),
                                  popupProps: PopupProps.dialog(
                                    dialogProps: DialogProps(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      style: AppFonts.dropDownBlack,
                                      decoration: InputDecoration(
                                        hintText: TabViewString.search,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12.r),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 700.w,
                                      maxWidth: 700.w,
                                      maxHeight: 700.h,
                                    ),
                                    emptyBuilder: (context, _) => Center(
                                      child: Text(
                                        TabViewString.nothingFound,
                                        style: AppFonts.dropDownBlack,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: const Text(TabViewString.cancel),
                                ),
                                if (_selectedAddress != null)
                                  TextButton(
                                    child: const Text(TabViewString.show),
                                    onPressed: () {
                                      _list.retainWhere(
                                        (request) => request.address == _selectedAddress,
                                      );

                                      if (list.isNotEmpty) {
                                        final firstDate = list.last.requestDate;
                                        final lastDate = list.first.requestDate;
                                        final fDate = DateTime(
                                          firstDate!.year,
                                          firstDate.month,
                                          firstDate.day,
                                        );
                                        final lDate = DateTime(
                                          lastDate!.year,
                                          lastDate.month,
                                          lastDate.day,
                                        );
                                        _printPdf(
                                          title: '${TabViewString.log_3} $_selectedAddress '
                                              '${TabViewString.forDate} ${shortDateFormat.format(DateTime.now())}',
                                          dateList: [fDate, lDate],
                                          requestList: list,
                                          forHouse: true,
                                        );
                                        _selectedAddress = null;
                                        Navigator.of(context).pop();
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(26.r),
                                            ),
                                            title: const Text(TabViewString.attention),
                                            content: const Text(
                                              TabViewString.noRequestsForAddress,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: Navigator.of(context).pop,
                                                child: const Text(TabViewString.ok),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (log == TabViewString.log_4) {
                        final _list = list;
                        _list
                          ..retainWhere((request) => request.status != RS.closed)
                          ..retainWhere((request) => request.status != RS.canceled);

                        await _printDayRequestLog(
                          title:
                              '${TabViewString.log_4} ${TabViewString.forDate} ${shortDateFormat.format(DateTime.now())}',
                          requestList: list,
                          onlyInProgress: true,
                        );
                      }

                      if (log == TabViewString.log_5) {
                        await _printDayRequestLog(
                          title:
                              '${TabViewString.log_5} ${TabViewString.forDate} ${shortDateFormat.format(DateTime.now())}',
                          requestList: list,
                        );
                      }

                      if (log == TabViewString.log_6) {
                        final _list = list;
                        _list
                          ..retainWhere((request) => request.status != RS.closed)
                          ..retainWhere((request) => request.status != RS.canceled);

                        await _printDayRequestLog(
                          title:
                              '${TabViewString.log_6} ${TabViewString.forDate} ${shortDateFormat.format(DateTime.now())}',
                          requestList: list,
                          requestType: RequestType.paid,
                        );
                      }
                    },
                    menuItemStyleData: MenuItemStyleData(
                      height: 35.h,
                      padding: EdgeInsets.only(
                        left: 28.w,
                      ),
                    ),
                    buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.only(left: 28.w),
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 34.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Column(
                children: [
                  const RequestsHeaderRow(),
                  SizedBox(
                    height: 740.h,
                    width: 1840.w,
                    child: BlocBuilder<RequestsTabCubit, RequestsTabState>(
                      builder: (context, state) {
                        if (state is UserRequestLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is UserRequestLoadFailure) {
                          return Center(
                            child: Text('${RequestTabString.error}: ${state.error}'),
                          );
                        } else if (state is UserRequestLoaded) {
                          if (state.userRequestList.isEmpty) {
                            return const Center(
                              child: Text(
                                RequestTabString.noRequestsYet,
                              ),
                            );
                          }

                          return RequestsListView(
                            list: state.userRequestList,
                            user: widget.user,
                          );
                        } else if (state is UserRequestAdded) {
                          return RequestsListView(
                            list: state.userRequestList,
                            user: widget.user,
                          );
                        } else if (state is SortFromNewToOld) {
                          return RequestsListView(
                            list: state.userRequestList,
                            user: widget.user,
                          );
                        } else if (state is SortFromOldToNew) {
                          return RequestsListView(
                            list: state.userRequestList,
                            user: widget.user,
                          );
                        } else if (state is SortFailureOnly) {
                          return RequestsListView(
                            list: state.userRequestList,
                            user: widget.user,
                          );
                        } else if (state is SearchchingRequest) {
                          return RequestsListView(
                            list: state.userRequestList,
                            user: widget.user,
                          );
                        }

                        return const Center(
                          child: Text(RequestTabString.noRequestsYet),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Future<void> _printDayRequestLog({
    required String title,
    required List<UserRequest> requestList,
    bool onlyInProgress = false,
    String? requestType,
  }) async {
    final firstDate = DateTime(
      requestList.first.requestDate!.year,
      requestList.first.requestDate!.month,
      requestList.first.requestDate!.day,
    );

    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    final dateList = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: today,
      cancelText: TabViewString.cancel,
      confirmText: TabViewString.ok,
      builder: (context, child) => Column(
        children: [
          SizedBox(height: 100.h),
          SizedBox(
            height: 750.h,
            width: 750.w,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.green_0,
                  onPrimary: AppColors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.black,
                  ),
                ),
              ),
              child: child!,
            ),
          ),
        ],
      ),
    );

    if (dateList != null) {
      await _printPdf(
        title: title,
        dateList: [dateList.start, dateList.end],
        requestList: requestList,
        onlyInProgress: onlyInProgress,
        requestType: requestType,
      );
    }
  }

  Future<void> _printPdf({
    required String title,
    required List<DateTime> dateList,
    required List<UserRequest> requestList,
    bool onlyInProgress = false,
    bool forHouse = false,
    String? requestType,
  }) async {
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

    await Printing.layoutPdf(onLayout: (pageFormat) async {
      final pdf = pw.Document(
        title: title,
        theme: myTheme,
      );

      final list = requestList.reversed.toList();

      // If true, first - need to remove from list all closed and canceled requests
      if (onlyInProgress) {
        list.retainWhere((request) => request.status != RS.closed);
        list.retainWhere((request) => request.status != RS.canceled);
      }

      if (requestType == RequestType.paid) {
        list.retainWhere((request) => request.requestType == RequestType.paid);
      }

      // retain only those requests that gets in dates frame
      list.retainWhere(
        (request) {
          if (requestType == RequestType.scheduled) {
            final responseDate = DateTime(
              request.responseDate!.year,
              request.responseDate!.month,
              request.responseDate!.day,
            );
            final boolValue = responseDate.isAfter(dateList.first) && responseDate.isBefore(dateList.last) ||
                responseDate.isAtSameMomentAs(dateList.first) ||
                responseDate.isAtSameMomentAs(dateList.last);
            return boolValue;
          } else {
            final requestDate = DateTime(
              request.requestDate!.year,
              request.requestDate!.month,
              request.requestDate!.day,
            );
            final boolValue = (requestDate.isAfter(dateList.first) && requestDate.isBefore(dateList.last)) ||
                requestDate.isAtSameMomentAs(dateList.first) ||
                requestDate.isAtSameMomentAs(dateList.last);
            return boolValue;
          }
        },
      );

      // if amount of requests is less then 12, it will fit on one page of paper
      if (list.length <= 12) {
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            orientation: pw.PageOrientation.landscape,
            build: (context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _logTitle(
                  dateList: dateList,
                  onlyInProgress: onlyInProgress,
                  forHouse: forHouse,
                  requestType: requestType,
                  pageNumber: 1,
                ),
                _requestsLogTable(
                  requestList: list,
                  pageNumber: 1,
                ),
              ],
            ),
          ),
        );
      } else {
        // if amount of requests is more then 12, it won't fit on one page of paper, so we have to split
        // all requests to equal amount per page

        // amount of rows that fits to the one page
        const rowsPerPage = 12;

        // amount of pages that needed to show all requests.
        // as it can be rounded to the zero, we have to add one extra page.
        final pagesAmount = (list.length / rowsPerPage).round() + 1;

        for (var i = 0; i < pagesAmount; i++) {
          // to split all requests equally per all pages, we have to define request's indexes that will be shown
          // on different pages
          int startIndex;
          int endIndex;

          if (i == 0) {
            // if this is the first page, set start index to zero and end index to max rows per page minus 1
            startIndex = 0;
            endIndex = rowsPerPage - 1;
          } else {
            // if this is not first page, we have to start each next page index 11, then 22, then 33 ,then 44 and so on
            startIndex = (rowsPerPage - 1) * i;

            // also we have to know what amount of requests will be on the last page, so we get it by subtracting
            // from all requests amount those pages that was already added.
            var subtractionResult = list.length - rowsPerPage * i;

            // sometime subtraction result is negative, and needs to be positive
            if (subtractionResult.isNegative) {
              subtractionResult *= -1;
            }

            // if subtraction result is less then max rows per page we do the follow:
            subtractionResult < 12
                // if subtraction result is less then max rows per page, and so this is the last page,
                // we get current page start index and adding subtraction result to get last element index
                // or we can just get `list.length - 1`
                ? endIndex = list.length - 1

                // else this is not the last page and we continue to add pages
                : endIndex = (rowsPerPage - 1) * (i + 1);

            // if start index is out of range, it means that previous for-cycle was last and we need to stop iterating
            if ((endIndex - startIndex).isNegative) {
              break;
            }
          }

          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              orientation: pw.PageOrientation.landscape,
              build: (context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _logTitle(
                    dateList: dateList,
                    onlyInProgress: onlyInProgress,
                    forHouse: forHouse,
                    requestType: requestType,
                    pageNumber: i + 1,
                  ),
                  _requestsLogTable(
                    requestList: list.sublist(startIndex, endIndex),
                    pageNumber: i + 1,
                  ),
                ],
              ),
            ),
          );
        }
      }

      return pdf.save();
    });
  }

  pw.Widget _logTitle({
    required List<DateTime> dateList,
    required int pageNumber,
    bool onlyInProgress = false,
    bool forHouse = false,
    String? requestType,
  }) {
    if (forHouse) {
      return pw.Text(
        '${TabViewString.log_5.toUpperCase()} ${TabViewString.forDate.toUpperCase()} ${shortDateFormat.format(DateTime.now())}',
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 16,
        ),
      );
    }

    if (onlyInProgress && requestType != RequestType.scheduled) {
      return pw.Text(
        '${TabViewString.log_4.toUpperCase()} '
        'С ${shortDateFormat.format(dateList.first)} ПО ${shortDateFormat.format(dateList.last)}',
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 16,
        ),
      );
    } else if (onlyInProgress && requestType == RequestType.scheduled) {
      return pw.Text(
        '${TabViewString.log_1.toUpperCase()} '
        'С ${shortDateFormat.format(dateList.first)} ПО ${shortDateFormat.format(dateList.last)}',
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 16,
        ),
      );
    }

    if (requestType == RequestType.maintenance) {
      return pw.Text(
        '${TabViewString.log_2_full.toUpperCase()} ${shortDateFormat.format(DateTime.now())}',
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 16,
        ),
      );
    }

    if (requestType != RequestType.paid) {
      return pw.Text(
        '${TabViewString.log_6.toUpperCase()} ${TabViewString.forDate.toUpperCase()} ${shortDateFormat.format(DateTime.now())}',
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 16,
        ),
      );
    }

    return pw.Text(
      '${TabViewString.log_5.toUpperCase()} ${TabViewString.forDate.toUpperCase()} ${shortDateFormat.format(dateList.first)}',
      textAlign: pw.TextAlign.center,
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  pw.Widget _requestsLogTable({
    required List<UserRequest> requestList,
    required int pageNumber,
  }) {
    /*
  
  ====================================

  DON'T USE SCREENUTIL FOR PW. WIDGETS

  ====================================

  */
    const headerRowHeight = 50.0;
    const rowHeight = 30.0;
    const fSize = 6.0;
    const insets = 4.0;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Container(
              height: headerRowHeight,
              width: 30,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logCode,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 50,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logJobType,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 50,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logRequestDate,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 50,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logResponseDate,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 100,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logOwner,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 50,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logAddress,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 30,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logFlatNumber,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 50,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logPhoneNumber,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 150,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logRequestDescription,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 50,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logStaff,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 55,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logRequestCloseDate,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 50,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logCloseOrShiftMark,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
              height: headerRowHeight,
              width: 50,
              child: pw.Center(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(insets),
                  child: pw.Text(
                    PrintString.logSign,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontSize: fSize,
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
        for (var request in requestList)
          pw.Row(
            children: [
              pw.Container(
                height: rowHeight,
                width: 30,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      '${request.requestNumber}',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  color: request.requestType == RequestType.failure
                      ? const PdfColor(0.8, 0.8, 0.8, 0.2)
                      : const PdfColor(1, 1, 1),
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 50,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      '${request.jobType}',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 50,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      shortDateFormat.format(request.requestDate!),
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 50,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      shortDateFormat.format(request.responseDate!),
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 100,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      request.userName!,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 50,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      request.address!,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 30,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      request.flatNumber!,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 50,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      '+7${request.phoneNumber}',
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 150,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      request.userRequest!,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 50,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      request.staffId ?? PrintString.logNoStaff,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 55,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 50,
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(insets),
                    child: pw.Text(
                      request.status!,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(fontSize: fSize),
                    ),
                  ),
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
              pw.Container(
                height: rowHeight,
                width: 50,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
              ),
            ],
          ),
        pw.SizedBox(height: 8.h),
        pw.Text(
          '${PrintString.logDate} ${shortDateFormat.format(DateTime.now())}, '
          '${PrintString.logOperator} ${widget.user.name ?? '________________________________'} '
          '/________________________________',
          textAlign: pw.TextAlign.left,
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Align(
          alignment: pw.Alignment.bottomRight,
          child: pw.Text(
            '${PrintString.logPage} $pageNumber',
            textAlign: pw.TextAlign.right,
            style: const pw.TextStyle(fontSize: 8),
          ),
        ),
      ],
    );
  }
}
