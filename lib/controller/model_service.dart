import 'dart:io';
import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';
import 'package:flutter/services.dart';

class CalorieEstimator {
  Interpreter? _interpreter;
  late List<String> _labels;
  final int _inputSize = 32;
  late ImageProcessor _imageProcessor;

  CalorieEstimator() {
    initializeModel();
  }

  /// Initialize the model, labels, and image processor
  Future<void> initializeModel() async {
    try {
      // Load TFLite model
      _interpreter = await Interpreter.fromAsset('model.tflite');

      // Load labels
      final labelsData = await rootBundle.loadString('assets/labels.txt');
      _labels = labelsData.split('\n')..removeWhere((label) => label.trim().isEmpty);

      // Initialize image processor for resizing and normalization
      _imageProcessor = ImageProcessorBuilder()
          .add(ResizeOp(_inputSize, _inputSize, ResizeMethod.nearestneighbour))
          .add(NormalizeOp(0.0, 255.0)) // Normalize to [0, 1] range
          .build();

      print('Model and labels initialized successfully.');
    } catch (e, stackTrace) {
      print('Error initializing model: $e');
      print('Stack trace: $stackTrace');
      _labels = [];
      _interpreter = null;
    }
  }

  /// Prepares an image for model input
  TensorImage _preprocessImage(File imageFile) {
    final inputImage = TensorImage.fromFile(imageFile);
    return _imageProcessor.process(inputImage);
  }

  /// Runs inference and returns the predicted fruit and calorie estimate
  Future<Map<String, dynamic>?> predict(File imageFile) async {
    if (_interpreter == null) {
      print('Model not initialized.');
      return null;
    }

    try {
      // Preprocess the image
      final tensorImage = _preprocessImage(imageFile);

      // Convert the TensorImage to a ByteBuffer for model input
      final inputBuffer = tensorImage.tensorBuffer.getBuffer();

      // Prepare output buffer
      final outputBuffer = TensorBuffer.createFixedSize([1, 3], TensorType.float32);

      // Run inference
      _interpreter!.run(inputBuffer, outputBuffer.buffer);

      // Get probabilities
      final probabilities = outputBuffer.getDoubleList();
      print('Raw output: $probabilities');

      // Find the highest confidence and corresponding index
      final maxProbability = probabilities.reduce((a, b) => a > b ? a : b);
      final maxIndex = probabilities.indexOf(maxProbability);

      if (maxProbability < 0.5) {
        print("Low confidence prediction: $maxProbability");
        return null;
      }

      final predictedFruit = _labels[maxIndex];
      final calorieEstimate = _getCalorieEstimate(predictedFruit);

      return {
        'fruitName': predictedFruit,
        'calories': calorieEstimate,
        'confidence': maxProbability,
      };
    } catch (e, stackTrace) {
      print("Error during prediction: $e");
      print("Stack trace: $stackTrace");
      return null;
    }
  }

  /// Provides calorie estimates for detected fruits
  String _getCalorieEstimate(String fruitName) {
    const calorieMap = {
      'apple': '95 kcal',
      'banana': '105 kcal',
      'orange': '62 kcal',
    };
    return calorieMap[fruitName] ?? 'Unknown kcal';
  }

  /// Close the interpreter
  void close() {
    _interpreter?.close();
    _interpreter = null;
  }
}
