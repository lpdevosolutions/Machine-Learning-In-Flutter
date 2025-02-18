import 'package:flutter/services.dart' show rootBundle;
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final rawCsvContent = await rootBundle.loadString('assets/diabetes.csv');
//   final samples = DataFrame.fromRawCsv(rawCsvContent);
//   final targetColumnName = 'Outcome';
//   final splits = splitData(samples, [0.7]);
//   final validationData = splits[0];
//   final testData = splits[1];
//   final validator = CrossValidator.kFold(validationData, numberOfFolds: 6);
//   createClassifier(DataFrame samples) =>
//       LogisticRegressor(
//         samples,
//         targetColumnName,
//       );
//   final scores = await validator.evaluate(createClassifier, MetricType.accuracy);
//   final accuracy = scores.mean();

//   print('accuracy on k fold validation: ${accuracy.toStringAsFixed(2)}');

//   final testSplits = splitData(testData, [0.8]);
//   final classifier = createClassifier(testSplits[0]);
//   final finalScore = classifier.assess(testSplits[1], MetricType.accuracy);

//   print(finalScore.toStringAsFixed(2));

//   final appDocumentsDirectory = await getApplicationDocumentsDirectory();
//   final classifierFilePath = File('${appDocumentsDirectory.path}/classifier.json');
//   print('Classifier file path: ${classifierFilePath.path}');
//   try {
//     await classifier.saveAsJson(classifierFilePath.path);
//   } catch (e) {
//     print('Error saving classifier: $e');
//   }
// }

 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final encodedModel = await rootBundle.loadString('assets/classifier.json');

  final classifier = LogisticRegressor.fromJson(encodedModel);

  final data = [
    ['Pregnancies','Glucose','BloodPressure','SkinThickness','Insulin','BMI','DiabetesPedigreeFunction','Age'],
    [6,148,72,35,0,33.6,0.627,50],
    [1,85,66,29,0,26.6,0.351,31]
  ];
  
  final datafame = DataFrame(data);

  final prediction = classifier.predict(datafame); 

  print(prediction.header); 
  print(prediction.rows); 
}