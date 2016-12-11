# [ApiAwakens](https://teamtreehouse.com/projects/the-api-awakens)
###by Alexey Papin 
[![StackShare](https://img.shields.io/badge/tech-stack-0690fa.svg?style=flat)](https://stackshare.io/zzheads/zzheads-at-gmail-com)
<img width="400"src="http://orig13.deviantart.net/55fb/f/2016/056/3/9/star_wars_logo_by_theflash17-d9t2ksh.png">

[![Build Status](https://travis-ci.org/Jintin/Swimat.svg?branch=master)](https://travis-ci.org/Jintin/Swimat)

<img width="400"src="http://orig13.deviantart.net/55fb/f/2016/056/3/9/star_wars_logo_by_theflash17-d9t2ksh.png">

###About this Course

A short time ago, in a Galaxy not so far away, you were taught about API’s. Now is your chance to harness the force (of newfound knowledge) and put the Star Wars API (SWAPI) to use in an iOS app.

Using what you have learned about API’s, Networking, Concurrency and JSON you will GET information about three types of Star Wars entities: people, vehicles and starships. Each entity type will have it’s own view from a user perspective, though they can certainly be based on common code and/or storyboards. See below for links to mock-ups for the app. It is worth noting that the API is paginated and you are only required to retrieve and display the first page of results for a given API request. Retrieving and displaying all pages for a result is required for a rating of "exceeds expectations".

You will notice that regardless of which view a user navigates to, there is a bar across the bottom showcasing the largest and smallest member of the group. In addition, because all measurements are given in metric units, you will need to create a feature that converts to British units, with a button tap. For starships and vehicles, students will need to create a button that can convert “Galactic Credits” to US Dollars, based on a exchange rate provided by the user in a text field.

Lastly, be sure to include appropriate error handling. Please demonstrate the ability to predict and handle errors, including but not limited to:

The device being offline when an API call is made
A user entering a 0 or negative exchange rate
An error resulting from a key or element missing from the JSON
If you would like to be eligible for a rating of “exceeds expectations” you will also need to implement an additional text view on the “people” screen that displays a list of any vehicles or starships, associated with that person or exhibit exceptional code quality, as per the rubric. You will also need to ensure that your API requests retrieve and display all pages of results, not just the first page, as is the default for the API.

- [x] You are free to submit this project in either Swift 2.3 or Swift 3. For Swift 2.3, if you are using Xcode 8, you will need to download and use the empty Swift 2.3 starter files template to start your project.
- [x] Create the appropriate types for people, vehicles and starships. Be sure to consider your options in terms of structs, classes, composition, inheritance, etc...
- [x] Create asynchronous networking code to download JSON from the SWAPI API. Be sure to make your code reusable for the different entities (people, vehicles, starships) you’ll be displaying.
- [x] Create logic to parse the JSON and display the names of all members of the entities in the Picker Wheel. You may need to seek outside documentation for guidance on using Pickers.
- [x] Create three layouts users can toggle between, one for each of: people, starships and vehicles. Make use of reusable elements, storyboards, etc… as you see fit. You may want to use a single layout and change/hide/show UI elements programmatically.
- [x] Create logic such that when a user selects from the wheel, all fields are populated.
- [x] Create logic to populate the Quick Facts Bar. (You may consider using generics here or elsewhere in your app.)
- [x] Create a feature such that a user can convert metric units to british units with a button tap.
- [x] Create a feature such that a user can input an exchange rate in a text field and then convert from Galactic Credits to US Dollars.
- [x] Add error handling as you see fit. This should include, but is not limited to:
      - The device being offline when an API call is made
      - A user entering a 0 or negative exchange rate (DID NOT DONE IT, SINCE THERE IS NO INPUT FROM USER)
      - An error resulting from a key or element missing from the JSON
 
- [x] UI elements are displayed for all screens using highly efficient code/logic.
- [x] Networking is asynchronous, error handling is robust, and code is well-crafted.
- [x] Data is displayed for all screens, pickers and fields using highly efficient code/logic.
- [x] Error handling is particularly robust, comprehensive and well implemented; going above and beyond those specific error types listed in the instructions.
- [x] Add additional text field such that when you select a person, all associated vehicles and/or starships are listed.
- [x] API Requests return and then display all results, not just the first page.
 
>
