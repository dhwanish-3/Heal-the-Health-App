# Heal the Health App

# This is my HealthCare App

## **Objective:-**
  To solve the issue of healthcare record management and outreach of these facilities.

## **Goals:-**
   The main aim of our app is to provide patients with a disease-prediction facility, treatment guidance, etc and doctors with an easy-to-use patient        record book.
   
 ## **Methodology:-**
 
To accomplish above mentioned goal we decided to create an app that can help ease the lives of doctors and patients.     
     
In initial stages the UI for the app was designed using Figma. The app has been made using Flutter and Dart. This project began by making an user Interface for bot doctors and patients. UI is different for both. Users can log in as either patient or doctor. Then after creating login and signup page the input taken from user (i.e user credentials) on these pages is saved into firebase database. Thus, any input taken tereafter is saved into the firebase. The app has also been integrated with various machine learning models to predict diseases which is the main feature of our app. The computation is done using AMD Insataces service and then the results are displayed. Models have been trained from datasets obtained from Kaggle. Various Regression models have been utilised to optimise memory usage and accuracy. The trained models have been converted into APIs using the Flask library.                                    
The app also has a chatbot which is made using Dialogflow service of GOOGLE. The Dialogflow API has been used to integrate the chatbot with the app. Google Cloud platform has been used to deploy the APIs The chatbot has been trained for basic interactions. It can trained for more complex interactions like booking appointments, setting alarms. 



## Results:-

Our app can accomplish tasks of storing and retrieving all the relevent information.It also accurately predict whether the person has a disesase or not (41 basic and 8 advanced tests) based on inputs given in the form while taking disease prediction test . If the person has a disease then it also suggests dos and don'ts, insurance policies,etc. All the past medical recodrs of the patients are also stored and visible. The patient is also able to maintain a medical diary. The app gives all the desired output to the corresponding inputs. Thus, the app functions the way it should.   
