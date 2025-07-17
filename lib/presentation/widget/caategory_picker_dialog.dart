import 'package:flutter/material.dart';

class CategoryPickerDialog extends StatelessWidget {
  final String selected;
  const CategoryPickerDialog({required this.selected, Key? key})
    : super(key: key);

  //list of categories
  static final categories = [
    {
      'name': 'Grocery',
      'icon': Icons.local_grocery_store,
      'color': Colors.green,
    },
    {'name': 'Work', 'icon': Icons.work, 'color': Colors.orange},
    {'name': 'Sport', 'icon': Icons.fitness_center, 'color': Colors.teal},
    {'name': 'Home', 'icon': Icons.home, 'color': Colors.red},
    {'name': 'University', 'icon': Icons.school, 'color': Colors.blue},
    {'name': 'Social', 'icon': Icons.campaign, 'color': Colors.purple},
    {'name': 'Music', 'icon': Icons.music_note, 'color': Colors.pink},
    {'name': 'Health', 'icon': Icons.favorite, 'color': Colors.greenAccent},
    {'name': 'Movie', 'icon': Icons.movie, 'color': Colors.lightBlue},
  ];

  @override
  Widget build(BuildContext context) {
    //Category Dialog
    return Dialog(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.minPositive,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //text
            Text(
              "Choose Category",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            //for adding some space
            SizedBox(height: 16),

            //
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: categories.map((cat) {
                return GestureDetector(
                  onTap: () => Navigator.pop(context, cat['name']),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: cat['color'] as Color,
                        child: Icon(
                          cat['icon'] as IconData,
                          color: Colors.white,
                        ),
                      ),

                      //for adding some space
                      SizedBox(height: 4),

                      //
                      Text(
                        cat['name'] as String,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            //for adding some space
            SizedBox(height: 16),

            //add category button
            ElevatedButton(
              onPressed: () {}, // optional: implement "Add new category"
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
              ),
              child: Text("Add Category"),
            ),
          ],
        ),
      ),
    );
  }
}
