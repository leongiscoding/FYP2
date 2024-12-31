import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ModelService {
  late Interpreter _interpreter;

  // Load the TFLite model from assets
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model_fruit_v2.tflite');
      print('Model load success');
    } catch (e) {
      print('Error loading model: $e');
      throw Exception('Failed to load model');
    }
  }

  // Pick image from gallery, process, and make prediction
  Future<Map<String, dynamic>?> pickImage() async {
    try {
      final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile == null) return null;

      final imagePath = imageFile.path;
      final image = File(imagePath);
      final processedImage = await processImage(image);

      if (processedImage != null) {
        // Prepare input tensor
        var input = processedImage.buffer.asFloat32List().reshape([1, 32, 32, 3]);

        // Prepare output buffer for model output
        var output = List.filled(1 * 6, 0.0).reshape([1, 6]);

        // Run inference
        _interpreter.run(input, output);

        print('Output: $output');

        // Get the index of the most probable fruit from the model output
        int maxIndex = getMaxConfidenceIndex(output[0]);

        // Get the predicted label and confidence
        final predictedLabel = getLabel(maxIndex);
        final confidence = (output[0][maxIndex] * 100).toStringAsFixed(2);

        return {
          'imagePath': imagePath,
          'predictedLabel': predictedLabel,
          'calories': getCalorieEstimate(predictedLabel),
          'confidence': confidence,
        };
      }
    } catch (e) {
      print('Error processing image: $e');
      throw Exception('Error processing image');
    }
  }

  // Process the image to fit model input
  Future<Float32List> processImage(File image) async {
    try {
      // Load image and decode it using 'image' package
      final img.Image? imageData = img.decodeImage(image.readAsBytesSync());
      if (imageData == null) throw Exception('Failed to decode image');

      // Resize image to 32x32
      final img.Image resizedImage = img.copyResize(imageData, width: 32, height: 32);

      // Convert image to Float32List and normalize pixel values
      final Float32List imageAsList = Float32List(32 * 32 * 3);
      int index = 0;

      for (int y = 0; y < 32; y++) {
        for (int x = 0; x < 32; x++) {
          final pixel = resizedImage.getPixel(x, y);
          imageAsList[index++] = (img.getRed(pixel).toDouble());
          imageAsList[index++] = (img.getGreen(pixel).toDouble());
          imageAsList[index++] = (img.getBlue(pixel).toDouble());
        }
      }

      return imageAsList;
    } catch (e) {
      print('Error in processImage: $e');
      throw Exception('Image processing failed');
    }
  }

  int getMaxConfidenceIndex(List<double> output) {
    double maxConfidence = output[0];
    int maxIndex = 0;

    for (int i = 1; i < output.length; i++) {
      if (output[i] > maxConfidence) {
        maxConfidence = output[i];
        maxIndex = i;
      }
    }
    return maxIndex;
  }

  String getLabel(int index) {
    const labels = ['Apple', 'Banana','Carrot','Cucumber', 'Orange','Unknown']; // Add more fruits as needed
    return labels[index];
  }

  String getCalorieEstimate(String fruitName) {
    final Map<String, String> calorieData = {
      'Apple': '95',
      'Banana': '105',
      'Carrot': '41',
      'Cucumber': '45',
      'Orange': '62',
      'Unknown': '0',
    };
    return calorieData[fruitName] ?? 'Unknown';
  }

  void dispose() {
    _interpreter.close();
  }
}
