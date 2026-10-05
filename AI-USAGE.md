# AI usage

This project was built with AI assistance. This file is the record of it. It is
graded as the finals badge, and it is worth 100 points.

Start it in week 1 and keep it up as you go. The commit history of this file is
part of the evidence: a file written all at once the night before the deadline
looks exactly like what it is.

## 1. How I used AI

At least six entries. One per real use. Every entry needs a commit link.

2026-10-01 - New Trip and Shopping List implementation

- Tool: ChatGPT
- What I asked for: Help with implementing the New Trip and Shopping List features for my Flutter shopping tracker application.
- What it gave back: It provided guidance and code suggestions for creating the New Trip screen, Shopping List screen, state management, shopping item and trip models, and saving application data.
- What I kept, what I changed, and why: I kept the general implementation ideas that matched my project requirements. I changed the code, names, layout, and details where necessary so they matched my own design and project structure.
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/254c7335ee947d9b4ead21a443103bc1fcb79cce **

Application state and data saving
- Tool: ChatGPT
- What I asked for: Help understanding how to manage the application's shopping trips and items and keep the data after restarting the application.
- What it gave back: It suggested using application state management together with local storage through shared_preferences.
- What I kept, what I changed, and why: I kept the idea of storing the application's trip data locally. I adjusted the implementation to match the data models and screens used in my application.
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/254c7335ee947d9b4ead21a443103bc1fcb79cce **

Flutter screen structure
- Tool: ChatGPT
- What I asked for: Help organizing the Flutter screens and connecting them to the application's main navigation and state.
- What it gave back: Suggestions for separating the screens into individual Dart files and connecting them through the main application.
- What I kept, what I changed, and why: I kept the separation of the screens because it made the project easier to organize and maintain. I changed parts of the suggested structure to fit my existing files.
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/254c7335ee947d9b4ead21a443103bc1fcb79cce **

README live demo correction
- Tool: ChatGPT
- What I asked for: Help correcting the GitHub Pages live demo link in the README.
- What it gave back: It helped identify the correct repository URL format for the live demo.
- What I kept, what I changed, and why: I kept the corrected GitHub Pages URL and changed the placeholder URL to my actual repository URL.
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/254c7335ee947d9b4ead21a443103bc1fcb79cce **

README link verification
- Tool: ChatGPT
- What I asked for: Help checking why the live demo link in the README was still incorrect.
- What it gave back: It identified that the previous README link still contained an unnecessary repository placeholder.
- What I kept, what I changed, and why: I kept the corrected link format and removed the remaining placeholder so the link points directly to the deployed application.
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/254c7335ee947d9b4ead21a443103bc1fcb79cce **

Project initialization and Flutter setup
- Tool: ChatGPT
- What I asked for: Help understanding the starter Flutter project structure and what files and components were needed for the shopping tracker application.
- What it gave back: It explained the purpose of the starter files and gave guidance for turning the starter project into the application's structure.
- What I kept, what I changed, and why: I used the guidance as a reference and changed the project according to my own requirements instead of keeping the starter implementation unchanged.
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/254c7335ee947d9b4ead21a443103bc1fcb79cce**

## 2. Where the AI got it wrong

Three cases. Be specific. If you write that the AI was never wrong, this section
scores zero.

Case 1 - Incorrect live demo URL
- What it gave me: The suggested live demo URL still contained a repository placeholder.
- What was wrong with it: The URL did not point directly to my actual deployed Shop Tracker application.
- What I did instead: I replaced the placeholder with my actual GitHub Pages URL and tested the link.
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/c48e59acd97e8163a0bf8813b4a2d70564071777**

Case 2 - Repository placeholder remained
- What it gave me: The README contained a GitHub Pages URL with YOUR-REPO still included.
- What was wrong with it: The link was not a valid direct link to my deployed application.
- What I did instead: I removed the placeholder and changed the link to https://hannanicoleangeles5.github.io/Shop_Tracker/.
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/40b0798d83d653a3169203c34b3a5c8ebc88c8c8**

Case 3 - Generated code needed project-specific changes
- What it gave me: AI suggestions for Flutter screens and application state management.
- What was wrong with it: Some of the suggested code did not exactly match my existing project structure, variable names, or required design.
- What I did instead: I used the suggestions as a reference, then modified the code to match my actual Shop Tracker screens, models, state management, and project requirements.
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/254c7335ee947d9b4ead21a443103bc1fcb79cce**

## 3. Who wrote what

At least a fifth of this project is code you wrote yourself. Name it, and explain
it in your own words.

> Group projects: give each member their own heading below, and use your GitHub
> handle as the heading. You are graded on your own section.

Written by me
- File: lib/screens/ and project-specific Flutter files
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/254c7335ee947d9b4ead21a443103bc1fcb79cce**
- What it does and why it is built this way: I worked on the project-specific Flutter implementation, including the screens and application behavior. The code is organized into separate screen files so that each feature is easier to understand, maintain, and modify. I also adjusted the implementation to match the required Shop Tracker design and functionality.

The AI-written part I understand best
- File: lib/state.dart
- **Commit: https://github.com/hannanicoleangeles5/Shop_Tracker/commit/254c7335ee947d9b4ead21a443103bc1fcb79cce**
- What it does and why we kept it: This file manages the application's shopping-trip and shopping-item data. It allows the different screens to access and update the current application state. It was kept because having a centralized state makes it easier for the New Trip, Shopping List, and History screens to work with the same data.
