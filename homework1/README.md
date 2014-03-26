Homework 1: Basic Charts
==============================

| **Name**  | Kicho Yu  |
|----------:|:-------------|
| **Email** | kyu12@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `devtools`
- `ggplot2`
- `plyr`
- `reshape2`
- `scales`

To run this code, please enter the following commands in R:

```
library(devtools)
source_url("https://raw.github.com/excelsky/msan622/template/homework1/622_Visualization_HAG1.R")
```

This will generate 4 images and some text output. See below for details.

## Discussion ##

First, I imported `movies` and `EuStockMarkets` and munged in accordance with the homework instruction.

- **Plot 1: Scatterplot.** 
Produce a scatterplot from the `movies` dataset in the `ggplot2` package, where `budget` is shown on the x-axis and `rating` is shown on the y-axis. Save the plot as `hw1-scatter.png`.

- **Plot 2: Bar Chart.**
Count the number of action, adventure, etc. movies in the `genre` column of the `movies` dataset. Show the results as a bar chart, and save the chart as `hw1-bar.png`.

- **Plot 3: Small Multiples.**
Use the `genre` column in the `movies` dataset to generate a small-multiples scatterplot using the `facet_wrap()` function such that `budget` is shown on the x-axis and `rating` is shown on the y-axis. Save the plot as `hw1-multiples.png`.

- **Plot 4: Multi-Line Chart.**
Produce a multi-line chart from the `eu` dataset (created by transforming the `EuStockMarkets` dataset) with `time` shown on the x-axis and `price` on the y-axis. Draw one line for each index on the same chart. Save the plot as `hw1-multiline.png`.
