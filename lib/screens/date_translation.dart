import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:timeago/timeago.dart';

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
        convertedDate =
            NepaliDateTime.fromDateTime(
              selectedBsDate!.toNepaliDateTime(),
            ).toString();
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
    final picked = await showDatePicker(
      context: context,
      initialDate: NepaliDateTime.now(),
      firstDate: NepaliDateTime(2000),
      lastDate: NepaliDateTime(2090),
    );
    if (picked != null) {
      setState(() {
        selectedBsDate = NepaliDateTime.fromDateTime(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text(
          "Nepali Date Traslator",
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
                  ? "AD मितिलाई BS मा रूपान्तरण गर्नुहोस्"
                  : "BS मितिलाई AD मा रूपान्तरण गर्नुहोस्",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: isAdtoBs ? pickAdDate : pickBsDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: isAdtoBs ? "AD Date Here" : "BS Date Here",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  isAdtoBs
                      ? (selectedAdDate != null
                          ? selectedAdDate.toString().split(' ')[0]
                          : 'मिति चयन गर्नुहोस्')
                      : (selectedBsDate != null
                          ? NepaliDateFormat.yMMMMd().format(selectedBsDate!)
                          : 'मिति चयन गर्नुहोस्'),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(onPressed: convertDate, child: Text("Translation")),
            SizedBox(height: 24),
            Text(
              "Translated Date Here",
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
