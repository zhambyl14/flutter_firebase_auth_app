import 'package:flutter/material.dart';
import '/bottom_nav_bar.dart'; // Подключаем виджет нижней навигационной панели
import 'Board.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), 
                            side: BorderSide(color: Colors.black, width: 2), 
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Минимизируйте ширину столбца
                            children: [
                              Image.asset('assets/Group.png', height: 30, width: 30), // Иконка
                              SizedBox(height:0), // Добавьте немного пространства между иконкой и текстом
                              Text('50', style: TextStyle(color: Colors.black, fontFamily: 'Times New Roman', fontSize: 10)), // Текст
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '50', // Текст "Player"
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman'),
                          ),
                          SizedBox(width: 5.0),
                          Image.asset('assets/tiyn.png', height: 24, width: 24),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Perform another action specific to the user
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Установите радиус скругления 5
                            side: BorderSide(color: Colors.black, width: 2), // Добавьте рамку черного цвета и шириной 2
                          ),
                          
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Минимизируйте ширину столбца
                            children: [
                              Image.asset('assets/sandyq.png', height: 30, width: 30), // Иконка
                              SizedBox(height: 0), // Добавьте немного пространства между иконкой и текстом
                              Text('CLAIM', style: TextStyle(color: Colors.black, fontFamily: "'Times New Roman'", fontSize: 10)), // Текст
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  'Puzzle\nEscape', // Replace with user's name
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: "'Times New Roman'"),
                ),
              ),
              SizedBox(height: 16.0),
              // Add buttons or actions for user-specific features
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the Board screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Board()),
                    );
                  },
                  style:ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // Удалите стандартный отступ
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Установите радиус скругления 5
                      side: BorderSide(color: Colors.black, width: 2), // Добавьте рамку черного цвета и шириной 2
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Добавьте отступы для текста
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Минимизируйте ширину столбца
                      children: [
                        SizedBox(height: 10), // Добавьте немного пространства между иконкой и текстом
                        Text('Jigsaw Puzzle', style: TextStyle(fontSize: 22.0, color: Colors.black, fontFamily: 'Times New Roman'),), // Текст
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2), // Добавляем нижнюю навигационную панель
    );
  }
}

