Final Project
==============================

| **Name**  | Kicho Yu  |
|----------:|:-------------|
| **Email** | kyu12@dons.usfca.edu |

## Instruction ##
The following packages must be installed prior to running this code:
- `ggplot2`
- `plyr` 
- `RColorBrewer` 
- `reshape2` 
- `scales` 

To run this code, please enter the following commands in R:

```
library(shiny)
runGitHub("msan622", "excelsky", subdir = "final-project")
```
This will start the `shiny` app. See below for details on how to interact with the visualization.  


## Discussion ##
### Data ###
The dataset is called `adult.data` from [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Adult). It is also called '1994 Census database.' It shows demographic infomation of survey participants from all around the world and eventually wants to see who earns 50K USD per year or not. Examples of demographic infomation are age, years of education, highest degree in education, occupation, race, relationship, sex, and so forth. I chose this dataset, because it is easy to obtain and is big enough to slice and dice. It has 32546 rows and is about 3.75 MB. Also, it has rich demographic information, so I could use many techniques and interactivities that we learned in class. 

All the data cleaning is at `initiate.R`. It directly receives the original data from [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Adult) and creates six csv files. All of them are generated and used in different plots. Some of them are long data from `reshape2::melt`

As of data munging, I deleted rows that have NA's. In this case, the NA was coded as ' ?' which is different from '?'. It took a decent time for me to figure out the difference. The original dataset has 32561 rows and there are still 30162 rows left after this munging. Thus, this deletion technique is easier and much advisable than other techniques such as converting NA's into a categorical variable, as the data is preserved by 92%.

I deleted a column called `fnlwgt`, because it is not easy to interprete and explain to other people. I changed the nomenclature in `levels()` of factors in order to increase the readability. Specifically, I deleted unnecessary leading spaces and changed hyphens to spaces. From ` United-States` to `United States` is an example.


### Techniques ###

I have chosen the following visualization techniques for this project:

- Bubble Plot
- Heat Map
- Density Plot
- Bar Plot

#### Techniques 1: Bubble Plot ####
This plot uses `data2` from `initiate.R`. `data2` is generated from a `ddply()` function in a `plyr` package. `data2` shows the arithmetic mean of numerical data of each country: age, capital gain, capital loss, education years, and hours per week. It contains not only countries, but also the corresponding continents. I hard-coded those continents, because they are not many and there are only 4-continent representation. I deleted `Guam and USVI` for this dataset, because it belongs to more than one continent.

The lie factor is reasonable. I am aware that human beings are good at comparing two different lengths but not two different sizes. A bubble plot cannot avoid that fact, because a comparison between a bubble to a bubble is to do two different sizes not lengths.
The data density
The data to ink ratio


I sorted the dataset in order to have smaller colors displayed on top of the bigger colors as shown in the following line of code; `df <- df[order(df[,sizeIndex], decreasing = TRUE),]`.

![IMAGE](1bubble.jpg) 


#### Techniques 2: Heat Map  ####
This

The lie factor
The data density
The data to ink ratio

![IMAGE](2heat.jpg) 


#### Techniques 3: Density Plot ####
This density plot shows the distinction in annual income: more than 50K USD versus less than or equal to 50K USD. In this specific screenshot, I ams shoing the income difference between ages. It is clear that the older the higher income. I am sure I can set up other numerical variables on the x-axis (instead of age) and make it interactive.

The lie factor
The data density
The data to ink ratio

![IMAGE](3density.jpg) 


#### Techniques 4: Bar Plot ####
This

The lie factor
The data density
The data to ink ratio

![IMAGE](4bar.jpg) 



### Interactivity ###

#### Interactivity 1: Bubble Plot ####
Users can filter bubbles by countries and continents. The default is all countries for all continents. This type of selection is enabled from a `multiple=TRUE` argument in a `selectInput()` function. 

The color is consistent. In other words, no matter what users select or not, the color scheme for continents are the same. The image below is a good example. Only South Korea and all countries in South America are chosen, and the color scheme is consistent with the legend: pink Asia, green Europe, blue North America, and purple South America. We only can see pink South Korea and purple South American countries.

![IMAGE](1consistency.jpg) 

#### Interactivity 2: Heat Map ####
This

![IMAGE](2brushing.jpg) 

#### Interactivity 3: Density Plot ####
This

![IMAGE](3density.jpg) 

#### Interactivity 4: Bar Plot ####
This

![IMAGE](4ratio.jpg) 





### Prototype Feedback ###
There were only two plots for my prototype: a bubble plot and a density plot. I got the following feedback from classmates.

Bubble Plot:  
1. That is good function to put the labels of countries.
2. Move the legend.

Density Plot:  
1. better names for selection options, use color brewer colors, add subset by column feature to density plots
2. I would look at more than just salary of each person. I would also look at gender, I think gender might have a small difference.
3. it might be good to facet_wrap function by avoiding overlapped distribution.
4. I like your dataset! Perhaps doing a small multiples plot for the densities would be useful.

Both:  
1. Change axis labels — be sure to make them look nice
2. Additionally, some user-help text about what the columns represent would be good.









### Challenge ###
As written at the get-go, it was not easy to treat NA's. In the original dataset, the NA was coded as ' ?' which is different from '?'. The leading space was not very obvious for me. Thus, it took a decent time for me to figure out the difference.

Brushing/Highlighting in a heat map is great idea. I was about to implment it, but it was not easy. All the tutorials I found from the Internet have brushing in terms of numerical ranges, but my heat map does not have numerical values on both x- and y-axis. I used all the combinations to brush/highlight a certain country such as (`ymin=Haiti` and `ymax=Haiti`), (`ymin="Haiti"` and `ymax="Haiti"`), and even included a countries before and after Haiti in order to have Haiti per se. Then I talked to Sophie, and thanks to her, I could realize that those factors still have numerical values. So I found the corresponding numerical values by trial and error. So I could brush/highlight outstanding countries in a heat map.
