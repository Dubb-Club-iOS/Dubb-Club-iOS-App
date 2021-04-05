# Dubb Club iOS

## Table of Contents
1. [Sprint 1 Updates](#Sprint-1-Updates)
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Schema](#Schema)

## Sprint 1 Updates
### Below are the gifs for our week 1 sprint. 
Please note that since this week focused primarily on design, checking off of user stories is limited.

Home Feed:

![home-stream-sprint1](https://user-images.githubusercontent.com/43022012/113498127-220c2480-94d8-11eb-8630-ea8df2c0a6e1.gif)

Login Page and Registration Page:

<img src="http://g.recordit.co/Ws0uhGwKmN.gif" width=250><br>

Profile Page:
![profile-tab](https://user-images.githubusercontent.com/43022012/113529863-a1f6c500-9592-11eb-9453-a399fd1e37b8.gif)



## Overview
### Description
Dubb Club makes predictions for upcoming NBA games and displays the confidence of those predictions, along with other game and team statistics. It can be used to help with sports betting, or just by those who are fans of sports in general.

### App Evaluation
- **Category:** Sports
- **Mobile:** This app can be developed for computer or mobile. However, the mobile version requires differences in design to accommodate the smaller screen size and smartphone UX.
- **Story:**  Predicts outcomes of NBA games and presents results to users along with other game and team statistics.
- **Market:** Any individual could choose to use this app, but the main focus is those who have an interest in the NBA or sports in general. 
- **Habit:** Usage of this app depends on just how interested a user is in the NBA or if they enjoy betting on sports games. It is also expected usage would decrease during the offseason.
- **Scope:** We are first starting with just NBA games, but there is room for growth in adding other major sporting leagues and potentially adding other social media features like forums or voting on probabilities.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**
- [ ]  Make an account.
- [ ]  Login
- [ ]  Follow/unfollow teams.
- [ ]  Search games (by name)
- [ ]  View games schedule.
- [X]  View upcoming game predictions
- [ ]  View played game stats.
- [ ]  View profile page

**Optional Nice-to-have Stories**
- [ ]  View team and player stats
- [ ]  Vote on game outcomes
- [ ]  Sorting by confidence, etc.
- [ ]  Store/cache data locally
- [ ]  Change password.

### 2. Screen Archetypes
-   Login Screen
	-   User can login 
-   Registration Screen
	-   User can create a new account
-   Stream
	-   User can view a feed of game predictions and stats 
	-   User can vote on what they think the outcome of a game will be (optional) 
-   Team Details
	-   User can view a team’s record and average statistics 
	-   User can view player statistics for a given team 
-   Past Game Details
	-   User can view statistics about a specific game
	-   User can view a team’s record
-   Search 
	-   User can search for a specific team and view predictions and previous results
	-   User can select a game to view the game details
-   Profile
	-   User can view their identity 
	-   User can view their followed teams
-   Settings (optional)
    -   User can view account details
	-   User can change their password 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

-   Home Stream
-   Search Page
-	Profile

**Flow Navigation** (Screen to Screen)
-   Login Screen -> Registration Screen/Home Stream
-   Registration Screen -> Login Screen/Home Stream
-   Stream -> Team Details/Game Details
-   Search -> Team Details/Game Details
-   Profile -> Settings/Team Details
-	Settings -> Toggle settings


## Wireframes
![handwritten wireframe](https://user-images.githubusercontent.com/43022012/112067106-ee2b1980-8b3d-11eb-96f2-fa5b275b78b4.jpg)

## Digital Wireframe Draft
<img width="1401" alt="Screen Shot 2021-03-21 at 10 58 04 PM" src="https://user-images.githubusercontent.com/43575529/111935139-33494000-8a99-11eb-86f2-90d8ea0502d9.png">

## Schema
### Models

#### TeamObject
| Property      | Type | Description |
| ----------- | ----------- | ----------- |
| teamId      | Integer    | unique id for the team|
| teamName    | String     | The name of the team |
| teamImage   | String     | url to team logo |

#### GameObject
| Property      | Type | Description |
| ----------------- | ------------- | ----------- |
| gameId      		| Integer    	| unique id for the game|
| date      		| Date     		| The date of the game |
| homeTeam      	| TeamObject	| Team object of the home team |
| awayTeam      	| TeamObject	| Team object of the away team |
| predictedWinner  	| Integer		| id of the predicted winning team |
| confidence  		| Float			| confidence of the prediction |

#### UserObject
| Property      | Type | Description |
| ----------- | ----------- | ----------- |
| username      | String    | unique username for the user|
| email      	| String    | unique email for the user |
| password      | String	| the password for logging in |
| favoriteTeams | [Integer] | array of the teams a user is following  |

#### List of network requests by screen

- Login
	- (POST) Login the user if the credentials are correct 
- Registration
	- (POST) Register a new user
- Home Stream
	- (GET) Query all upcoming games based on date
- Team Detail
	- (GET) Get team statistics
	- (PUT) Follow a team and add it to the user object
- Search
	- (GET) Get games based on search parameters
	- (GET) Get teams based on search parameters
- Profile Page
	- (GET) Get user details for displaying
	- (PUT) Unfollow a team 


