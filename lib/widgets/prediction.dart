import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/colors/colors.dart';
import 'package:late_blight/services/conveter.dart';
import 'package:late_blight/utils/lang_utils.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SectionPrediction extends StatelessWidget {
  final double probability;
  final double radius;
  final double height;
  const SectionPrediction({
    super.key,
    required this.probability,
    this.radius = 55,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    // List<String> suggestionsList = [
    //   "आधारभूत सावधानीहरूलाई प्राथमिकता दिन महत्त्वपूर्ण छ। मौसम पूर्वानुमान अनुगमन, विशेष गरी तापक्रम र आर्द्रता स्तर, अचानक परिवर्तनहरूको लागि सक्रिय तत्परताको सुविधा दिन्छ। स्पेसिङ, आर्द्रता नियमन, र भेन्टिलेसन सहित लगातार बाली मर्मत, अपेक्षाकृत कम जोखिमको यस अवधिमा सम्भावित रोग जोखिमहरूलाई प्रभावकारी रूपमा कम गर्छ।",
    //   "मध्यवर्ती सावधानीहरू खेलमा आउँछन्। ढिलो ब्लाइटको शुरुवात वा फैलावटलाई रोक्नको लागि पूर्वानुमानको आधारमा निवारक फङ्गिसाइड अनुप्रयोगहरू विचार गर्नुहोस्। यस अवधिमा अधिक बारम्बार बिरुवा निरीक्षणहरू मार्फत उच्च सतर्कता महत्त्वपूर्ण हुन्छ, रोगका लक्षणहरू प्रकट हुन थालेमा प्रारम्भिक पत्ता लगाउन र द्रुत कारबाही गर्न अनुमति दिँदै।",
    //   "उच्च जोखिम चरणहरूमा, उन्नत सावधानीहरू महत्त्वपूर्ण छन्। पत्ता लागेपछि द्रुत क्वारेन्टाइन उपायहरूले रोग फैलिनबाट रोक्छ। आक्रामक फङ्गिसाइड प्रयोग, प्रभावित क्षेत्रहरूलाई अलग गर्ने, र फसल रणनीतिहरू समायोजन सहित एक तयार गरिएको आपतकालीन योजनाले अप्रभावित बालीहरूलाई बचाउँछ। समयमै र निर्णायक कार्यहरूले यस उच्च जोखिम चरणमा ढिलो ब्लाइटको गम्भीर प्रभावलाई उल्लेखनीय रूपमा कम गर्छ।",
    // ];
    return BlocBuilder<LanguageBloc, AppLanguage>(
      builder: (context, language) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                YajnaLocalization.diseaseProbability[language.name].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
            ),
            Card(
              color: cardColor,
              elevation: 3,
              surfaceTintColor: cardColor,
              shadowColor: cardColor,
              child: Container(
                height: height,
                width: Size.infinite.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularPercentIndicator(
                        radius: radius,
                        lineWidth: 10.0,
                        percent: probability,
                        center: Text(
                          language == AppLanguage.en
                              ? ("${(probability * 100).toStringAsFixed(2)}%")
                              : ("${toNepali(probability * 100)}%"),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        progressColor: probability > 0.4
                            ? probability > 0.7
                                ? Colors.red
                                : Colors.orange
                            : Colors.green,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          YajnaLocalization.indicationDescription[language.name]
                              .toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
