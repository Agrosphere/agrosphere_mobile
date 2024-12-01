import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'रोगको जानकारी',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Image.asset(
              'assets/late_blight.png', // Replace with your image path
              width: 350,
              height: 300,
            ),
            const Text(
              'रोगको जानकारी',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'डडुवा रोग, वैज्ञानिक रूपमा Phytophthora infestans भनेर चिनिन्छ, एक विनाशकारी र अत्यधिक विनाशकारी बिरुवा रोग हो जसले मुख्य रूपमा Solanaceae परिवार, विशेष गरी टमाटर र आलुलाई असर गर्छ। यो रोग 1840 को आयरिश आलु अनिकालमा यसको भूमिकाको लागि कुख्यात छ, जसले आयरल्याण्डको जनसंख्यामा व्यापक फसल विफलताको कारण विनाशकारी परिणामहरू ल्यायो। डडुवा एक फंगल-जस्तै oomycete रोगजनक हो जुन चिसो, भिजेको अवस्थामा, विशेष गरी 10°C देखि 25°C (50°F देखि 77°F) को बीचमा उच्च आर्द्रता वा आर्द्रतामा फस्टाउँछ। रोगजनकले बोटको पात र डाँठ दुवैलाई संक्रमित गर्न सक्छ र छिटो र गम्भीर क्षति पुर्याउन सक्छ।',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'रोगको अनुकूल अवस्था',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '10°C देखि 25°C (50°F देखि 77°F) सम्मको चिसो तापक्रममा फस्टाउँछ। फैलावटको लागि उच्च आर्द्रता वा आर्द्र अवस्था चाहिन्छ। वर्षा वा सिँचाइको कारणले लामो समयसम्म पात ओसिलो हुनु रोग फैलाउन मद्दत गर्दछ। टमाटर र आलु जस्ता Solanaceae परिवारका बिरुवाहरू अत्यधिक संवेदनशील हुन्छन्। हावा, पानी, वा संक्रमित बिरुवा सामाग्री द्वारा बोकेको बीजाणु मार्फत फैलिन्छ। अत्यधिक भीड रोपण वा खराब वायु प्रवाहले अनुकूल सूक्ष्म वातावरण सिर्जना गर्दछ',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'रोकथाम',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'प्रतिरोधी बिरुवा प्रजातिहरू छनौट गर्नुहोस्। वार्षिक रूपमा बाली घुमाउनुहोस्। संक्रमित बिरुवा सामग्री तुरुन्तै हटाउनुहोस्। रोग फैलिनबाट रोक्नको लागि बगैंचामा औजारहरू सफा गर्नुहोस्। रोगका लक्षणहरूको लागि नियमित रूपमा बिरुवाहरू निरीक्षण गर्नुहोस्। हावा प्रवाहको लागि पर्याप्त बिरुवा दूरी कायम राख्नुहोस्। पात ओसिलो हुनबाट जोगिन आधारमा बिरुवाहरूलाई पानी दिनुहोस्। आवश्यक पर्दा रोकथाम उपायको रूपमा फङ्गिसाइडहरू प्रयोग गर्नुहोस्। पानी जम्नबाट जोगिनको लागि उचित जल निकासी सुनिश्चित गर्नुहोस्। लेट ब्लाइट अनुकूल मौसम अवस्थाहरू निगरानी गर्नुहोस्। रोकथाम र व्यवस्थापन रणनीतिहरूमा आफैलाई शिक्षित गर्नुहोस्।',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
