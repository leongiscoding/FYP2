import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fyp2/component/main_page/drawer.dart';
import 'package:fyp2/page/resultPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../ml/calorie_estimator.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ModelService _modelService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _modelService = ModelService();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      await _modelService.loadModel();
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  Future<void> _pickImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _modelService.pickImage();
      if (result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              imagePath: result['imagePath'],
              fruitName: result['predictedLabel'],
              calories: result['calories'],
            ),
          ),
        );
      }
    } catch (e) {
      print('Error processing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error processing image. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _modelService.dispose();
    super.dispose();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Colors.transparent,
        title:  Text(
          "EzScan",
          style: GoogleFonts.dmSerifText(
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary
            ),
          ),
        ),
      ),
      drawer: const MyDrawer(),

      body: Stack(
        children: [
          //R E S U L T   L I S T   V I E W

          //F I X E D    B U T T O N
          Positioned(
            bottom: 0, left: 0, right: 0,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    padding: EdgeInsets.all(10.0),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  //PERFORM USER UPLOAD IMAGE, AND ESTIMATE CALORIE BY TRAINED MODEL
                  onPressed: _pickImage,
                  child: Text(
                      "Estimate Calorie",
                      style: GoogleFonts.dmSerifText(fontSize: 16),
                  ),
                ),
              ),
          ),

        ],
      ),
    );
  }
}
