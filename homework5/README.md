Homework 5: Time Series Visualization
==============================

| **Name**  | Kicho Yu  |
|----------:|:-------------|
| **Email** | kyu12@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `ggplot2`
- `RColorBrewer`
- `reshape2`
- `scales`
- `shiny`

To run this code, please enter the following commands in R:

```
library(shiny)
shiny::runGitHub('msan622', 'excelsky', subdir = 'homework5')
```

This will start the `shiny` app. See below for details on how to interact with the visualization.

## Discussion ##
  
### Options ###
I chose **Option 2: Interactive** and created `shiny` plots. I have three `R` files: `server.R`, `ui.R`, and `global.R`. Technically, I learned how to use `shiny` with only `server.R` and `ui.R`, but I wanted to challenge myself. I found that there is another way to utilize `shiny`: use `global.R` along with `server.R` and `ui.R`. `global.R` is where data manipulations and all the core data analytics happen. It reduces the complexity of code in `server.R`.

### Dataset ###

It was not easy to figure out the structure of data `Seatbelts`. It is not a regular `data.frame` but a multiple-column time series object `ts`. I converted it into a `data.frame` to plot in `ggplot2`. I added a time column: year, month, and time. I used `reshape2::melt()` to convert this data frame into a long data frame.

### Techniques ###

I have chosen the following visualization techniques:

- Stacked Area Plot
- Line Plot


#### Techniques 1: Stacked Area Plot ####
I created two `sliderInput`s. These sliders enable users to choose the time frame that they want to focus. It is like a magnifying glass. The first slider *Months* is to zoom in a specific month period in the data set. The users can see 4 months to 24 months. The second slider *Starting Point* is self-explanatory; users can choose the beginning point of the data. For example, if they want to see the data from the year 1970 for 6 months, then they select 6 in *Months* and 1970 in *Starting Point*.  
Also there is a `checkboxGroupInput` so that users can choose variables that they want to see. There are three variables: *DriversKilled*, *front*, and *rear*. They are respectively car drivers killed, front-seat passengers killed or seriously injured, and rear-seat passengers killed or seriously injured. Users can choose at least one variable. If they choose no variable, then an humourous error message pops up.


#### Techniques 2: Line Plot ####
The sliders explained in **Stacked Area Plot** are working here as well. As written above, users use these sliders to adjust their specific time period to focus.  
There is a `radioButtons` so that users can choose variables that they want to see. Like **Stacked Area Plot** above, there are the same three variables: *DriversKilled*, *front*, and *rear*. Since it is a radio buttons, users can choose only one variable at a time. The chosen variable is displayed on this **Line Plot**

### Evaluation ###

It was a happy challenging experience to aim for best possible lie factor, data-ink ratio, and data density. These three factors are key points in the data visualization evaluation. So I did quite a few adjustment to achieve.  

In order to have a high data density, I adjusted the size of the plot and the side bar. The plot is large and the side bar is narrow. In order to have a high data ink ratio, I adjusted the labels smaller and had more concise in language.  In order to have a reasonable lie factor, I had a "flexible" y-axis on both plots. In other words, when users changes variables, the y-axis range changes in accordance with those variables, so plot does not *lie* or mislead them.
