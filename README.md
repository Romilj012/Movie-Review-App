# Movie Review App

This is a Movie Review App that allows users to browse and review movies. It is built using Firebase for user authentication, storage, and database functionality. The app fetches movie information from an API and displays it in a master/detail flow, along with user reviews retrieved from Firebase.

## Features

**1. Movie Information:** The app downloads movie information from an API and displays it in the master view. The movie data includes the poster icon, title, and the number of reviews if they exist.

**2. User Authentication:** Users can create accounts and log in to the app. User credentials and profiles are saved in Firebase for secure authentication.

**3. User Profiles:** Upon successful registration, users are directed to the profile editing screen. They can add a profile image, along with at least three additional pieces of information. Profile images are selected and uploaded to Firebase. If a profile image is not selected, a default image is used.

**4. Review System:** Users can write reviews for movies, and these reviews are saved in Firebase. In the detail view, reviews are displayed in a separate section. Each review includes the user name, the review text, and the number of likes or dislikes tapped by other users. Users can only edit or delete their own reviews.

**5. Navigation and Profile Editing:** The navigation bar displays the user's information, including a profile icon and name. Tapping on this information launches the profile screen, where users can edit their profile details.

**6. Firebase Integration:** The app utilizes Firebase for authentication, real-time database updates, and storage. Firebase Auth handles user authentication, Firebase Database stores review data, and Firebase Storage saves profile images. The demo video showcases the Firebase integration and updates for each user action.

**7. Quality and Design:** The app is designed with a focus on quality and user experience. The UI includes intuitive navigation, visually appealing review cells, and an overall polished design.

## Requirements

To run the Movie Review App, you need the following:

- Xcode (minimum version 13.0)
- iOS device or simulator running iOS 11.0 or later
- Firebase account with authentication, real-time database, and storage set up
- API key for movie information retrieval (replace `API_KEY` in the code with the actual key)

## Installation and Setup

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Install any necessary dependencies using CocoaPods or Swift Package Manager.
4. Set up Firebase in your project by adding your Firebase configuration file and updating the necessary Firebase SDKs.
5. Replace the placeholder `API_KEY` in the code with your actual API key for movie information retrieval.
6. Build and run the app on your iOS device or simulator.

## Demo Video

To see a demo of the app in action, check out the [demo video](link-to-demo-video).

## Feedback and Contributions

Feedback and contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue in the GitHub repository. You can also submit pull requests for bug fixes or new features.

## License

This project is licensed under the [MIT License](link-to-license-file). Feel free to use and modify the code according to the terms of the license.

## Acknowledgements

We would like to thank the following resources and libraries for their contributions to this project:

- Firebase: [link to Firebase website](https://firebase.google.com/)
- TMDB API Name: [link to API website](https://www.themoviedb.org/documentation/api)

## Contact

For any inquiries or further information, please contact romilj012@gmail.com
