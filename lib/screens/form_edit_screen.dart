// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_db/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_db/models/transactions.dart';

class FormEditScreen extends StatefulWidget {
  final Transactions data;

  //Controller

  const FormEditScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<FormEditScreen> createState() => _FormEditScreenState();
}

class _FormEditScreenState extends State<FormEditScreen> {
  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  void initState() {
    super.initState();
    idController.text = widget.data.id.toString();
    titleController.text = widget.data.title.toString();
    amountController.text = widget.data.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มแก้ไขข้อมูล'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      enabled: false,
                      style: const TextStyle(color: Colors.black54),
                      decoration: const InputDecoration(labelText: "Item ID"),
                      autofocus: false,
                      controller: idController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Item Name"),
                      autofocus: false,
                      controller: titleController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Item Name.";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Price"),
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      validator: (String? str) {
                        if (str!.isEmpty) {
                          return "Please input Price.";
                        }
                        if (double.parse(str) <= 0) {
                          return "Please input Price more than 0.";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        style: style,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var id = int.parse(idController.text);
                            var title = titleController.text;
                            var amount = double.parse(amountController.text);

                            // call provider
                            var provider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            Transactions item = Transactions(
                                id: id,
                                title: title,
                                amount: amount,
                                date: widget.data.date);
                            provider.updateTransaction(item);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Save data"))
                  ]),
            )));
  }
}
