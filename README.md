# sound_analysis

The Sound Analysis App, built using Flutter, allows users to record and analyze sound using the device's microphone and an external audio sensor. The app is designed specifically for analyzing human sounds e.g heart sounds. It enables users to input patient information, connect to the audio acquisition sensor, and record the patient's sound. The app provides a real-time audio waveform display on the dashboard, along with controls to start, stop, and save recordings. Additionally, users can play back saved recordings and access various audio analysis features. The app also includes functionalities to edit or delete recorded data.

## Features
* Patient Information: Input and store relevant patient information for accurate recording and analysis.

* Audio Acquisition Sensor: Connect the app to an external audio sensor to capture high-quality heart sounds.

* Real-time Audio Waveform: Display the recorded audio waveform in real-time on the app's dashboard.

* Recording Controls: Start, stop, and save recordings with convenient controls.

* Playback and Analysis: Play back saved recordings and access various audio analysis features for detailed examination.

* Local Device Database: Store recorded data in a local device database for easy retrieval and management.

* Editing and Deletion: Edit or delete recorded data as needed to maintain accurate records.

* User-friendly Interface: Enjoy a beautiful and intuitive user interface that enhances the overall user experience.

## Installation
1. Clone the repository:
```
git clone https://github.com/Shahid-Fakhri/mealapp.git
```
2. Navigate to the project directory:
```
cd mealapp
```
3. Install the dependencies:
```
flutter pub get
```
4. Run the app:
```
flutter run
```

## Dependencies
The following dependencies are used in this project:
```
provider
shared_preferences
intl
http
audioplayers
record
path_provider
path
sqflite
```