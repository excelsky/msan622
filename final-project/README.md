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

#### Technique 1: Bubble Plot ####
This plot uses `data2` from `initiate.R`. `data2` is generated from a `ddply()` function in a `plyr` package. `data2` shows the arithmetic mean of numerical data of each country: age, capital gain, capital loss, education years, and hours per week. It contains not only countries, but also the corresponding continents. I hard-coded those continents, because they are not many and there are only 4-continent representation. I deleted `Guam and USVI` for this dataset, because it belongs to more than one continent.

The lie factor is reasonable. I am aware that human beings are good at comparing two different lengths but not two different sizes. A bubble plot cannot avoid that fact, because a comparison between a bubble to a bubble is to do two different sizes not lengths. Other than that, I think the lie factor is reasonable, because the bubble size is not misleading and it can be controled by users.

The data density is farily high. I intentionally set the `sidebarPanel` `width = 3` and the `mainPanel` `width = 9`. In other words, I alloted three times more space for the main panel to the side panel.

The data to ink ratio is farily high. I intentionally got rid of the background of a plot. I made them white and added blue dotted tick marks. I incrased the font size of both the axis labels and tick marks in order to increase a readability.

This visualization excels at comparing demographic information among different countries and continents. A bubble plot is good at that, as Hans Rosling showed at TED with his tool 'Gapminder'. It is inevitable that some bubble overlap one another. I sorted the dataset in order to have smaller colors displayed on top of the bigger colors as shown in the following line of code; `df <- df[order(df[,sizeIndex], decreasing = TRUE),]`. For example, if users choose `Mean Capital Loss` and `Mean Hours per Week` as x- and y-axis respectively, they can see that the Netherlands is an outlier that has an extreme mean capital loss. Also, if users happen to opt out all the countries and the continents, then they are bounded to see a funny error message.

From this visualization, I learnd that filtering is important. Users want to filter certain countries and certain continents. I found that it was not very easy to implement this filtering. The original dataset has only countries. So I created a `continents` column. I did some extra lines of coding which will be further discussed in **interactivity**. In a nutshell, I learned the power of filtering from this visualization.

![IMAGE](1bubble.jpg) 


#### Technique 2: Heat Map  ####
This plot uses three long data from `initiate.R`: `melt4e`, `melt4o`, and `melt4w`. They all are generated from a `melt` function in a `reshape2` package. They are only different by the `variable` and the `value` columns: highest degree in education for `melt4e`, occupation for `melt4o`, and work class for `melt4w`.

Before I create these three long datasets, I created a `data4` dataset shown in `initiate.R`. It has only columns of work class, highest degree in education, occupation, and countries. Then I created three empty datasets -- `data4e`, `data4o`, and `data4w` -- whose column length is the length of first three columns respectively and row length is the length of the countries. Then I used double for-loops with `if` statements to fill in the empty elements in these three datasets. This step enabled me to have three datasets of 'counts' in all of the elements. For example, in `data4e`, the element with a column of `South Korea` and a row of `Doctorate` shows the number of doctorate people in South Korea. Then I converted these datasets to long datasets by using `melt`.


The lie factor is somewhat poor. A size of each block in a heat map does not mean its significance. It is treated all equal. Therefore, a heat map ignores a lie factor. My heat map is the same. I cannot avoid the distortion in the lie factor.

The data density is farily high. I intentionally set the `sidebarPanel` `width = 3` and the `mainPanel` `width = 9`. In other words, I alloted three times more space for the main panel to the side panel.

The data to ink ratio is reasonable. A heat map requires different color for its blocks, which reduce the data to ink ratio. I was aware of this fact. Thus, I created a `sliderInput` so that users can control the middle break points for the color gradient. The selected range will become white and thus this action will increase the data to ink ratio. Therefore, I think the data to ink ratio is reasonable here, since users can choose the span of the white space.

Addtionally, when it comes to brushing, the data to ink ratio drops. However, the goal of brushing is to highlight a certain element in a dataset. So I think it is reasonable to have a low data to ink ratio in brushing.

This visualization excels at comparing demographi

From this visualization, I learnd that different data type has its own purpose. I could 

![IMAGE](2heat.jpg) 


#### Technique 3: Density Plot ####
This density plot shows the distinction in annual income: more than 50K USD versus less than or equal to 50K USD. In this specific screenshot, I ams shoing the income difference between ages. It is clear that the older the higher income. I am sure I can set up other numerical variables on the x-axis (instead of age) and make it interactive.

The lie factor
The data density is farily high. I intentionally set the `sidebarPanel` `width = 3` and the `mainPanel` `width = 9`. In other words, I alloted three times more space for the main panel to the side panel.

The data to ink ratio is farily high. I intentionally got rid of the background of a plot. I made them white and added blue dotted tick marks. I incrased the font size of both the axis labels and tick marks in order to increase a readability.

![IMAGE](3density.jpg) 


#### Technique 4: Bar Plot ####
This

The lie factor
The data density is farily high. I intentionally set the `sidebarPanel` `width = 3` and the `mainPanel` `width = 9`. In other words, I alloted three times more space for the main panel to the side panel.

The data to ink ratio is farily high. I intentionally got rid of the background of a plot. I made them white and added blue dotted tick marks. I incrased the font size of both the axis labels and tick marks in order to increase a readability.

![IMAGE](4bar.jpg) 



### Interactivity ###

#### Interactivity 1: Bubble Plot ####
Users can filter bubbles by countries and continents. The default is all countries for all continents. This type of selection is enabled from a `multiple=TRUE` argument in a `selectInput()` function. I intentionall aligned all these `selectInput()` options on the same line below the main plot, so that users can easily compare and contrast. Inside of this `selectInput()` function, there are 4 `if` statements for 4 continents. Within the `if` statement, it interacts the users selection of a certain country.

The color is consistent. In other words, no matter what users select or not, the color scheme for continents are the same. The image below is a good example. Only South Korea and all countries in South America are chosen, and the color scheme is consistent with the legend: pink Asia, green Europe, blue North America, and purple South America. We only can see pink South Korea and purple South American countries. The color consistency enhances users eyes tracking, because they do not need to worry about alternation of color in terms of their interactivity.

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
1. better names for selection options, use color brewer colors, add subset by column feature to density plots.  
2. I would look at more than just salary of each person. I would also look at gender, I think gender might have a small difference.  
3. it might be good to facet_wrap function by avoiding overlapped distribution.  
4. I like your dataset! Perhaps doing a small multiples plot for the densities would be useful.  

Both:  
1. Change axis labels — be sure to make them look nice.  
2. Additionally, some user-help text about what the columns represent would be good.  









### Challenge ###
As written at the get-go, it was not easy to treat NA's. In the original dataset, the NA was coded as ' ?' which is different from '?'. The leading space was not very obvious for me. Thus, it took a decent time for me to figure out the difference.

Long datasets are a good company for a heat map. I was originally about to create a heat map with categorical variables on the x- and y-axis. Then I realized that I needed something to fill in the plot. I found that it would be good to have 'counts' for corresponding x- and y-axis. I created subsidiary datasets for a heat map, then I found that creating 'counts' are not that easy. I am sure there is a faster way to do that, but I used double for-loops with `if` statements as written above under **Technique 2**. Luckily, the subsidiary datasets are not big, so it did not take a long time. Plus, all of these steps are in `initiate.R`, so it does not affect `shiny` interactivity.

Brushing/Highlighting in a heat map is great idea. I was about to implment it, but it was not easy. All the tutorials I found from the Internet have brushing in terms of numerical ranges, but my heat map does not have numerical values on both x- and y-axis. I used all the combinations to brush/highlight a certain country such as `ymin=Haiti, ymax=Haiti`, `ymin="Haiti", ymax="Haiti"`, and even included a countries before and after Haiti in order to have Haiti per se. Then I talked to Sophie, and thanks to her, I could realize that those factors still have numerical values. So I found the corresponding numerical values by trial and error. For example, Haiti is 26, because it is the 26th country in the dataset. In order to brush/highlight Haiti, `ymin = 26.5, ymax = 27.5` should be inserted. So I could brush/highlight outstanding countries in a heat map.

If there were more time, I would investigate a sophisticated and smart way to select in a `selectInput()` function in my bubble plot. So far, for example, `All` in Asia is the same as `All` and `South Korea` in Asia. I wish I could opt out countries when `All` is selected. I talked to Sophie and she said that I should write this challenge in here. Thank you for the advice.
