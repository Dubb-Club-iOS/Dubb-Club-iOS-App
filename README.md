# Dubb Club iOS

## Table of Contents
1. [Sprint 4 Updates](#Sprint-4-Updates)
1. [Sprint 3 Updates](#Sprint-3-Updates)
1. [Sprint 2 Updates](#Sprint-2-Updates)
1. [Sprint 1 Updates](#Sprint-1-Updates)
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Schema](#Schema)

## Sprint 4 Updates
### Below are the gifs for our week 4 sprint.

Favorite Teams / View Team Detail:

![favorites-sprint4](https://user-images.githubusercontent.com/43022012/116014626-2d98ca00-a604-11eb-9f50-6fc0be54c13b.gif)

View League Standings:

![standings-sprint4](https://user-images.githubusercontent.com/43022012/116014599-093ced80-a604-11eb-90fe-e07662829e24.gif)

Sort Games By Confidence: 

![sort-by-confidence-sprint4](https://user-images.githubusercontent.com/43022012/116014607-1954cd00-a604-11eb-93c9-769e4e524973.gif)

Search By Team:

![search-by-team-sprint4](https://user-images.githubusercontent.com/43022012/116014816-20300f80-a605-11eb-9771-c2e213d7d5cf.gif)

Search By Date:

![search-by-date-sprint4](https://user-images.githubusercontent.com/43022012/116014829-2920e100-a605-11eb-9b68-6364a9d1f886.gif)

Past Game Details Page:

<img src="http://g.recordit.co/bpMnOBeXz7.gif" width=250><br>

## Sprint 3 Updates
### Below are the gifs for our week 3 sprint.

Launch Screen:

![launch-screen-sprint3](https://user-images.githubusercontent.com/43022012/115166134-7b9b5400-a07f-11eb-9aaa-a180d3c9aa8b.gif)

Tab Bar:

<img src="http://g.recordit.co/NwHu9MBsi5.gif" width=250><br>

## Sprint 2 Updates
### Below are the gifs for our week 2 sprint. 

Updated Login (unified theme and remember user on reopen):

![updated-login-sprint2](https://user-images.githubusercontent.com/43022012/114328375-69169d00-9b0a-11eb-942b-113fd8563828.gif)

Home Feed (added team assets and game data):

![home-stream-sprint2](https://user-images.githubusercontent.com/43022012/114327230-2fdc2e00-9b06-11eb-83c0-1e9025d2a4f0.gif)

Search Page:

![search-bar-sprint2](https://user-images.githubusercontent.com/43022012/114327203-1509b980-9b06-11eb-9c11-3cdef4214aa0.gif)


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
- [X]  Make an account.
- [X]  Login
- [X]  Follow/unfollow teams.
- [X]  Search games (by team name and by date)
- [X]  View games schedule.
- [X]  View league standings
- [X]  View played game stats.
- [X]  View profile page

**Optional Nice-to-have Stories**
- [X]  View team and player stats
- [ ]  Vote on game outcomes
- [X]  Sorting by confidence, etc.
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
	-   User can view a team???s record and average statistics 
	-   User can view player statistics for a given team 
-   Past Game Details
	-   User can view statistics about a specific game
	-   User can view a team???s record
-   Standings
	-   User can view all teams' standings in their respective conferences (East/West)
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
-   Standings
-   Profile

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


