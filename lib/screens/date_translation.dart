import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateTranslation extends StatefulWidget {
  const DateTranslation({super.key});

  @override
  State<DateTranslation> createState() => _DateTranslationState();
}

class _DateTranslationState extends State<DateTranslation> {
  bool isAdtoBs = true;
  DateTime? selectedAdDate;
  NepaliDateTime? selectedBsDate;
  String convertedDate = '';

  void convertDate() {
    setState(() {
      if (isAdtoBs && selectedAdDate != null) {
        convertedDate = selectedAdDate!.toNepaliDateTime().toString();
      } else if (!isAdtoBs && selectedBsDate != null) {
        convertedDate = selectedBsDate!.toDateTime().toString();
      } else {
        convertedDate = "select a date first";
      }
    });
  }

  Future<void> pickAdDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1944),
      lastDate: DateTime(2090),
    );
    if (picked != null) {
      setState(() {
        selectedAdDate = picked;
      });
    }
  }

  Future<void> pickBsDate() async {
    final picked = await showMaterialDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2090),
    );
    if (picked != null) {
      setState(() {
        selectedBsDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text(
          AppLocalizations.of(context)!.dateTrasnlator,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.brown,
          ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              elevation: WidgetStatePropertyAll(2),
              backgroundColor: WidgetStatePropertyAll(Colors.blue),
            ),
            onPressed: () {
              setState(() {
                isAdtoBs = !isAdtoBs;
              });
            },
            child: Text(
              isAdtoBs ? "Switch BS To AD" : "Switch AD To BS",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              isAdtoBs
                  ? AppLocalizations.of(context)!.adtobs
                  : AppLocalizations.of(context)!.bstoad,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: isAdtoBs ? pickAdDate : pickBsDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText:
                      isAdtoBs
                          ? AppLocalizations.of(context)!.addate
                          : AppLocalizations.of(context)!.bsdate,
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  isAdtoBs
                      ? (selectedAdDate != null
                          ? selectedAdDate.toString().split(' ')[0]
                          : AppLocalizations.of(context)!.selectdate)
                      : (selectedBsDate != null
                          ? NepaliDateFormat.yMMMMd().format(selectedBsDate!)
                          : AppLocalizations.of(context)!.selectdate),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(onPressed: convertDate, child: Text(AppLocalizations.of(context)!.translation)),
            SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.translateddate,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SelectableText(
              convertedDate,
              style: TextStyle(fontSize: 20, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
