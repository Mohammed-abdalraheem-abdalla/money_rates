import 'package:currencies/core/utils/equations.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final Map rates;
  final Map currencies;
  const UsdToAny({Key? key, required this.rates, required this.currencies}) : super(key: key);

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController usdController = TextEditingController();
  String listValue = 'SDG';
  String result = 'the result';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children:  [
             const Text(
                'USD to any Currency',
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 24)
              ),
              const SizedBox(height: 10,),
            TextFormField(
              key: const ValueKey('USD'),
              controller: usdController,
              decoration: const InputDecoration(hintText: 'Enter amount'),
              keyboardType: TextInputType.number,
            ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                      child: DropdownButton<String>(
                        value: listValue,
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
                          setState(()=> listValue = newListValue!);
                        },
                      ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                      onPressed: (){
                        setState(() => result =
                        '${usdController.text} dollars ='
                            ' ${usdEq(widget.rates, usdController.text, listValue)} '
                            ' $listValue'
                        );
                      },
                      child: const Text('Convert'),
                    /// style the button
                  ),
                ],
              ),
              const SizedBox(height: 10),
               Text(result, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
            ],
          ),
        ),
    );
  }
}
