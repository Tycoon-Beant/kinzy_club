import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<String> items = ["Recent", "A Week Ago", "A Month Ago", "Custom"];
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6c5ce7),
        leading: const Icon(
          FontAwesomeIcons.clipboardList,
          color: Colors.white,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Add your logout functionality here
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      // Add your add task functionality here
                    },
                    child: const Text(
                      "Add Task",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Search: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            isDense: true, // Adjust height
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Sort By: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButton<String>(
                        value: selectedItem,
                        hint: const Text("Select an option"),
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16),
                        underline: Container(
                          height: 2,
                          color: Colors.purple,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItem = newValue;
                          });
                        },
                        items: items
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      width: 370,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            color: Theme.of(context).colorScheme.primary,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "TODO",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.maxFinite,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Task 3",
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "Description 3",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Created at: 01/09/2024 , 05:30:00",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {},
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          EditTask(context);
                                        },
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).colorScheme.primary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          ViewDetails(context);
                                        },
                                        child: Text(
                                          "View Detail",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.maxFinite,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Task 1",
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "Description 1",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Created at: 01/09/2021 , 05:30:00",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {},
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          EditTask(context);
                                        },
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).colorScheme.primary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          ViewDetails(context);
                                        },
                                        child: Text(
                                          "View Detail",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.maxFinite,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Task 2",
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "Description 2",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Created at: 01/09/2021 , 05:30:00",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {},
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {},
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).colorScheme.primary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {},
                                        child: Text(
                                          "View Detail",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                      const SizedBox(width: 20),
                            Container(
                padding: const EdgeInsets.all(16.0),
                height: 659,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      color: Theme.of(context).colorScheme.primary,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "IN PROGRESS",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Container(
                      width: double.maxFinite,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Task 4", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 12),
                            const Text("Description 1",style: TextStyle(fontSize: 14),),
                            const SizedBox(height: 20),
                            const Text("Created at: 01/09/2021 , 05:30:00" , style: TextStyle(fontSize: 12),),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  onPressed:(){},
                                 child: Text("Delete",style: TextStyle(color: Colors.white,),),),
                                 const SizedBox(width: 8),
                                 ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  onPressed:(){},
                                 child: Text("Edit",style: TextStyle(color: Colors.white,),),),
                                 const SizedBox(width: 8),
                                 ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  onPressed:(){},
                                 child: Text("View Detail",style: TextStyle(color: Colors.white,),),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      
                      width: double.maxFinite,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Task 5", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 12),
                            const Text("Description 2",style: TextStyle(fontSize: 14),),
                            const SizedBox(height: 20),
                            const Text("Created at: 01/09/2021 , 05:30:00" , style: TextStyle(fontSize: 12),),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  onPressed:(){},
                                 child: Text("Delete",style: TextStyle(color: Colors.white,),),),
                                 const SizedBox(width: 8),
                                 ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  onPressed:(){},
                                 child: Text("Edit",style: TextStyle(color: Colors.white,),),),
                                 const SizedBox(width: 8),
                                 ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  onPressed:(){},
                                 child: Text("View Detail",style: TextStyle(color: Colors.white,),),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                padding: const EdgeInsets.all(16.0),
                height: 659,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      color: Theme.of(context).colorScheme.primary,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "DONE",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.maxFinite,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Task 6", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 12),
                            const Text("Description 2",style: TextStyle(fontSize: 14),),
                            const SizedBox(height: 20),
                            const Text("Created at: 01/09/2021 , 05:30:00" , style: TextStyle(fontSize: 12),),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  onPressed:(){},
                                 child: Text("Delete",style: TextStyle(color: Colors.white,),),),
                                 const SizedBox(width: 8),
                                 ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  onPressed:(){
                                    EditTask(context);
                                  },
                                 child: Text("Edit",style: TextStyle(color: Colors.white,),),),
                                 const SizedBox(width: 8),
                                 ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  onPressed:(){
                                    ViewDetails(context);
                                  },
                                 child: Text("View Detail",style: TextStyle(color: Colors.white,),),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                            ),
                          
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ViewDetails(BuildContext context) {
    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Task Details"),
                content: SizedBox(
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Task 6", style: TextStyle(fontSize: 16),),
                      Text("Description : Description 6", style: TextStyle(fontSize: 14),),
                      Text("Created at: 01/09/2021 , 05:30:00 ", style: TextStyle(fontSize: 12),),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff6c5ce7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close", style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          );
  }

 Future<dynamic> EditTask(BuildContext context) {
    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Edit Task"),
                content: SizedBox(
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title", style: TextStyle(fontSize: 16),),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Task 6",
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 16)
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Description ", style: TextStyle(fontSize: 14),),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Description 6",
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 170, 170, 171),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Save", style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 124, 124, 125),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel", style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          );
  }


}


