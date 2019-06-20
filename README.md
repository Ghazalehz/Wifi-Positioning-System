# Wifi-Positioning-System

## Evaluate machine learning techniques to predict indoor location of a person via wifi fingerprinting.

Many real world applications need to know the localization of a user in the world to provide their services. Therefore, automatic user localization has been a hot research topic in the last years. Automatic user localization consists of estimating the position of the user (latitude, longitude and altitude) by using an electronic device, usually a mobile phone. Outdoor localization problem can be solved very accurately thanks to the inclusion of GPS sensors into the mobile devices. However, indoor localization is still an open problem mainly due to the loss of GPS signal in indoor environments. Although, there are some indoor positioning technologies and methodologies, this database is focused on WLAN fingerprint-based ones (also know as WiFi Fingerprinting).

Although there are many papers in the literature trying to solve the indoor localization problem using a WLAN fingerprint-based method, there still exists one important drawback in this field which is the lack of a common database for comparison purposes. So, UJIIndoorLoc database is presented to overcome this gap. We expect that the proposed database will become the reference database to compare different indoor localization methodologies based on WiFi fingerprinting.


Database used: [Click on database source](http://archive.ics.uci.edu/ml/machine-learning-databases/00310/UJIndoorLoc.zip)

Location: **Universitat Jaume, Spain**

Date of database creation: **2013**

Participants: **20 users and 25 Android devices**

Total number of attributes: **529**

Total number of training records: **19937**

Total number of validation records: **1111**

Models investigated: **C5.0, SVM/SVR, KNN, LM, Model Trees, RandomForest**

The 529 attributes contain the WiFi fingerprint, the coordinates where it was taken, and other useful information. Each WiFi fingerprint can be characterized by the detected Wireless Access Points (WAPs) and the corresponding Received Signal Strength Intensity (RSSI). The intensity values are represented as negative integer values ranging -104dBm (extremely poor signal) to 0dbM. The positive value 100 is used to denote when a WAP was not detected. During the database creation, 520 different WAPs were detected. Thus, the WiFi fingerprint is composed by 520 intensity values. 

Then the coordinates (latitude, longitude, floor) and Building ID are provided as the attributes to be predicted. 


**Feature Information**


**Attribute 001 - 520 (WAP001 - WAP520)**: RSSI signal intensity for WAP001 - WAP520. Negative integer values from -104 to 0 and +100. Positive value 100 used if WAP001 - WAP520 was not detected.
**Attribute 521 (Longitude):** Longitude. Negative real values from -7695.9387549299299000 to -7299.786516730871000
**Attribute 522 (Latitude):** Latitude. Positive real values from 4864745.7450159714 to 4865017.3646842018.
**Attribute 523 (Floor):** Altitude in floors inside the building. Integer values from 0 to 4.
**Attribute 524 (BuildingID):** ID to identify the building. Measures were taken in three different buildings. Categorical integer values from 0 to 2.
**Attribute 525 (SpaceID):** Internal ID number to identify the Space (office, corridor, classroom) where the capture was taken. Categorical integer values.
**Attribute 526 (RelativePosition):** Relative position with respect to the Space (1 - Inside, 2 - Outside in Front of the door). Categorical integer values.
**Attribute 527 (UserID):** User identifier (see below). Categorical integer values.
**Attribute 528 (PhoneID):** Android device identifier (see below). Categorical integer values.
**Attribute 529 (Timestamp):** UNIX Time when the capture was taken. Integer value.

WLAN Fingerprint-based positioning systems are based on the Received Signal Strength Indicator (RSSI) values. Preparation of the data is done in two phases: Calibration and Operation. In the calibration phase, a radio map of the area where the users should be detected is constructed. In the operational phase, a user obtains the signal strength of all visible access points of the WLAN that can be detected from his/her position and creates a test sample. This sample is sent to the server to be compared with the training samples of the radio map. Then, the user's location corresponds to the position associated with the most similar sample in the radio map.
