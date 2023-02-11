import 'package:flutter/material.dart';
import 'package:labelapp/pages/details.dart';
import 'package:labelapp/task.dart';
class Tasks extends StatelessWidget {
  final tasksList = Task.generateTasks();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        itemCount: tasksList.length ,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
          itemBuilder: ((context, index) => 
            _buildTask(context, tasksList[index]
          )),
      )
    );
  }

  Widget _buildTask(BuildContext context, Task task){
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: task.bgcolor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            task.iconData,
            color: task.iconColor,
            size: 35
          ),
          SizedBox(height: 30),
          Text(
            task.title!,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 20),
          Row(
            children: [
              _detailsButton(context, task.btnColor!, task.iconColor!, 'View Details', task.title!),
              SizedBox(width: 5,)
            ]
          ),
        ],
      ),
    );
  }

  Widget _detailsButton(BuildContext context,Color bgColor, Color txtColor, String text, String taskTitle){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Detail(message: taskTitle,);
          },),);
        },
        child: Text(
          text,
          style: TextStyle(color: txtColor),
        ),
      ),
    );
  }
}
