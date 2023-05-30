import 'package:heal_the_health_app/constants/imports.dart';

List<String> diseasesList = [
  'Drug Reaction',
  'Malaria',
  'Allergy',
  'Hypothyroidism',
  'Psoriasis',
  'GERD',
  'Chronic cholestasis',
  'hepatitis A',
  'Osteoarthristis',
  '(vertigo) Paroymsal  Positional Vertigo',
  'Hypoglycemia',
  'Acne',
  'Diabetes',
  'Impetigo',
  'Hypertension',
  'Peptic ulcer diseae',
  'Dimorphic hemorrhoids(piles)',
  'Common Cold',
  'Chicken pox',
  'Cervical spondylosis',
  'Hyperthyroidism',
  'Urinary tract infection',
  'Varicose veins',
  'AIDS',
  'Paralysis (brain hemorrhage)',
  'Typhoid',
  'Hepatitis B',
  'Fungal infection',
  'Hepatitis C',
  'Migraine',
  'Bronchial Asthma',
  'Alcoholic hepatitis',
  'Jaundice',
  'Hepatitis E',
  'Dengue',
  'Hepatitis D',
  'Heart attack',
  'Pneumonia',
  'Arthritis',
  'Gastroenteritis',
  'Tuberculosis'
];

List<String> discriptionList = [
  'An adverse drug reaction (ADR) is an injury caused by taking medication. ADRs may occur following a single dose or prolonged administration of a drug or result from the combination of two or more drugs.',
  'An infectious disease caused by protozoan parasites from the Plasmodium family that can be transmitted by the bite of the Anopheles mosquito or by a contaminated needle or transfusion. Falciparum malaria is the most deadly type.',
  "An allergy is an immune system response to a foreign substance that's not typically harmful to your body.They can include certain foods, pollen, or pet dander. Your immune system's job is to keep you healthy by fighting harmful pathogens.",
  'Hypothyroidism, also called underactive thyroid or low thyroid, is a disorder of the endocrine system in which the thyroid gland does not produce enough thyroid hormone.',
  "Psoriasis is a common skin disorder that forms thick, red, bumpy patches covered with silvery scales. They can pop up anywhere, but most appear on the scalp, elbows, knees, and lower back. Psoriasis can't be passed from person to person. It does sometimes happen in members of the same family.",
  'Gastroesophageal reflux disease, or GERD, is a digestive disorder that affects the lower esophageal sphincter (LES), the ring of muscle between the esophagus and stomach. Many people, including pregnant women, suffer from heartburn or acid indigestion caused by GERD.',
  'Chronic cholestatic diseases, whether occurring in infancy, childhood or adulthood, are characterized by defective bile acid transport from the liver to the intestine, which is caused by primary damage to the biliary epithelium in most cases',
  "Hepatitis A is a highly contagious liver infection caused by the hepatitis A virus. The virus is one of several types of hepatitis viruses that cause inflammation and affect your liver's ability to function.",
  'Osteoarthritis is the most common form of arthritis, affecting millions of people worldwide. It occurs when the protective cartilage that cushions the ends of your bones wears down over time.',
  "Benign paroxysmal positional vertigo (BPPV) is one of the most common causes of vertigo — the sudden sensation that you're spinning or that the inside of your head is spinning. Benign paroxysmal positional vertigo causes brief episodes of mild to intense dizziness.",
  "Hypoglycemia is a condition in which your blood sugar (glucose) level is lower than normal. Glucose is your body's main energy source. Hypoglycemia is often related to diabetes treatment. But other drugs and a variety of conditions — many rare — can cause low blood sugar in people who don't have diabetes.",
  'Acne vulgaris is the formation of comedones, papules, pustules, nodules, and/or cysts as a result of obstruction and inflammation of pilosebaceous units (hair follicles and their accompanying sebaceous gland). Acne develops on the face and upper trunk. It most often affects adolescents.',
  'Diabetes is a disease that occurs when your blood glucose, also called blood sugar, is too high. Blood glucose is your main source of energy and comes from the food you eat. Insulin, a hormone made by the pancreas, helps glucose from food get into your cells to be used for energy.',
  "Impetigo (im-puh-TIE-go) is a common and highly contagious skin infection that mainly affects infants and children. Impetigo usually appears as red sores on the face, especially around a child's nose and mouth, and on hands and feet. The sores burst and develop honey-colored crusts.",
  'Hypertension (HTN or HT), also known as high blood pressure (HBP), is a long-term medical condition in which the blood pressure in the arteries is persistently elevated. High blood pressure typically does not cause symptoms.',
  'Peptic ulcer disease (PUD) is a break in the inner lining of the stomach, the first part of the small intestine, or sometimes the lower esophagus. An ulcer in the stomach is called a gastric ulcer, while one in the first part of the intestines is a duodenal ulcer.',
  'Hemorrhoids, also spelled haemorrhoids, are vascular structures in the anal canal. In their ... Other names, Haemorrhoids, piles, hemorrhoidal disease .',
  "The common cold is a viral infection of your nose and throat (upper respiratory tract). It's usually harmless, although it might not feel that way. Many types of viruses can cause a common cold.",
  'Chickenpox is a highly contagious disease caused by the varicella-zoster virus (VZV). It can cause an itchy, blister-like rash. The rash first appears on the chest, back, and face, and then spreads over the entire body, causing between 250 and 500 itchy blisters.',
  'Cervical spondylosis is a general term for age-related wear and tear affecting the spinal disks in your neck. As the disks dehydrate and shrink, signs of osteoarthritis develop, including bony projections along the edges of bones (bone spurs).',
  "Hyperthyroidism (overactive thyroid) occurs when your thyroid gland produces too much of the hormone thyroxine. Hyperthyroidism can accelerate your body's metabolism, causing unintentional weight loss and a rapid or irregular heartbeat.",
  'Urinary tract infection: An infection of the kidney, ureter, bladder, or urethra. Abbreviated UTI. Not everyone with a UTI has symptoms, but common symptoms include a frequent urge to urinate and pain or burning when urinating.',
  'A vein that has enlarged and twisted, often appearing as a bulging, blue blood vessel that is clearly visible through the skin. Varicose veins are most common in older adults, particularly women, and occur especially on the legs.',
  "Acquired immunodeficiency syndrome (AIDS) is a chronic, potentially life-threatening condition caused by the human immunodeficiency virus (HIV). By damaging your immune system, HIV interferes with your body's ability to fight infection and disease.",
  'Intracerebral hemorrhage (ICH) is when blood suddenly bursts into brain tissue, causing damage to your brain. Symptoms usually appear suddenly during ICH. They include headache, weakness, confusion, and paralysis, particularly on one side of your body.',
  'An acute illness characterized by fever caused by infection with the bacterium Salmonella typhi. Typhoid fever has an insidious onset, with fever, headache, constipation, malaise, chills, and muscle pain. Diarrhea is uncommon, and vomiting is not usually severe.',
  "Hepatitis B is an infection of your liver. It can cause scarring of the organ, liver failure, and cancer. It can be fatal if it isn't treated. It's spread when people come in contact with the blood, open sores, or body fluids of someone who has the hepatitis B virus.",
  'In humans, fungal infections occur when an invading fungus takes over an area of the body and is too much for the immune system to handle. Fungi can live in the air, soil, water, and plants. There are also some fungi that live naturally in the human body. Like many microbes, there are helpful fungi and harmful fungi.',
  'Inflammation of the liver due to the hepatitis C virus (HCV), which is usually spread via blood transfusion (rare), hemodialysis, and needle sticks. The damage hepatitis C does to the liver can lead to cirrhosis and its complications as well as cancer.',
  "A migraine can cause severe throbbing pain or a pulsing sensation, usually on one side of the head. It's often accompanied by nausea, vomiting, and extreme sensitivity to light and sound. Migraine attacks can last for hours to days, and the pain can be so severe that it interferes with your daily activities.",
  'Bronchial asthma is a medical condition which causes the airway path of the lungs to swell and narrow. Due to this swelling, the air path produces excess mucus making it hard to breathe, which results in coughing, short breath, and wheezing. The disease is chronic and interferes with daily working.',
  "Alcoholic hepatitis is a diseased, inflammatory condition of the liver caused by heavy alcohol consumption over an extended period of time. It's also aggravated by binge drinking and ongoing alcohol use. If you develop this condition, you must stop drinking alcohol",
  'Yellow staining of the skin and sclerae (the whites of the eyes) by abnormally high blood levels of the bile pigment bilirubin. The yellowing extends to other tissues and body fluids. Jaundice was once called the "morbus regius" (the regal disease) in the belief that only the touch of a king could cure it',
  'A rare form of liver inflammation caused by infection with the hepatitis E virus (HEV). It is transmitted via food or drink handled by an infected person or through infected water supplies in areas where fecal matter may get into the water. Hepatitis E does not cause chronic liver disease.',
  'an acute infectious disease caused by a flavivirus (species Dengue virus of the genus Flavivirus), transmitted by aedes mosquitoes, and characterized by headache, severe joint pain, and a rash. — called also breakbone fever, dengue fever.',
  'Hepatitis D, also known as the hepatitis delta virus, is an infection that causes the liver to become inflamed. This swelling can impair liver function and cause long-term liver problems, including liver scarring and cancer. The condition is caused by the hepatitis D virus (HDV).',
  'The death of heart muscle due to the loss of blood supply. The loss of blood supply is usually caused by a complete blockage of a coronary artery, one of the arteries that supplies blood to the heart muscle.',
  'Pneumonia is an infection in one or both lungs. Bacteria, viruses, and fungi cause it. The infection causes inflammation in the air sacs in your lungs, which are called alveoli. The alveoli fill with fluid or pus, making it difficult to breathe.',
  'Arthritis is the swelling and tenderness of one or more of your joints. The main symptoms of arthritis are joint pain and stiffness, which typically worsen with age. The most common types of arthritis are osteoarthritis and rheumatoid arthritis.',
  'Gastroenteritis is an inflammation of the digestive tract, particularly the stomach, and large and small intestines. Viral and bacterial gastroenteritis are intestinal infections associated with symptoms of diarrhea , abdominal cramps, nausea , and vomiting .',
  'Tuberculosis (TB) is an infectious disease usually caused by Mycobacterium tuberculosis (MTB) bacteria. Tuberculosis generally affects the lungs, but can also affect other parts of the body. Most infections show no symptoms, in which case it is known as latent tuberculosis.'
];

List<String> diseaseTypeList = [
  'Immunologist',
  'Infectious Disease Specialist',
  'Immunologist',
  'Endocrinologist',
  'Dermatologist',
  'Gastroenterologist',
  'Hepatologist',
  'Infectious Disease Specialist',
  'Orthopedic Surgeon',
  'Otolaryngologist',
  'Endocrinologist',
  'Dermatologist',
  'Endocrinologist',
  'Dermatologist',
  'Cardiologist',
  'Gastroenterologist',
  'Colorectal Surgeon',
  'General Practitioner',
  'Pediatrician',
  'Orthopedic Surgeon',
  'Endocrinologist',
  'Urologist',
  'Vascular Surgeon',
  'Infectious Disease Specialist',
  'Neurologist',
  'Infectious Disease Specialist',
  'Infectious Disease Specialist',
  'Dermatologist',
  'Infectious Disease Specialist',
  'Neurologist',
  'Pulmonologist',
  'Hepatologist',
  'Hepatologist',
  'Infectious Disease Specialist',
  'Infectious Disease Specialist',
  'Infectious Disease Specialist',
  'Cardiologist',
  'Pulmonologist',
  'Orthopedic Surgeon',
  'Gastroenterologist',
  'Pulmonologist'
];

List<List<String>> precationsList = [
  [
    'Stop irritation',
    'Consult nearest hospital',
    'Stop taking drug',
    'Follow up'
  ],
  [
    'Consult nearest hospital',
    'Avoid oily food',
    'Avoid non veg food',
    'Keep mosquitos out'
  ],
  ['Apply calamine', 'Cover area with bandage', 'Use ice to compress itching'],
  ['Reduce stress', 'Exercise', 'Eat healthy', 'Get proper sleep'],
  [
    'Wash hands with warm soapy water',
    'Stop bleeding using pressure',
    'Consult doctor',
    'Salt baths'
  ],
  [
    'Avoid fatty spicy food',
    'Avoid lying down after eating',
    'Maintain healthy weight',
    'Exercise'
  ],
  ['Cold baths', 'Anti itch medicine', 'Consult doctor', 'Eat healthy'],
  [
    'Consult nearest hospital',
    'Wash hands through',
    'Avoid fatty spicy food',
    'Medication'
  ],
  ['Acetaminophen', 'Consult nearest hospital', 'Follow up', 'Salt baths'],
  [
    'Lie down',
    'Avoid sudden change in body',
    'Avoid abrupt head movment',
    'Relax'
  ],
  [
    'Lie down on side',
    'Check in pulse',
    'Drink sugary drinks',
    'Consult doctor'
  ],
  [
    'Bath twice',
    'Avoid fatty spicy food',
    'Drink plenty of water',
    'Avoid too many products'
  ],
  ['Have balanced diet', 'Exercise', 'Consult doctor', 'Follow up'],
  [
    'Soak affected area in warm water',
    'Use antibiotics',
    'Remove scabs with wet compressed cloth',
    'Consult doctor'
  ],
  ['Meditation', 'Salt baths', 'Reduce stress', 'Get proper sleep'],
  [
    'Avoid fatty spicy food',
    'Consume probiotic food',
    'Eliminate milk',
    'Limit alcohol'
  ],
  [
    'Avoid fatty spicy food',
    'Consume witch hazel',
    'Warm bath with epsom salt',
    'Consume alovera juice'
  ],
  [
    'Drink vitamin c rich drinks',
    'Take vapour',
    'Avoid cold food',
    'Keep fever in check'
  ],
  [
    'Use neem in bathing ',
    'Consume neem leaves',
    'Take vaccine',
    'Avoid public places'
  ],
  [
    'Use heating pad or cold pack',
    'Exercise',
    'Take otc pain reliver',
    'Consult doctor'
  ],
  [
    'Eat healthy',
    'Massage',
    'Use lemon balm',
    'Take radioactive iodine treatment'
  ],
  [
    'Drink plenty of water',
    'Increase vitamin c intake',
    'Drink cranberry juice',
    'Take probiotics'
  ],
  [
    'Lie down flat and raise the leg high',
    'Use oinments',
    'Use vein compression',
    'Dont stand still for long'
  ],
  ['Avoid open cuts', 'Wear ppe if possible', 'Consult doctor', 'Follow up'],
  ['Massage', 'Eat healthy', 'Exercise', 'Consult doctor'],
  [
    'Eat high calorie vegitables',
    'Antiboitic therapy',
    'Consult doctor',
    'Medication'
  ],
  ['Consult nearest hospital', 'Vaccination', 'Eat healthy', 'Medication'],
  [
    'Bath twice',
    'Use detol or neem in bathing water',
    'Keep infected area dry',
    'Use clean cloths'
  ],
  ['Consult nearest hospital', 'Vaccination', 'Eat healthy', 'Medication'],
  [
    'Meditation',
    'Reduce stress',
    'Use poloroid glasses in sun',
    'Consult doctor'
  ],
  [
    'Switch to loose cloothing',
    'Take deep breaths',
    'Get away from trigger',
    'Seek help'
  ],
  ['Stop alcohol consumption', 'Consult doctor', 'Medication', 'Follow up'],
  [
    'Drink plenty of water',
    'Consume milk thistle',
    'Eat fruits and high fiberous food',
    'Medication'
  ],
  ['Stop alcohol consumption', 'Rest', 'Consult doctor', 'Medication'],
  [
    'Drink papaya leaf juice',
    'Avoid fatty spicy food',
    'Keep mosquitos away',
    'Keep hydrated'
  ],
  ['Consult doctor', 'Medication', 'Eat healthy', 'Follow up'],
  ['Call ambulance', 'Chew or swallow asprin', 'Keep calm'],
  ['Consult doctor', 'Medication', 'Rest', 'Follow up'],
  ['Exercise', 'Use hot and cold therapy', 'Try acupuncture', 'Massage'],
  [
    'Stop eating solid food for while',
    'Try taking small sips of water',
    'Rest',
    'Ease back into eating'
  ],
  ['Cover mouth', 'Consult doctor', 'Medication', 'Rest']
];

List<List<String>> symptomsstringList = [
  [
    'Itching',
    'Skin rash',
    'Stomach pain',
    'Burning micturition',
    'Spotting  urination'
  ],
  [
    'Chills',
    'Vomiting',
    'High fever',
    'Sweating',
    'Headache',
    'Nausea',
    'Muscle pain',
    'Muscle pain'
  ],
  ['Continuous sneezing', 'Shivering', 'Chills', 'Watering from eyes'],
  [
    'Fatigue',
    'Weight gain',
    'Cold hands and feets',
    'Mood swings',
    'Lethargy',
    'Dizziness',
    'Puffy face and eyes',
    'Enlarged thyroid',
    'Brittle nails',
    'Swollen extremeties',
    'Depression',
    'Irritability',
    'Abnormal menstruation'
  ],
  [
    'Skin rash',
    'Joint pain',
    'Skin peeling',
    'Silver like dusting',
    'Small dents in nails',
    'Inflammatory nails'
  ],
  [
    'Stomach pain',
    'Acidity',
    'Ulcers on tongue',
    'Vomiting',
    'Cough',
    'Chest pain'
  ],
  [
    'Itching',
    'Vomiting',
    'Yellowish skin',
    'Nausea',
    'Loss of appetite',
    'Abdominal pain',
    'Yellowing of eyes'
  ],
  [
    'Joint pain',
    'Vomiting',
    'Yellowish skin',
    'Dark urine',
    'Nausea',
    'Loss of appetite',
    'Abdominal pain',
    'Diarrhoea',
    'Mild fever',
    'Yellowing of eyes',
    'Muscle pain'
  ],
  [
    'Joint pain',
    'Neck pain',
    'Knee pain',
    'Hip joint pain',
    'Swelling joints',
    'Painful walking'
  ],
  [
    'Vomiting',
    'Headache',
    'Nausea',
    'Spinning movements',
    'Loss of balance',
    'Unsteadiness'
  ],
  [
    'Vomiting',
    'Fatigue',
    'Anxiety',
    'Sweating',
    'Headache',
    'Nausea',
    'Blurred and distorted vision',
    'Excessive hunger',
    'Slurred speech',
    'Irritability',
    'Palpitations',
    'Palpitations'
  ],
  ['Skin rash', 'Pus filled pimples', 'Blackheads', 'Scurring'],
  [
    'Skin rash',
    'High fever',
    'Blister',
    'Red sore around nose',
    'Yellow crust ooze'
  ],
  [
    'Vomiting',
    'Loss of appetite',
    'Abdominal pain',
    'Passage of gases',
    'Internal itching',
    'Internal itching'
  ],
  [
    'Continuous sneezing',
    'Chills',
    'Fatigue',
    'Cough',
    'High fever',
    'Headache',
    'Swelled lymph nodes',
    'Malaise',
    'Phlegm',
    'Throat irritation',
    'Redness of eyes',
    'Sinus pressure',
    'Runny nose',
    'Congestion',
    'Chest pain',
    'Loss of smell',
    'Muscle pain'
  ],
  [
    'Itching',
    'Skin rash',
    'Fatigue',
    'Lethargy',
    'High fever',
    'Headache',
    'Loss of appetite',
    'Mild fever',
    'Swelled lymph nodes',
    'Malaise',
    'Red spots over body'
  ],
  [
    'Back pain',
    'Weakness in limbs',
    'Neck pain',
    'Dizziness',
    'Loss of balance'
  ],
  [
    'Fatigue',
    'Mood swings',
    'Weight loss',
    'Restlessness',
    'Sweating',
    'Diarrhoea',
    'Fast heart rate',
    'Excessive hunger',
    'Muscle weakness',
    'Irritability',
    'Abnormal menstruation'
  ],
  [
    'Burning micturition',
    'Bladder discomfort',
    'Foul smell of urine',
    'Continuous feel of urine'
  ],
  [
    'Fatigue',
    'Cramps',
    'Bruising',
    'Obesity',
    'Swollen legs',
    'Swollen blood vessels',
    'Prominent veins on calf'
  ],
  [
    'Muscle wasting',
    'Patches in throat',
    'High fever',
    'Extra marital contacts'
  ],
  ['Vomiting', 'Headache', 'Weakness of one body side', 'Altered sensorium'],
  [
    'Chills',
    'Vomiting',
    'Fatigue',
    'High fever',
    'Nausea',
    'Constipation',
    'Abdominal pain',
    'Diarrhoea',
    'Toxic look (typhos)',
    'Belly pain',
  ],
  [
    'Itching',
    'Fatigue',
    'Lethargy',
    'Yellowish skin',
    'Dark urine',
    'Loss of appetite',
    'Abdominal pain',
    'Yellow urine',
    'Yellowing of eyes',
    'Malaise',
    'Receiving blood transfusion',
    'Receiving unsterile injections'
  ],
  ['Itching', 'Skin rash', 'Nodal skin eruptions', 'Dischromic  patches'],
  [
    'Fatigue',
    'Yellowish skin',
    'Nausea',
    'Loss of appetite',
    'Family history',
    'Family history'
  ],
  [
    'Acidity',
    'Indigestion',
    'Headache',
    'Blurred and distorted vision',
    'Excessive hunger',
    'Stiff neck',
    'Depression',
    'Irritability',
    'Visual disturbances'
  ],
  [
    'Fatigue',
    'Cough',
    'High fever',
    'Breathlessness',
    'Family history',
    'Mucoid sputum'
  ],
  [
    'Vomiting',
    'Yellowish skin',
    'Abdominal pain',
    'Swelling of stomach',
    'Distention of abdomen',
    'History of alcohol consumption',
    'Fluid overload'
  ],
  [
    'Itching',
    'Vomiting',
    'Fatigue',
    'Weight loss',
    'High fever',
    'Yellowish skin',
    'Dark urine',
    'Abdominal pain'
  ],
  [
    'Joint pain',
    'Vomiting',
    'Fatigue',
    'High fever',
    'Yellowish skin',
    'Dark urine',
    'Nausea',
    'Loss of appetite',
    'Abdominal pain',
    'Yellowing of eyes',
    'Coma',
    'Stomach bleeding',
    'Stomach bleeding'
  ],
  [
    'Skin rash',
    'Chills',
    'Joint pain',
    'Vomiting',
    'Fatigue',
    'High fever',
    'Headache',
    'Nausea',
    'Loss of appetite',
    'Pain behind the eyes',
    'Back pain',
    'Muscle pain',
    'Red spots over body',
    'Red spots over body'
  ],
  [
    'Joint pain',
    'Vomiting',
    'Fatigue',
    'Yellowish skin',
    'Dark urine',
    'Nausea',
    'Loss of appetite',
    'Abdominal pain',
    'Yellowing of eyes'
  ],
  ['Vomiting', 'Breathlessness', 'Sweating', 'Chest pain'],
  [
    'Chills',
    'Fatigue',
    'Cough',
    'High fever',
    'Breathlessness',
    'Sweating',
    'Malaise',
    'Chest pain',
    'Fast heart rate',
    'Rusty sputum',
    'Rusty sputum'
  ],
  [
    'Muscle weakness',
    'Stiff neck',
    'Swelling joints',
    'Movement stiffness',
    'Painful walking'
  ],
  ['Vomiting', 'Sunken eyes', 'Dehydration', 'Diarrhoea'],
  [
    'Chills',
    'Vomiting',
    'Fatigue',
    'Weight loss',
    'Cough',
    'High fever',
    'Breathlessness',
    'Sweating',
    'Loss of appetite',
    'Mild fever',
    'Yellowing of eyes',
    'Swelled lymph nodes',
    'Malaise',
    'Phlegm',
    'Chest pain',
    'Blood in sputum'
  ],
  [
    'Fatigue',
    'Weight loss',
    'Restlessness',
    'Lethargy',
    'Irregular sugar level',
    'Blurred and distorted vision',
    'Obesity',
    'Excessive hunger',
    'Increased appetite',
    'Polyuria'
  ],
  [
    'Constipation',
    'Pain during bowel movements',
    'Pain in anal region',
    'Bloody stool',
    'Irritation in anus'
  ],
  [
    'Headache',
    'Chest pain',
    'Dizziness',
    'Loss of balance',
    'Lack of concentration'
  ]
];

// to get docotoruser list
List<List<DoctorUser>> doctorsList = [];
getDoctors() async {
  for (var diseaseType in diseaseTypeList) {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .where('specialization', isEqualTo: diseaseType)
        .get()
        .catchError((e) {
      debugPrint(e);
      return [];
    }).then((value) {
      doctorsList.add(value.docs
          .map((doctor) => DoctorUser.fromMap(doctor.data()))
          .toList());
      return doctorsList;
    });
    return doctorsList;
  }
}

// get doctorusers uid list
String getUserid(Map<String, dynamic> data) {
  return data['uid'];
}

getDoctorsUID(List<List<String>> doctorsuidList) async {
  int i = 0;
  for (var diseaseType in diseaseTypeList) {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .where('specialization', isEqualTo: diseaseType)
        .get()
        .catchError((e) {
      debugPrint(e);
    }).then((value) {
      // debugPrint('this is value${value.docs.toString()}$diseaseType');
      doctorsuidList[i] = (value.docs.map((doctor) {
        // debugPrint('this is doctor${value.docs.length}$diseaseType');
        return getUserid(doctor.data());
      }).toList());
      // debugPrint(doctorsuidList[i].toString());
      i++;
    });
  }
}

//trying to make it efficient
//get doctors list for a disease type
List<String> diseaseTypesonlyList = [
  'Gastroenterologist',
  'Hepatologist',
  'Colorectal Surgeon',
  'Orthopedic Surgeon',
  'Neurologist',
  'Urologist',
  'Pulmonologist',
  'Dermatologist',
  'Infectious Disease Specialist',
  'General Practitioner',
  'Immunologist',
  'Otolaryngologist',
  'Pediatrician',
  'Cardiologist',
  'Vascular Surgeon',
  'Endocrinologist'
];
getDoctorsUidforDiseaseType(Map<String, List<String>> mapOfdiseaseType) async {
  for (String diseaseType in diseaseTypesonlyList) {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .where('specialization', isEqualTo: diseaseType)
        .get()
        .catchError((e) {
      debugPrint(e);
    }).then((value) {
      mapOfdiseaseType.putIfAbsent(diseaseType, () => []);
      // debugPrint('this is value${value.docs.toString()}$diseaseType');
      mapOfdiseaseType[diseaseType] = (value.docs.map((doctor) {
        // debugPrint('this is doctor${value.docs.length}$diseaseType');
        return getUserid(doctor.data());
      }).toList());
      debugPrint(mapOfdiseaseType[diseaseType].toString());
    });
  }
}

List<List<Symptom>> symptomsList = List.generate(
    symptomsstringList.length,
    (index1) => List.generate(
        symptomsstringList[index1].length,
        (index2) => Symptom(
            symptom: symptomsstringList[index1][index2], index: index2)));

// List<List<DoctorUser>> doctors = getDoctors();

class Medicals {
  // List<List<String>> doctorsuidList = [];
  Map<String, List<String>> mapofDiseaseTypes = {};
  initialize() async {
    // for (int i = 0; i < 41; i++) {
    //   doctorsuidList.add([]);
    // }
    // await getDoctorsUID(doctorsuidList);
    // for (int i = 0; i < 41; i++) {
    //   debugPrint(doctorsuidList[i].toString());
    // }
    await getDoctorsUidforDiseaseType(mapofDiseaseTypes);
  }

  List<Disease>? _medicalConditions;
  Future<List<Disease>?> get MedicalConditionsList async {
    await initialize();
    List<Disease> medicalConditions = List.generate(
        diseasesList.length,
        (index) => Disease(
            index: index,
            disease: diseasesList[index],
            precautions: precationsList[index],
            discription: discriptionList[index],
            symptoms: symptomsList[index],
            doctors: mapofDiseaseTypes[diseaseTypeList[index]],
            type: diseaseTypeList[index]));
    _medicalConditions = medicalConditions;
    return _medicalConditions;
  }
}

// final medicalConditions = Medicals().MedicalConditionsList;
