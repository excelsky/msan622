Homework 4: Text
==============================

| **Name**  | Kicho Yu  |
|----------:|:-------------|
| **Email** | kyu12@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `devtools`
- `ggplot2`
- `reshape2`
- `scales`
- `tm`
- `wordcloud`


To run this code, please enter the following commands in R:

```
library(devtools)
source_url("https://raw.githubusercontent.com/excelsky/msan622/master/homework4/622_Visualization_HAG4.R")
```

This will generate 4 images and some text outputs. See below for details.


## Discussion ##

I chose a dataset of **The Gettysburg Address** by Abraham Lincoln. By then, there was no method to record his speech. So there were five different copies of his speech. All of these copies named after the people who received them: Bliss, Nicolay, Hay, Everett, and Bancroft. Those copies are slightly different among one another. Bliss' copy is considered the most standard. I found that Nicolay's copy is the most different from others and I will explain further later.  

I chose both **Option 1: Using GGPlot2** and **Option 2: Using WordCloud** to generate **three text visualizations**. Actually, I generated more than three text visualizations. I have **four text visualizations**.

First, I imported *The Gettysburg Address* from a website called [The Gettysburg Address](http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm). I copied and pasted all the five versions and saved them into five *txt* files with *UTF-8* encoding.  

Then I used a `tm` package to munge data; to lower cases, remove punctuations, preserve intra word dashes, remove stop words, and strip white spaces. Then I created three versions based on stemming: no stemming, Porter stemming, and English stemming. I found that the latter two lead the same result and those results are more useful than the one from no stemming. For example, no stemming treats *dedicate* and *dedicated* differently, whereas those two stemming treat them the same. After reading all different versions of *The Gettysburg Address*, I found that it is better to treat those two words the same, because there is no significant different in their usages and I am more interested in a frequency of words. So I decided to use *Porter stemming* in my analysis and visualization.  
  
  
  
- **Plot 1: Word Cloud.**  

A word cloud shows an aggregate frequency among five different copies. In other words, it does not distinguish what copy a word is from.  

A size of a word implies its frequency. For example, *dedicate* is much bigger than *people*. It means that *dedicate* is used much more than *people* in **The Gettysburg Address**. Indeed, *dedicate* is the most frequent word in this speech. After stemming via *Porter*, I changed *dedic* into *dedicate* in order to increase the readability. My top five frequent words are indeed **dedicate, can, nation, live,** and **dead**.  

A word cloud has an interesting lie factor. Even though a size of a word implies its frequency, human beings are not good at comparing exactly among 2 or 3 dimensional objects. So we only know a certain word is used more often than another one, but not precisely how much it is used more often. So lie factor in a word cloud is reasonable, but we, human beings, cannot tell exactly.  I think my word cloud has a reasonable lie factor.  

A word cloud shows all unique words. No words show up more than once. Therefore, a data-ink ratio is high. I think that so is my word cloud.  

A data density shows amount of data entries versus graphic area. I intentionally tried to reduce a white space outside of a word cloud in order to increase a data density. I gave a small `width` value and a big `pointsize` value to make it happen. Therefore, I think the data density in my word cloud is high.  

![IMAGE](Wordcloud_with_Porter_stemming.jpg)  
  
  
  
- **Plot 2: Comparison Cloud.**  

I was wondering the difference among the five copies. Thanks to Sophie, I found that a comparison cloud is a great tool to compare a word frequency among different sources. I simply used a `comparison.cloud()` function by feeding my data matrix and color specification. For some reason, I only see words from three different copies: *Brancroft, Hay,* and *Nicolay*.  

Like a word cloud, a size of a word implies its frequency in a comparison cloud. Therefore, we can easily tell that *hallow* is used much more often than *rest* in the Nicolay's copy of *The Gettysburg Address*.  

Yet, [word size is mapped to the difference between the rates that it occurs in each document.](http://blog.fellstat.com/?cat=11).  As seen from the comparison cloud, *battlefield, battle-field,* or at least *battl* which is a result from Porter stemming are used universally often in all three copies. For example, *god* which is actually *God* is only seen from *Bancroft*'s copy, at least from this comparison cloud.  

Like a word cloud, a lie factor in a comparison cloud is reasonable, but we, human beings, cannot tell exactly.  I think my comparison cloud has a reasonable lie factor.  

A comparison cloud shows all unique words per document. No words show up more than once per document. Therefore, a data-ink ratio is high. I think that so is my comparison cloud.  

My comparison cloud has more (white spaced) background than other typical word cloud, because for some reasons, I do not see any words from two out of five copies. Therefore, I think the data density in my word cloud is not very high.  

![IMAGE](comparison_cloud_with_Porter_stemming.jpg)  
  
  
  
- **Plot 3: Small Multiples.**  

I looked at most frequent words among five copies. I found that **Nicolay**'s copy is perculiar. It has slightly lower frequency of using **dedicate** and **live**, even though they are two of the most frequently used words in a document. I thought a small multiples is a great plot to visually show this difference among five copies.  

In my small multiples, I highlighted the bars in **Nicolay**'s copy, because my goal was to distinguish it from others. I colored those bars in red, whereas did other bars in other copies grey. So I gave a color contrast. I increased the size of title, x-axis label, and y-axis label in order to increase a readability.  I highlighted the y-axis text in red for a higher readability.  

I think a lie factor in my small multiples is reasonable. Either the height or the area of bars represents a frequency of **dedicate** and **live**. Both the height and the area are proportional to the y-axis. Therefore, I think a lie factor in my small multiples is reasonable.  

A data-ink ratio in my small multiples may or may not high. I think there is a way to aggregately show all but **Nicolay**'s copy in one way, but I do not know. So if I could aggregately show all other copies, then data-ink ratio in my small multiples would be higher. Other than that, I think, so far, a data-ink ratio in my small multiples is fairly high.  

I do not think there is a big waste of space in my small multiples. If I could get rid of a space below a y=0 line, 
a data density would increase. Other than that, I think a data density in my plot is fairly high.  

![IMAGE](smallmult.jpg)  
  
  
  
- **Plot 4: Frequency Plot.**  

As I wrote at the introduction, **Bliss**' copy is considered the most standard, because [it is the last known copy written by Lincoln and the only one signed and dated by him](http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm). As I shown in the previous plot, **Nicolay**'s copy is the most different from others. Therefore, I concluded that it would be a good comparison between those two copies.  

I chose `textplot()` would be a good function to render my idea. Before plotting, I chose words with different frequencies only in those two copies. In other words, I deleted all other words which have the same frequencies in those two copies. I set the x-axis and the y-axis as *Bliss Copy* and *Nicolay Copy* respectively. I used `abline()` to draw a red `y=x` line. Therefore, the words below or on the right side of the red line show up more in *Bliss Copy* than *Nicolay Copy*. The words above or on the left side of the red line show up more in *Nicolay Copy* than *Bliss Copy*.  

Thanks to this frequency plot, it is easy to see that the following words appear more often in *Bliss Copy*:  
"advanc"       "altogeth"     "battle-field" "consecr"      "dedicate"    
"far"          "fit"          "fought"       "gave"         "god"         
"live"         "nobli"        "proper"       "rather"       "thu"         
"unfinish"     "work"  
Also it is easy to see that the following words appear more often in *Nicolay Copy*:  
"battl"     "hallow"    "mai"       "proprieti" "upon"  

It is not easy to say a lie factor in a frequency plot, because there is no geometric figure. I think it is only important to read points from both axes, but no comparison based on sizes. Therefore, I think it is not very meaningful to determine a lie factor in a frequency plot.  

All the words are unique in a frequency plot. So is mine. Therefore, I think a data-ink ratio in my frequency plot is high.  

Even though I have much white empty space inside of a plot, I would say a data density in my frequency plot is high. It is because that white space is not a waste of space.
![IMAGE](freqcomp.jpg)
