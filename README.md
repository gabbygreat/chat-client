# ChatApp

## Project Structure

The project is divided into  layers

 - Data Layer
    - Local DB 
    - API Service
    - Shared Preferences
   
- Domain Layer 
    - repository

- Feature Layer
    - presentation/UI (widgets)
    - business logic (riverpod)


Each Layer has it's own function and jurisdictions 

the correct flow of data is represented in the list above


## Data Layer
This would be properly documented when we have a full grasp of all the different ways the app interacts with data both locally and from the internet

this consists of the models folder, some services that would be represented later like database and shared prefs, api requests, serialization and deserialization, etc

## Domain Layer
This is the connection between the data layer and presentation layer 
the domain layer handles transmission to and fro the data layer

this consists solely of the repository folder, this is the handshake between the other two layers 

## Feature Layer
This is where all of our UI and it's related logic would be handled

this consists of the views, widgets and some config files 

## Packages and Functions

- riverpod : state management
- sqflite : local database
- shared_preferences : data persistence and caching
- flutter_screenutil : responsiveness and adaptiveness
- go_router : declarative navigation
- flutter_native_splash : splash screen 
- shared_preferences : data persistence
- dio : networking
- flutter_svg : rendering svg illustrations and icons
- keyboard_dismisser: hides the keyboard when gestures are performed outside of it
- socket_io_client: client-side socket
- flutter_local_notifications: push notification
- lottie: render beautiful animations
- path:The path package provides common operations for manipulating paths.
- intl: for message translation, plurals and genders, date/number formatting and parsing.
- path_provider: for finding commonly used locations on the filesystem
- shimmer: A package provides an easy way to add shimmer effect in Flutter project
- flutter_svg: rendering of svg files
- platform_device_id: get device id of different devices