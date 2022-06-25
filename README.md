![Xcode build](https://github.com/Dimillian/MovieSwiftUI/workflows/Xcode%20build/badge.svg?branch=master)

# Countries

Countries is an application that uses the GeoDB API and is built with Swift. 
It demos some Swift concepts. The goal is to make a real world application using Swift only.

## What does this application do?

This application retrieves countries and their details; then it shows them at the list. You can save the countries which you like to the saved countries list. Also you can see the country details by clicking one of the country.

This application includes three pages:

### Countries List Page

This page includes list of countries which are retrieved from GeoDB API. You can save the countries you like to the saved countries list by clicking heart shaped button.

### Saved Countries Page

This page includes list of saved countries which are saved by the user. You can delete the countries from the saved countries list by clicking heart shaped button.

### Country Details Page

This page includes country details retrieved from GeoDB API. It includes image of flag, country code and a button for navigating to Wiki Page of the country.

Unfortunately, API doesn't contains all of the images as PNG format. The most of the images' formats are SVG. Swift doesn't support SVG formatted.


## Platforms

Currently Countries runs on iPhone, iPad.
