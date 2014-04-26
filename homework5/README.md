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
I chose **Option 2: Interactive** and created `shiny` plots. I have three `R` files: `server.R`, `ui.R`, and `global.R`. Technically, I learned how to use `shiny` with only `server.R` and `ui.R`, but I wanted to challenge myself. I found that there is another way to utilize `shiny`; to use `global.R`. `global.R` is where a data manipulation and all the core data analytics happen. It reduces the complexity of code in `server.R`.

### Dataset ###

You can learn more about the `Seatbelts` dataset by running `help(Seatbelts)` in `R`. It is a multiple-column time series object. You may want to convert this to a data frame to plot later in `ggplot2`. You can decide exactly what in this dataset you visualize, as long as you include the time component.

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

