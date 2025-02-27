# Crypto-App

Clone the repository:

Open the project file in Xcode.
Select the desired simulator or connected device.
Click Run in Xcode.

Running the application:

Home Screen
The app will display a list of cryptocurrency coins.
Select a coin to view it's detailed information.
Swipe left on any coin to add it to your favorites list.
Swipe left again on any favorited coin to remove it from favorites.

Favorite Coin Screen:
Switch to the "Favorites" tab to view all your favorited coins.
You can repeat the same process (swipe left to remove).
Assumptions and Decisions Made


Coin List and Favorites:
Coins are displayed in a list, and their details are accessible by selecting a coin.
The favorites functionality is managed by swiping left on a coin.
Favorite coins are displayed on a separate table.


Data Persistence:
For simplicity, userDefaults is used to maintain the state of favorited coins between screens by saving their ID, which we will later use to retrive the coins which have more updated data. This ensures that the state is maintained when navigating between the coin list and the favorites screen.


Challenges Encountered and How They Were Addressed

Displaying SVG Images:
One of the biggest challenges I faced was displaying SVG images on the screens, as the default image handling methods didn’t support SVG format. I solved this by integrating the WebKit framework, which allows for better handling of SVG images in iOS. I had never worked with WebKit before, so it required some learning, but it worked well for rendering the images as needed.


Passing Data Between Screens:
Initially, I faced issues with passing data from the Coin List screen to the Favorites screen using a data transporter. The data was not being transferred correctly, and it took me some time to identify that the issue was related to the way I was managing shared data. After further investigation, I decided to implement a shared data manager to store the list of all coins, ensuring that data was properly synced between the screens.
