import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyp2/component/main_page/drawer.dart';
import 'package:fyp2/controller/model_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final CalorieEstimator _estimator = CalorieEstimator();
  final List<FruitResult> _results = [];
  bool _isProcessing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeEstimator();
  }

  Future<void> _initializeEstimator() async {
    try {
      await _estimator.initializeModel();
      print('CalorieEstimator initialized successfully.');
    } catch (e) {
      print('Error initializing CalorieEstimator: $e');
    }
  }


  //Function to pick and process image
  Future<void> _processImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      setState(() => _isProcessing = true);

      // Pick image
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        _showMessage('No image selected');
        return;
      }

      final File imageFile = File(image.path);

      // Process image with the model
      final result = await _estimator.predict(imageFile);

      if (result != null && result['fruitName'] != null) {
        // Save image to app directory for persistence
        final Directory appDir = await getApplicationCacheDirectory();
        final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final File localImage = await imageFile.copy('${appDir.path}/$fileName');

        setState(() {
          _results.insert(
            0,
            FruitResult(
              imagePath: localImage.path,
              fruitName: result['fruitName'] ?? 'Unknown Fruit',
              calories: result['calories'] ?? 'Unknown kcal',
            ),
          );
        });
      } else {
        _showMessage('Fruit not recognized. Please try again with a different image');
      }
    } catch (e) {
      _showMessage('Error processing image: $e');
      print('Detailed error: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }



  void _showMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  void dispose(){
    _estimator.close();
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
          Positioned.fill(
              child: _results.isEmpty
                  ? Center(
                child: Text(
                  'No scanned fruits yet\nTap "Estimate Calorie" to begin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: _results.length,
                  itemBuilder: (context,index){
                  final result = _results[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(result.imagePath),
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        result.fruitName,
                        style: GoogleFonts.dmSerifText(),
                      ),
                      subtitle: Text(
                        result.calories,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  );
                  }
              ),
          ),

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
                  onPressed: _isProcessing ? null : _processImage,
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

class FruitResult{
  final String imagePath;
  final String fruitName;
  final String calories;

  FruitResult({
    required this.imagePath,
    required this.fruitName,
    required this.calories
});
}