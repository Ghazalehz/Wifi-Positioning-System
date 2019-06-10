# Wifi-Positioning-System

## Evaluate machine learning techniques to predict indoor location of a person via wifi fingerprinting.

Many real world applications need to know the localization of a user in the world to provide their services. Therefore, automatic user localization has been a hot research topic in the last years. Automatic user localization consists of estimating the position of the user (latitude, longitude and altitude) by using an electronic device, usually a mobile phone. Outdoor localization problem can be solved very accurately thanks to the inclusion of GPS sensors into the mobile devices. However, indoor localization is still an open problem mainly due to the loss of GPS signal in indoor environments. Although, there are some indoor positioning technologies and methodologies, this database is focused on WLAN fingerprint-based ones (also know as WiFi Fingerprinting).

Although there are many papers in the literature trying to solve the indoor localization problem using a WLAN fingerprint-based method, there still exists one important drawback in this field which is the lack of a common database for comparison purposes. So, UJIIndoorLoc database is presented to overcome this gap. We expect that the proposed database will become the reference database to compare different indoor localization methodologies based on WiFi fingerprinting.


Database used: [Click on database source](http://archive.ics.uci.edu/ml/machine-learning-databases/00310/UJIndoorLoc.zip)

Location: Universitat Jaume, Spain

Date of database creation: 2013

Participants: 20 users and 25 Android devices

Number of WLAN Access Points (WAPs): 520

Total number of training records: 19937

Total number of validation records: 1111

Models investigated: **C5.0, SVM/SVR, KNN, LM, Model Trees, RandomForest**

