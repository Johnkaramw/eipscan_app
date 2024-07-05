import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eipscan_app/NotificationPage.dart';
import 'package:eipscan_app/SettingScreen.dart';
import 'package:eipscan_app/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Information Page',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: InformationPage(),
    );
  }
}

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Color.fromARGB(255, 255, 229, 216),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 229, 216),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize
                    .min, // To make the row take the size of its contents only
                children: [
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Disease Information ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 14.0,
                            color: Color.fromARGB(149, 239, 236, 236),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              customButton(context, 'Melanoma'),
              customButton(context, 'Melanocytes'),
              customButton(context, 'Dermatofibroma'),
              customButton(context, 'Actinic keratosis'),
              customButton(context, 'Pyogenic granuloma'),
              customButton(context, 'Basal cell carcinoma'),
              customButton(context, 'Seborrhoeic keratosis'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customButton(BuildContext context, String title) {
  return Container(
    width: 400,
    height: 60,
    margin: const EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      onPressed: () {
        if (title == 'Seborrhoeic keratosis') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeborrhoeicKeratosisPage()));
        } else if (title == 'Melanocytes') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'Melanocytes')));
        } else if (title == 'Melanoma') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MelanomaPage()));
        } else if (title == 'Basal cell carcinoma') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BasalCellCarcinomaPage()));
        } else if (title == 'Pyogenic granuloma') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PyogenicGranulomaPage()));
        } else if (title == 'Dermatofibroma') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DermatofibromaPage()));
        } else if (title == 'Actinic keratosis') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ActinicKeratosisPage()));
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromARGB(255, 134, 132, 132);
            }
            return const Color.fromARGB(255, 204, 141, 47);
          },
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class SeborrhoeicKeratosisPage extends StatelessWidget {
  final Map<String, String> buttonInfoMap = {
    'Definition':
        'Seborrheic keratosis is a harmless warty spot that appears during adult life as a common sign of skin aging.  Some people have hundreds of them .Includes the following related scaly skin lesions•Seborrheic keratosis.•Solar lentigo (which is difficult to distinguish from flat seborrheic keratosis).•Lichen planus such as keratosis (which arises from seborrheic keratosis or solar lentigo).',
    'Who Get':
        '●Who gets seborrheic keratosis? It is estimated that more than 90% of adults over the age of 60 have one or more of these symptoms.  It occurs in males and females of all races, and usually begins to appear in the 30s or 40s.  It is uncommon for them to be younger than 20 years old.',
    'Reasons':
        'Seborrheic keratosis occurs when skin cells, known as keratinocytes, multiply rapidly, resulting in a non-cancerous growth. This can occur in people with a family history of the condition, or it may affect people who have spent a significant amount of time in the sun and Skin friction may be the reason they appear in body folds. ',
    'Treatment':
        'An individual seborrhoeic keratosis can easily be removed if desired. Reasons for removal may be that it is unsightly, itchy, or catches on clothing.Methods used to remove seborrhoeic keratoses include: •Cryotherapy (liquid nitrogen) for thinner lesions (repeated if necessary).•Curettage and/or electrocautery.•Ablative laser surgery.•Shave biopsy (shaving off with a scalpel).•Focal chemical peel with trichloracetic acid .',
  };

  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    double buttonWidth = MediaQuery.of(context).size.width * 0.7;
    double buttonSpacing = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 229, 216),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 109, 109),
        title: Text(
          'Seborrhoeic keratosis',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 255, 158, 13).withOpacity(0.5),
              ),
              Shadow(
                offset: Offset(-1.0, -1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 168, 101, 0).withOpacity(0.5),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        itemCount: buttonInfoMap.length,
        itemBuilder: (BuildContext context, int index) {
          String buttonText = buttonInfoMap.keys.elementAt(index);
          String infoText = buttonInfoMap.values.elementAt(index);
          return Column(
            children: [
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 208, 120, 4),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // round corners for dialog
                          ),
                          title: Text(
                            buttonText,
                            style: TextStyle(
                              color: Color.fromARGB(255, 205, 92, 92),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Text(infoText),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 244, 192, 192),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(buttonText),
                ),
              ),
              SizedBox(height: buttonSpacing),
            ],
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, String> buttonInfoMap = {
    'Definition':
        'It is a common benign skin lesion caused by local proliferation of melanocytes (melanocytes). A brown or black melanocytic nevus contains the pigment melanin, so it can also be called a melanocytic nevus. Melanocytic cysts can be present at birth (congenital melanocytic cysts) or appear later (acquired cysts).',
    'Who Get':
        'Almost everyone has at least one melanocytic naevus. About 1% of individuals are born with one or more congenital melanocytic naevi. This is usually sporadic, with rare instances of familial congenital naevi. Fair-skinned people tend to have more melanocytic naevi than darker skinned people. Melanocytic naevi that appear during childhood (aged 2 to 10 years) tend to be the most prominent and persistent throughout life. Melanocytic naevi that are acquired later in childhood or adult life often follow sun exposure and may fade away or involute later. Most white-skinned New Zealanders have 20–50 melanocytic naevi.',
    'Reasons':
        'Depends on genetic factors, on sun exposure, and on immune status. Somatic mutations in RAS genes are associated with congenital melanocytic naevi. New melanocytic naevi may erupt following the use of BRAF inhibitor drugs (vemurafenib, dabrafenib). Immunosuppressive treatment leads to an increase in the numbers of naevi.',
    'Treatment':
        'Most melanocytic naevi are harmless and can be safely left alone. They may be removed in the following circumstances: To exclude cancer. If a naevus is a nuisance: perhaps irritated by clothing, comb or razor. Cosmetic reasons: the mole is unsightly. Surgical techniques include: Excision biopsy of a flat or suspicious melanocytic naevus. Shave biopsy of a protruding melanocytic naevus. Electrosurgical destruction. Laser to lessen pigment or remove coarse hair.',
  };
  List<Widget> _textToPointList(String text) {
    List<String> points = text.split('○');
    points = points
        .map((point) => point.trim())
        .where((point) => point.isNotEmpty)
        .toList();
    List<Widget> pointWidgets = [];
    for (String point in points) {
      pointWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text('• $point', textAlign: TextAlign.left),
        ),
      );
    }
    return pointWidgets;
  }

  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    double buttonWidth = MediaQuery.of(context).size.width * 0.7;
    double buttonSpacing = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 229, 216),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 109, 109),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 255, 158, 13).withOpacity(0.5),
              ),
              Shadow(
                offset: Offset(-1.0, -1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 168, 101, 0).withOpacity(0.5),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        itemCount: buttonInfoMap.length,
        itemBuilder: (BuildContext context, int index) {
          String buttonText = buttonInfoMap.keys.elementAt(index);
          String infoText = buttonInfoMap.values.elementAt(index);
          return Column(
            children: [
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 208, 120, 4),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // round corners for dialog
                          ),
                          title: Text(
                            buttonText,
                            style: TextStyle(
                              color: Color.fromARGB(255, 205, 92, 92),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Text(infoText),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 244, 192, 192),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(buttonText),
                ),
              ),
              SizedBox(height: buttonSpacing),
            ],
          );
        },
      ),
    );
  }
}

class BasalCellCarcinomaPage extends StatelessWidget {
  final Map<String, String> buttonInfoMap = {
    'Definition':
        'It is a common keratinocyte carcinoma and is the most common form of skin cancer. BCC is also known as rodent ulcer and basal ulcer. Patients with BCC often develop multiple primary tumors over time.',
    'Who Get':
        'Age and gender: It is especially common in elderly males. However, it also affects females and younger adults. •Sun damage.• Recurrence of previous bouts of sunburn. It can also affect darker skin types. Previous skin injury, thermal burn, or disease (such as cutaneous lupus, sebaceous nevus). Inherited syndromes. Using medications such as hydrochlorothiazide.',
    'Reasons':
        'There are DNA mutations in the patched (PTCH) tumour suppressor gene, part of hedgehog signalling pathway. These may be triggered by exposure to ultraviolet radiation. Various spontaneous and inherited gene defects predispose to BCC.',
    'Treatment':
        'Treatment of hidden cell carcinoma depends on its type, size, location, and number to be treated. Most cases of hidden cell carcinoma are treated surgically. Long-term follow-up to check for new lesions and recurrence is recommended.',
  };
  List<Widget> _textToPointList(String text) {
    List<String> points = text.split('○');
    points = points
        .map((point) => point.trim())
        .where((point) => point.isNotEmpty)
        .toList();
    List<Widget> pointWidgets = [];
    for (String point in points) {
      pointWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text('• $point', textAlign: TextAlign.left),
        ),
      );
    }
    return pointWidgets;
  }

  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    double buttonWidth = MediaQuery.of(context).size.width * 0.7;
    double buttonSpacing = MediaQuery.of(context).size.height * 0.02;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 229, 216),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 109, 109),
        title: Text(
          'Basal cell carcinoma',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 255, 158, 13).withOpacity(0.5),
              ),
              Shadow(
                offset: Offset(-1.0, -1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 168, 101, 0).withOpacity(0.5),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        itemCount: buttonInfoMap.length,
        itemBuilder: (BuildContext context, int index) {
          String buttonText = buttonInfoMap.keys.elementAt(index);
          String infoText = buttonInfoMap.values.elementAt(index);
          return Column(
            children: [
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 208, 120, 4),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          title: Text(
                            buttonText,
                            style: TextStyle(
                              color: Color.fromARGB(255, 205, 92, 92),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Text(infoText),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 244, 192, 192),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(buttonText),
                ),
              ),
              SizedBox(height: buttonSpacing),
            ],
          );
        },
      ),
    );
  }
}

class MelanomaPage extends StatelessWidget {
  final Map<String, String> buttonInfoMap = {
    'Definition':
        'Melanoma is a serious skin cancer caused by the uncontrolled growth of pigment cells called melanocytes. It can be categorized as in situ (confined to the epidermis), invasive (spread into the dermis), or metastatic (spread to other tissues). It is important to refer to local guidelines, such as those provided by the Australian Cancer Council, for the most up-to-date recommendations on the diagnosis and management of melanoma.',
    'Who Get':
        'Melanoma primarily affects individuals with increasing age, fair or white skin, a history of previous melanoma or other skin cancers, a family history of melanoma, a large number of moles (especially atypical ones), and those with a weakened immune system or cancer-prone syndromes. UV exposure and a history of sunburn are also significant risk factors. Melanoma is more common in Australia and New Zealand, and it is the most common cancer diagnosed in young Australians aged 15–29 years.',
    'Reasons':
        'Melanoma is caused by genetic mutations in melanin-producing cells, which can be acquired through exposure to UV radiation or inherited through certain genes. It can develop from normal skin or pre-existing moles or freckles. Melanomas have two growth phases, radial and vertical, and can spread to other tissues through the lymphatic system or bloodstream. The risk of metastasis depends on the depth of the melanoma.',
    'Treatment':
        'Treatment for melanoma depends on the stage of the cancer and individual factors. Surgery is the primary treatment for early-stage melanoma (Stage 0, I, or II), with a high chance of cure. Advanced melanomas (Stage III or IV) may require a combination of treatments, such as surgery, drug therapy, and radiation therapy. A multidisciplinary team reviews patients with metastatic melanoma to determine the best treatment approach. New and more effective therapies are continually being developed through clinical trials, and access to these treatments is subject to approval by government bodies.',
  };

  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    double buttonWidth = MediaQuery.of(context).size.width * 0.7;
    double buttonSpacing = MediaQuery.of(context).size.height * 0.02;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 229, 216),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 109, 109),
        title: Text(
          'Melanoma',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 255, 158, 13).withOpacity(0.5),
              ),
              Shadow(
                offset: Offset(-1.0, -1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 168, 101, 0).withOpacity(0.5),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        itemCount: buttonInfoMap.length,
        itemBuilder: (BuildContext context, int index) {
          String buttonText = buttonInfoMap.keys.elementAt(index);
          String infoText = buttonInfoMap.values.elementAt(index);
          return Column(
            children: [
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 208, 120, 4),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // round corners for dialog
                          ),
                          title: Text(
                            buttonText,
                            style: TextStyle(
                              color: Color.fromARGB(255, 205, 92, 92),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Text(infoText),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 244, 192, 192),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(buttonText),
                ),
              ),
              SizedBox(height: buttonSpacing),
            ],
          );
        },
      ),
    );
  }
}

class PyogenicGranulomaPage extends StatelessWidget {
  final Map<String, String> buttonInfoMap = {
    'Definition':
        'Pyogenic granuloma is an acquired benign proliferation of capillary blood vessels of the skin and oral cavity. The name is a misnomer as it is a form of lobular capillary haemangioma, not due to infection. Pyogenic granuloma has many synonyms including granuloma gravidarum or pregnancy tumour when occurring in pregnancy.',
    'Who Get':
        'Pyogenic granuloma often occurs in children around 6 years of age and during teenage and young adult life. There is an overall male predominance except for oral lesions due to their association with pregnancy and oral contraceptive use.',
    'Reasons':
        'Hormonal influences — can occur with oral contraceptive use and in 5% of pregnancies. Medications — oral retinoids, protease inhibitors (used in the treatment of HIV/AIDS), targeted cancer therapies, and immunosuppression. Infection In the oral cavity, poor dental hygiene is a common association. There is no evidence for a viral aetiology.',
    'Treatment':
        'General measures Treating or removing triggering factors is important to minimise the risk of recurrence. This may include: Ceasing drug triggers, Careful oral hygiene, Dental treatment of oral trauma caused by teeth. Topical treatment of pyogenic granuloma: Imiquimod cream 5%, Intralesional steroid injection, Cryotherapy. Procedural treatment of pyogenic granuloma: Curettage and cautery, Surgical excision, Vascular and ablative lasers.',
  };

  Widget _textToWidget(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(text, textAlign: TextAlign.left),
    );
  }

  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    double buttonWidth = MediaQuery.of(context).size.width * 0.7;
    double buttonSpacing = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 229, 216),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 109, 109),
        title: Text(
          'Pyogenic Granuloma',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 255, 158, 13).withOpacity(0.5),
              ),
              Shadow(
                offset: Offset(-1.0, -1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 168, 101, 0).withOpacity(0.5),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        itemCount: buttonInfoMap.length,
        itemBuilder: (BuildContext context, int index) {
          String buttonText = buttonInfoMap.keys.elementAt(index);
          String infoText = buttonInfoMap.values.elementAt(index);
          return Column(
            children: [
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 208, 120, 4),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // round corners for dialog
                          ),
                          title: Text(
                            buttonText,
                            style: TextStyle(
                              color: Color.fromARGB(255, 205, 92, 92),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Text(infoText),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 244, 192, 192),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(buttonText),
                ),
              ),
              SizedBox(height: buttonSpacing),
            ],
          );
        },
      ),
    );
  }
}

class DermatofibromaPage extends StatelessWidget {
  final Map<String, String> buttonInfoMap = {
    'Definition':
        'A dermatofibroma is a common benign fibrous nodule usually found on the skin of the lower legs.',
    'Who Get':
        'Dermatofibromas appear mostly in adults. Dermatofibromas are more common in women than in men.',
    'Reasons':
        'Insect bites, injections, rose thistle infestation, or multiple dermatofibromas can occur in patients with altered immunity such as HIV, immunosuppression, or autoimmune disease.',
    'Treatment':
        'A dermatofibroma is harmless and seldom causes any symptoms. Usually, only reassurance is needed. The lesion can be removed surgically. Cryotherapy, shave biopsy, and laser treatments are rarely completely successful.',
  };

  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    double buttonWidth = MediaQuery.of(context).size.width * 0.7;
    double buttonSpacing = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 229, 216),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 109, 109),
        title: Text(
          'Dermatofibroma',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 255, 158, 13).withOpacity(0.5),
              ),
              Shadow(
                offset: Offset(-1.0, -1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 168, 101, 0).withOpacity(0.5),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        itemCount: buttonInfoMap.length,
        itemBuilder: (BuildContext context, int index) {
          String buttonText = buttonInfoMap.keys.elementAt(index);
          String infoText = buttonInfoMap.values.elementAt(index);
          return Column(
            children: [
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 208, 120, 4),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // round corners for dialog
                          ),
                          title: Text(
                            buttonText,
                            style: TextStyle(
                              color: Color.fromARGB(255, 205, 92, 92),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Text(infoText),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 244, 192, 192),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(buttonText),
                ),
              ),
              SizedBox(height: buttonSpacing),
            ],
          );
        },
      ),
    );
  }
}

class ActinicKeratosisPage extends StatelessWidget {
  final Map<String, String> buttonInfoMap = {
    'Definition':
        'Actinic keratosis is a precancerous scaly spot found on sun-damaged skin, also known as solar keratosis. It may be considered an early form of cutaneous squamous cell carcinoma (a keratinocyte cancer).',
    'Who Get':
        'It affects people who have predisposing factors such as: Other signs of skin aging / Fair skin with a history of sunburn / History of long hours spent outdoors for work or leisure / Immune system malfunction.',
    'Reasons':
        'Actinic keratosis occurs as a result of abnormal growth of skin cells due to DNA damage caused by short-wavelength ultraviolet rays. They are more likely to appear if your immune function is weak, due to aging, recent sun exposure, illness, or certain medications.',
    'Treatment':
        'Actinic keratoses are usually removed because they are unsightly or uncomfortable, or because of the risk that skin cancer may develop in them. Treatment of an actinic keratosis requires removal of the defective skin cells. Epidermis regenerates from surrounding or follicular keratinocytes that have escaped sun damage.',
  };

  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    double buttonWidth = MediaQuery.of(context).size.width * 0.7;
    double buttonSpacing = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 229, 216),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 109, 109),
        title: Text(
          'Actinic Keratosis',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 255, 158, 13).withOpacity(0.5),
              ),
              Shadow(
                offset: Offset(-1.0, -1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 168, 101, 0).withOpacity(0.5),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        itemCount: buttonInfoMap.length,
        itemBuilder: (BuildContext context, int index) {
          String buttonText = buttonInfoMap.keys.elementAt(index);
          String infoText = buttonInfoMap.values.elementAt(index);
          return Column(
            children: [
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 208, 120, 4),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // round corners for dialog
                          ),
                          title: Text(
                            buttonText,
                            style: TextStyle(
                              color: Color.fromARGB(255, 205, 92, 92),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Text(infoText),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 244, 192, 192),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(buttonText),
                ),
              ),
              SizedBox(height: buttonSpacing),
            ],
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        height: 50.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.info, size: 30, color: Colors.white),
          Icon(Icons.alarm, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        animationCurve: Curves.easeInOut,
        color: Color.fromARGB(135, 36, 36, 36),
        backgroundColor: Colors.white,
        onTap: (index) {
          // Handle tap events here
          print('Tapped on item $index');
          // You can navigate to different pages based on the index
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Firstpage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformationPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
              break;
          }
        },
      ),
    );
  }
}
