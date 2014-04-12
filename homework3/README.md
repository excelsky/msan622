Homework 3: Multivariate
==============================

| **Name**  | Kicho Yu  |
|----------:|:-------------|
| **Email** | kyu12@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `GGally`
- `ggplot2`
- `RColorBrewer`
- `scales`
- `shiny`


To run this code, please enter the following commands in R:

```
library(shiny)
shiny::runGitHub('msan622', 'excelsky', subdir='homework3')
```

This will start the `shiny` app. See below for details on how to interact with the visualization.

## Discussion ##

### Technique 1: Heatmap or Bubble Plot ###
#### Bubble Plot ####
I chose a bubble plot to use, because I think my data are better in this plot than heatmap. A bubble plot can show each 50 state in the United States as a discrete and distinct bubble, whereas a heatmap shows the 50 states continuously. Also, I think a bubble plot gives more freedom in location than a heatmap. Therefore, I think a readability is increased by selecting a bubble plot over a heatmap.  

#### Customization ####
1. The legend is placed in the bottom right. By being inside of the plot, it does not take an extra space, so it does not shrink the plot per se.  
2. The data are re-ordered in order to prevent the large bubbles from overlapping small bubbles.  
3. An annotation has been placed on the plot to display what the circles mean.  

![IMAGE](Bubble Plot.jpeg)  

### Technique 2: Scatterplot Matrix or Small Multiples ###
#### Scatterplot Matrix ####
Here 

#### Customization ####
1. Th
![IMAGE](Scatterplot Matrix.jpeg)  

### Technique 3: Parallel Coordinates Plot ###
Here 

#### Customization ####
1. Th
![IMAGE](Parallel Coordinates.jpeg)  

## Interactivity ##
Overall, you can select three types of plots using the navigation bar. There are two drop-down tabs and a regular tab that you can select.

## Bubble Plot ##
You can choose variables for the x-axis and the y-axis. You can change the size and the color of bubbles. These selections are how you can __filter__ variables. You can either opt in or out the abbreviation of 50 states in the United States. I suggest to opt in for a readability.

![IMAGE](interactivity bubble plot.jpg)  

## Scatterplot Matrix ##

![IMAGE](interactivity scatterplot matrix.jpg)  

## Parallel Coordinates Plot ##
For some reason, the _Color By:_ is working as a __sorting__ in the order of column: increasing and decreasing.


![IMAGE](interactivity parallel coordinates plot.jpg)  
