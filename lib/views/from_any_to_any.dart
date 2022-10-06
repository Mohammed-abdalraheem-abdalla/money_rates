import 'package:currencies/core/utils/equations.dart';
import 'package:flutter/material.dart';

class AnyToAny extends StatefulWidget {
  final Map rates;
  final Map currencies;
  const AnyToAny({Key? key, required this.rates, required this.currencies}) : super(key: key);

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();
  String firstListVale = 'USD';
  String secondListValue = 'SDG';
  String result = 'the result';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 80,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('From any currency to another',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 15),
            TextFormField(
              key: const ValueKey('amount'),
              controller: amountController,
              decoration: const InputDecoration(hintText: 'Enter amount'),
              keyboardType: TextInputType.number
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                      value: firstListVale,
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      isExpanded: true,
                      underline: Container(
                        color: Colors.grey.shade300,
                        height: 4,
                      ),
                      items: widget.currencies.keys
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),

                      onChanged: (String? newListValue){
                        setState(()=> firstListVale = newListValue!);
                      },
                    ),
                ),
                const SizedBox(width: 5,),
                // second dropdown list
                Expanded(
                  child: DropdownButton<String>(
                    value: secondListValue,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    isExpanded: true,
                    underline: Container(
                      color: Colors.grey.shade300,
                      height: 4,
                    ),
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),

                    onChanged: (String? newListValue){
                      setState(()=> secondListValue = newListValue!);
                    },
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: (){
                    setState(() => result =
                    '${amountController.text} $firstListVale ='
                        ' ${anyToAnyEq(widget.rates, amountController.text, firstListVale, secondListValue)}'
                        ' $secondListValue'
                    );
                  },
                  child: const Text('Convert'),
                  /// style the button
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(result,style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
