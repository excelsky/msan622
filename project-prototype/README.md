Project: Prototype
==============================

| **Name**  | Kicho Yu  |
|----------:|:-------------|
| **Email** | kyu12@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:
- `ggplot2`
- `plyr` 
- `RColorBrewer` 
- `reshape2` 
- `scales` 

To run this code, please enter the following commands in R:

```
library(shiny)
runGitHub("msan622", "excelsky", subdir = "project-prototype")
```
This will start the `shiny` app. See below for details on how to interact with the visualization.  


## Discussion ##
### Data ###
The dataset is called `adult.data` from [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Adult). It is also called '1994 Census database.'  
As of data munging, I deleted rows that have NA's. In this case, the NA was coded as ` ?` which is different from `?`. It took a decent time for me to figure out the difference. The original dataset has 32561 rows and there are still 30162 rows left after this munging. Thus, this deletion technique is easier and much advisable than other techniques such as converting NA's into a categorical variable, as the data is preserved by 92%.


### Techniques ###

I have chosen the following visualization techniques for this prototype:

- Bubble Plot (Interactive)
- Scatter Plot (Static)


#### Techniques 1: Bubble Plot (Interactive) ####
I created two `sliderInput`s. These slide

![IMAGE](HAG5.JPG) 

#### Techniques 2: Scatter Plot (Static) ####
The sliders explained in **Stacked Area Plot** are working here as well. As written above, users use these sliders to adjust their specific time period to focus.  

![IMAGE](HAG5.JPG) 
