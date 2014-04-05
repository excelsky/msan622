Homework 2: Interactivity
==============================

| **Name**  | Kicho Yu  |
|----------:|:-------------|
| **Email** | kyu12@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `ggplot2`
- `shiny`
- `scale`

To run this code, please enter the following commands in R:

```
library(shiny)
shiny::runGitHub('msan622', 'excelsky', subdir='homework2')
```

This will start the `shiny` app. See below for details on how to interact with the visualization.

## Discussion ##

![IMAGE](screenshot.jpg)  

It is an interactivity of shiny and ggplot2 in R to see IMDB Movie Ratings. My display has two tables: a scatterplot and a table. A scatter plot is a comparison of budget versus IMDB ratings. A table shows a list of 1800 movies taken from the "movies" dataset in ggplot2.

A scatterplot has five main functions: MPAA Rating, Movies Genres, Color Scheme, Dot Size, and Dot Alpha.
MPAA Rating shows five ratings: NC-17, PG, PG-13, R, and all of them. It is using `radioButtons()`
Movies Genres, 
Color Scheme, 
Dot Size, 
Dot Alpha.

 
