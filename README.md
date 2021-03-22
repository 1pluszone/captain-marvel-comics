# Captain Marvel Comics

This is a demo app to demonstrate the power and awesomeness of Flutter/Dart.
## About the App

This mobile app consumes Marvel api in order to show all lists of captain marvel's comics.

It is divided into three section.
1. The home page. An attempt to copy cat [Captain Marvel Carol Danvers homepage.](https://www.marvel.com/characters/captain-marvel-carol-danvers) (work still in progress).

2.  A list of all comics in which Captain Marvel appears, starting all the way from 1977 when the superhero was initially known as Mz Marvel.

3. A list of all Captain Marvel only comics.

<img src="https://github.com/1pluszone/captain-marvel-comics/blob/dev/screenshots/homePage.png" height="350">

<img src="https://github.com/1pluszone/captain-marvel-comics/blob/dev/screenshots/listPage.png" height="350">

<img src="https://github.com/1pluszone/captain-marvel-comics/blob/dev/screenshots/each_comic.png" height="350">


## How?
This is a very basic app which shows how to consume Marvel api in flutter.

The code structure was laid out in a MVVM design pattern and Provider was chosen for management of state.

M - This is placed in the resources folder. It contains all api calls and proposed sqlite codes (for offline support).

VM - This is found in the providers folder. Provider is a powerful tool to mange states. It Communicates and updates the view whenever there are changes. Provider is  recommended by the [flutter team](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple) as it reduces boiler plates common with RxDart and streams implementation.

V - Placed in the View folder. Concerned with what the user sees and touch. This include all reusable widgets and listeners.



## Additions and subtractions are welcome :kissing_heart::kissing_heart:


