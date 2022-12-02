# **Name of project: ArtI**
    - Description: AI art generator 
    - Team members: Christopher Poon, Stephanie Vu, Peiran Wang
    - Dependencies: Xcode Version 14.0.1, Swift 5, Firebase 9.6.0

## **Special Instructions:**
    - Use minimum deployment: IOS version 15.0
    - Use an iPhone 13 pro max Simulator
    - Use this test account for logging in:
        - email: test@gmail.com
        - password: abcdef
    - There is a cooldown on the number of keyphrases you can use on the free API
        -10 images and about 10 minute cooldown period

## **Required feature checklist**
- [x] Login/register path with Firebase.
- [ ] “Settings” screen. The three behaviors we implemented are: (waived)
    - [x] sound on/off (waived)
    - [ ] dark mode (waived)
    - [ ] font change (waived)
- [x] Non-default fonts and colors used

## **Two major elements used:**
- [x] Core Data to save album images 
- [ ] User Profile path
- [x] API Call in the background: Multithreading
- [ ] SwiftUI

## **Minor Elements used:**
- [x] Two additional view types such as sliders, segmented controllers, etc. The two we implemented are: 
    - [x] segmented controller in backgroundaudioVC 
    - [x] bar button (delete button) in the imageVC
    ### **One of the following:**
    - [x] Table View
    - [x] Collection View
    - [ ] Tab VC
    - [ ] Page VC

    ### **Two of the following:**
    - [x] Alerts
    - [ ] Popovers
    - [ ] Stack Views
    - [x] Scroll Views
    - [ ] Haptics
    - [ ] User Defaults

    ### **At least one of the following per team member:**
    - [x] Local notifications
    - [ ] Core Graphics
    - [x] Gesture Recognition
    - [x] Animation
    - [ ] Calendar
    - [ ] Core Motion
    - [ ] Core Location / MapKit
    - [x] Core Audio
    - [ ] Others (such as QR code, Koloda, etc.) with approval from the instructor – list them

## **Work Distribution Table:**
| Required Feature    | Description                                                                                       | Who / Percentage worked on         |
| ------------------- | --------------------------------------------------------------------------------------------------| -----------------------------------|
| Login / Register    | Allows user to create account and login through firebase                                          | Chris (100%)                       |
| UI Design           | Team shared equally in designing the wireframe for the app, and selecting colors and fonts.       | Chris (33%) Steph (33%) Pei (33%)  |
| Title/Logo          | Team shared equally in name and logo design                                                       | Chris (33%) Steph (33%) Pei (33%)  |
| Create Logo         | Fox designed with AI generated art                                                                | Steph (100%)                       |
| Create Backgrounds  | Apply themes with background images                                                               | Steph (100%)                       |
| Apply Theme         | Apply Backgrounds, themes, fonts  to All VC                                                       | Pei   (100%)                       |
| Home Screen VC      | Allow users to choose between Make Image VC, Album VC, Setting VC pathway                         | Steph (100%)                       |
| Core Audio          | Allow users to turn music on/off in the settings VC                                               | Chris (100%)                       |
| Implement Core Data | Allow user to save pictures in the album upon picture creation / Delete pictures                  | Steph (100%)                       |
| Create Album Collection View | Allows user to view and select pictures created                                          | Steph (100%)                       |
| Scroll View         | Upon picture selection in AlbumVC and scroll around in the picture                                | Steph (100%)                       |
| Loading animation   | Create loading animation while waiting for API Call                                               | Chris (100%)                       |
| API Call Multithreading | Call API using multithreading and alerts user when server doesn't respond                     | Chris (100%)                       |
| Create Text Input   | Used to read user input for keywords for AI generation and alerts with bad values                 | Chris (100%)                       |
| Logo Screen         | Intro Page with logo screen and login                                                             | Chris (100%)                       |
| Settings screen     | implemented with tableView                                                                        | Chris (100%)                       |
| Gesture Recognition | Use long press to save to camera roll                                                             | Steph (100%)                       |
| Core Audio          | Allow background music between all VC using core audio                                            | Chris (100%)                       |
| local Notification  | Create notification to create art once a day                                                      | Pei   (100%)                       |
| log out button      | allow the user to logout from the homescreen                                                      | Steph (100%)                       |