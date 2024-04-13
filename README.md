# Triangle Note App  ( :smile: ) [ Ios and Android ]

"Plateron" app is to provide a comprehensive and instructive showcase of a shopping application. It spotlights fundamental e-commerce features while making use of prominent Flutter libraries and design patterns. Through this demonstration, the app serves as a valuable learning resource for developers and enthusiasts, illustrating how to build a robust and user-friendly shopping platform that encompasses essential functionalities, advanced state management, and responsive user interfaces.

In this app we are showing the intaractive UI interface with static custom json data  to understand the basic flow. In this project we are using the clean architecture  with following folder breakup -> Parent folder - ( View, Bloc, Network ). We are using the modular approach for reduce the modular dependency between the each module of the project. Clean architecture also decouple the presentation layer and business layer.


## Logo

  <img src="https://github.com/vksep07/plateron_assignment/assets/16042343/53d1ca94-898a-47fc-8611-dac5579d2211" alt="Plateron Logo" width="300"/>


## Features

- Shopping Cart: Plateron enables users to effortlessly add products to their shopping carts, underpinned by a structured data system and intuitive add/remove item functionalities.

- Dependency Management with GetIt: The app seamlessly manages dependencies through GetIt, a widely adopted service locator and dependency injection tool within the Flutter framework.

- Efficient State Management with GetX and Bloc: GetX simplifies state management, navigation, and dependency injection, while Bloc provides a clean and predictable way to manage application state. These tools work in tandem to ensure a robust and efficient state management system.

- Streamlined Data Handling with RxDart: RxDart, an extension of Dart's Stream API, facilitates the handling of streams and reactive programming, making it invaluable for data management within the app.

- Dependency Injection Principles: The app adheres to the principles of dependency injection, promoting the separation of concerns by supplying external dependencies to components as needed, enhancing code modularity.

- Reusable UI Components: Plateron incorporates reusable UI components, such as product cards, buttons, and dialogs, enhancing code maintainability and promoting a consistent user interface.

- Adaptive Theme Support: Users have the flexibility to switch between light and dark themes, underscoring the app's commitment to a personalized and visually appealing user experience.
  
- Product Catalog: Plateron displays a catalog of products, empowering users to explore and select items for their shopping carts. This functionality encompasses fetching and rendering product data.

- Total Price Computation: The app computes the total cost of items in the cart, diligently tracking the quantity and price of each item and ensuring real-time updates to the overall cost.

- State Management Expertise: Plateron adeptly manages the state of both the cart items and product listings, leveraging the robust state management capabilities of GetX and the structured state management offered by Bloc.

- Quantity and Price Handling: The application excels at handling the nuances of item quantity and pricing for both cart and product items, gracefully adjusting these values in response to user interactions.

- Sample Data Integration: Plateron seamlessly integrates sample data from a static JSON file within the app, utilizing it to showcase product listings and cart items. This approach allows for realistic data presentation and interaction during app development.

- In essence, "Plateron" represents a sophisticated Flutter application that exemplifies the essential features commonly encountered in e-commerce platforms. Through the adept utilization of libraries like GetIt, GetX, Bloc, and RxDart, it delivers a seamless user experience, reinforcing its position as a compelling showcase of Flutter's capabilities in building modern shopping applications with advanced state management.

## Screenshots

![plateron_collage_android_light](https://github.com/vksep07/plateron_assignment/assets/16042343/4af53592-bb22-4e4f-bd99-a6e8ef1997c5)



![plateron_collage_dark](https://github.com/vksep07/plateron_assignment/assets/16042343/206c18a2-2634-4fc6-897a-b3933d8f8f66)



## App Preview Video


https://github.com/vksep07/plateron_assignment/assets/16042343/5b5bdb73-2648-4b91-acdd-30cf6a86af28


## Requirements

- Any Operating System (ie. MacOS, Windows, Linux)
- Flutter
- Android Studio or Visual Studio Code
- Basic knowledge of Flutter/Dart


## Installation

Clone the repo

```bash
  git clone https://github.com/vksep07/plateron_assignment
```

Install the dependencies

```bash
    flutter pub get
```

Run the App

```bash
    flutter run
```
### Created and maintained by
[Varun Kumar](https://github.com/vksep07)


If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of ☕<br>
!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)
## License

```
    MIT License

Copyright (c) 2022 Varun Kumar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```
