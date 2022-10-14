// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_db/models/transactions.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //Controller
  final titleController = TextEditingController();
  final title2Controller = TextEditingController();
  final title3Controller = TextEditingController();
  final amountController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มบันทึกข้อมูล'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Name"),
                      autofocus: false,
                      controller: titleController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Name.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Surname"),
                      autofocus: false,
                      controller: title2Controller,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Surname.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Sex"),
                      autofocus: false,
                      controller: title3Controller,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Sex.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Age"),
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Age.";
                        }
                        if (double.parse(str) <= 0) {
                          return "Please input Age more than 0.";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        style: style,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var title = titleController.text;
                            var title2 = title2Controller.text;
                            var title3 = title3Controller.text;
                            var amount = int.parse(amountController.text);

                            // call provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            Transactions item = Transactions(
                                title: title,
                                title2: title2,
                                title3: title3,
                                amount: amount,
                                date: DateFormat('yyyy-MM-dd - kk:mm:ss')
                                    .format(DateTime.now()));
                            provider.addTransaction(item);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Add data"))
                  ]),
            )));
  }
}
