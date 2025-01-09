# Chef-iOS (A4: ChefOS)
Chef-iOS is a dynamic iOS application that offers a seamless experience for exploring and managing recipes. The app allows users to browse a collection of recipes, view detailed information about each recipe, and filter recipes based on specific categories such as difficulty levels. Built using UIKit and Alamofire, the app leverages multiple collection views to organize and present content in an intuitive, visually appealing way.

Key Features:

Detailed Recipe View: When a user taps on a recipe, they are presented with a detailed view showcasing essential information like ingredients, instructions, cooking time, and images. This provides an in-depth look at each recipe to help users with step-by-step preparation.

Filtering Functionality: The app includes a horizontally scrolling collection view displaying filter pills, which allow users to filter recipes by categories such as difficulty level (Beginner, Intermediate, Advanced) or other relevant criteria. Users can apply these filters to dynamically narrow down the recipe list to suit their preferences.

Dynamic Recipe Fetching: The app integrates with an external API to fetch recipes in real time. This ensures that the app always displays the most up-to-date recipe data. The fetching mechanism is powered by Alamofire, a powerful networking library for making HTTP requests and handling responses seamlessly.

Multiple Collection Views: The app features two main collection views: one for displaying the list of recipes and the other for the filter pills. These collection views are configured to work together, allowing users to interact with both the recipes and the filters smoothly within the same interface.

UIKit for UI Components: The app is designed using UIKit, Apple's framework for creating user interfaces. This ensures that the app is responsive and provides a native look and feel, with smooth animations and transitions between the recipe list and the detailed recipe views.

Alamofire for Networking: The app uses Alamofire to handle networking tasks, such as fetching data from an external recipe API. Alamofire simplifies the process of making HTTP requests, handling responses, and dealing with any errors that might arise during the data-fetching process.
