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

You may choose from the following visualization techniques:

- Line Plot
- Stacked Area Plot
- Multiline Plot
- Star Plot
- Heatmap
- Circle View

You may choose other techniques with instructor approval.

### Evaluation ###

Attempt to create pixel-perfect visualizations with the best possible lie factor, data-ink ratio, and data density (within reason). 

