#setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\4due0418v")
library(ggplot2)
library(reshape2)
library(scales)
library(tm)
library(wordcloud)

#### All five versions of The Gettysburg Address by Abraham Lincoln ####
# http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm
# bliss, nicolay, hay, everett, bancroft
working_directory <- getwd()
data_directory <- paste(working_directory,"\\Gettysburg", sep="")
dir.create(data_directory)
setwd(data_directory)

getty_source <- DirSource(
  directory = "Gettysburg",
  encoding = "UTF-8",
  pattern = "*.txt",
  recursive = F,  # No subdirectory
  ignore.case = F  # F: *.txt = *.TXT
)

getty_corpus <- Corpus(
  getty_source,
  readerControl = list(
    reader = readPlain,
    language = "en")
)

# summary(getty_corpus)
# inspect(getty_corpus)
# getty_corpus[[1]][3]
# getty_corpus[["Getty_Bliss.txt"]][3]


## To lower cases
getty_corpus <- tm_map(
  getty_corpus,
  tolower
)
# getty_corpus[["Getty_Bliss.txt"]][3]


## Remove punctuations and preserve intra word dashes
getty_corpus <- tm_map(
  getty_corpus,
  removePunctuation,
  preserve_intra_word_dashes = T
)
# getty_corpus[["Getty_Bliss.txt"]][3]


## Remove stopwords
getty_corpus <- tm_map(
  getty_corpus,
  removeWords,
  stopwords("english")
)
# getty_corpus[["Getty_Bliss.txt"]][3]


## Strip white space
getty_corpus <- tm_map(
  getty_corpus,
  stripWhitespace
)
# getty_corpus[["Getty_Bliss.txt"]][3]


## Stem document on "Porter"
getty_corpus_porter <- tm_map(
  getty_corpus,
  stemDocument,
  lang = "porter"
)
# getty_corpus_porter[["Getty_Bliss.txt"]][3]

## Stem document on "English"
getty_corpus_english <- tm_map(
  getty_corpus,
  stemDocument,
  lang = "english"
)
# getty_corpus_english[["Getty_Bliss.txt"]][3]

## No stemming
# Term Document Matrix
getty_tdm <- TermDocumentMatrix(getty_corpus)
# getty_tdm
# inspect(getty_tdm)
# inspect(getty_tdm[40:44,])
# findFreqTerms(getty_tdm, 10)

# inspect(getty_tdm[findFreqTerms(getty_tdm, 50),])
# inspect(getty_tdm[findFreqTerms(getty_tdm, 50),1])
getty_matrix <- as.matrix(getty_tdm)
getty_df <- data.frame(
  word = rownames(getty_matrix),
  freq = rowSums(getty_matrix),
  stringsAsFactors = F
)
getty_df <- getty_df[with(
  getty_df,
  order(freq, decreasing=T)
),]
rownames(getty_df) <- NULL
# head(getty_df)

getty_df$word[getty_df$word == "<U+FEFF>four"] <- "four"
# getty_df$word


## Porter
## Term Document Matrix
getty_tdm_porter <- TermDocumentMatrix(getty_corpus_porter)
# findFreqTerms(getty_tdm_porter, 10)

getty_matrix_porter <- as.matrix(getty_tdm_porter)
getty_df_porter <- data.frame(
  word = rownames(getty_matrix_porter),
  freq = rowSums(getty_matrix_porter),
  stringsAsFactors = F
)
getty_df_porter <- getty_df_porter[with(
  getty_df_porter,
  order(freq, decreasing=T)
),]
rownames(getty_df_porter) <- NULL
# head(getty_df_porter)

getty_df_porter$word[getty_df_porter$word == "<U+FEFF>four"] <- "four"
getty_df_porter$word[getty_df_porter$word == "dedic"] <- "dedicate"
getty_df_porter$word[getty_df_porter$word == "conceiv"] <- "conceive"
getty_df_porter$word[getty_df_porter$word == "peopl"] <- "people"
getty_df_porter$word[getty_df_porter$word == "devot"] <- "devote"
# getty_df_porter$word


## English
## Term Document Matrix
getty_tdm_english <- TermDocumentMatrix(getty_corpus_english)
# findFreqTerms(getty_tdm_english, 10)

getty_matrix_english <- as.matrix(getty_tdm_english)
getty_df_english <- data.frame(
  word = rownames(getty_matrix_english),
  freq = rowSums(getty_matrix_english),
  stringsAsFactors = F
)
getty_df_english <- getty_df_english[with(
  getty_df_english,
  order(freq, decreasing=T)
),]
rownames(getty_df_english) <- NULL
# head(getty_df_english)
getty_df_english$word[getty_df_english$word == "<U+FEFF>four"] <- "four"
getty_df_english$word[getty_df_english$word == "dedic"] <- "dedicate"
getty_df_english$word[getty_df_english$word == "conceiv"] <- "conceive"
getty_df_english$word[getty_df_english$word == "peopl"] <- "people"
getty_df_english$word[getty_df_english$word == "devot"] <- "devote"

# getty_df_english$word
# getty_df_english$word == getty_df_porter$word



#### Wordcloud ####
# jpeg("wordcloud_without_stemming.jpg")
# wordcloud(getty_df$word, getty_df$freq)
# text(x=0.5, y=1, "Wordcloud without stemming", col="red")
# dev.off()

jpeg("Wordcloud_with_Porter_stemming.jpg")
wordcloud(getty_df_porter$word, getty_df_porter$freq)
text(x=0.5, y=1, "Wordcloud with Porter stemming", col="red")
dev.off()

# jpeg("Wordcloud_with_English_stemming.jpg")
# wordcloud(getty_df_english$word, getty_df_english$freq)
# text(x=0.5, y=1, "Wordcloud with English stemming", col="red")
# dev.off()




#### Comparison Cloud ####
# http://blog.fellstat.com/?cat=11
# https://sites.google.com/site/miningtwitter/questions/talking-about/wordclouds/comparison-cloud

# rownames(getty_matrix)[rownames(getty_matrix) == "<U+FEFF>four"] <- "four"
# jpeg("comparison_cloud_without_stemming.jpg", width = 750)
# comparison.cloud(getty_matrix,
#                  colors = c("blue", "red", "yellow", "green", "magenta"),
#                  title.size=1.5, max.words=500)
# text(x=0.5, y=1, "Comparison cloud without stemming", col="red")
# dev.off()

rownames(getty_matrix_porter)[rownames(getty_matrix_porter) == "<U+FEFF>four"] <- "four"
jpeg("comparison_cloud_with_Porter_stemming.jpg", width = 750)
comparison.cloud(getty_matrix_porter,
                 colors = c("blue", "red", "yellow", "green", "magenta"),
                 title.size=1.5, max.words=500)
text(x=0.5, y=1, "Comparison cloud with Porter stemming", col="red")
dev.off()

# rownames(getty_matrix_english)[rownames(getty_matrix_english) == "<U+FEFF>four"] <- "four"
# jpeg("comparison_cloud_with_English_stemming.jpg", width = 750)
# comparison.cloud(getty_matrix_english,
#                  colors = c("blue", "red", "yellow", "green", "magenta"),
#                  title.size=1.5, max.words=500)
# text(x=0.5, y=1, "Comparison cloud with English stemming", col="red")
# dev.off()





#### Small multiples of 3 most frequent words among 5 docs ####
getty_df_porter1 <- data.frame(getty_matrix_porter)
rownames(getty_df_porter1)[rownames(getty_df_porter1) == "dedic"] <- "dedicate"
for (i in 1:5) {print(which(getty_df_porter1[,i] > 2))}
for (i in 1:5) {print(getty_df_porter1[which(getty_df_porter1[,i] > 2),i])}
for (i in 1:5) print(rownames(getty_df_porter1)[which(getty_df_porter1[,i] > 2)])
colnames(getty_df_porter1)

getty_df_porter2 <- rbind(getty_df_porter1["dedic",], getty_df_porter1["live",])
getty_df_porter3 <- reshape2::melt(t(getty_df_porter2), id="dedicate")
colnames(getty_df_porter3) <- c("doc", "word", "freq")
getty_df_porter3$word <- as.factor(getty_df_porter3$word)
getty_df_porter3$doc <- as.factor(getty_df_porter3$doc)
getty_df_porter3 <- getty_df_porter3[with(getty_df_porter3, order(doc, decreasing=T)),]
# levels(getty_df_porter3$doc) <- levels(getty_df_porter3$doc)[order(levels(getty_df_porter3$doc), decreasing=T)]
getty_df_porter3_sub <- subset(getty_df_porter3, doc=="Getty_Nicolay.txt")

p <- ggplot(getty_df_porter3, aes(x=word, y=freq)) +
  geom_bar(stat="identity", color="grey40", fill="grey40") +
  geom_bar(data=getty_df_porter3_sub, color="red", fill="red", stat="identity") +
  facet_wrap(~doc, ncol=5) +                    
  theme(title = element_text(face="bold", size=20),
        axis.title.x = element_text(face="bold", size=16),
        axis.text.x  = element_text(vjust=0.5, size=12),
        axis.title.y = element_text(face="bold", size=16),
        axis.text.y  = element_text(face="bold", vjust=0.5, size=12, color="red"),
        strip.text.x = element_text(size=16)) +
  scale_y_continuous(breaks=seq(3, 6)) +
  labs(title="Selective frequent words among different copies",
       x="Word", y="Frequency")
p
ggsave("smallmult.jpg", scale=1.5)
dev.off()





#### Frequency Plot ####
# http://blog.fellstat.com/?cat=11
textplot(getty_df_porter1[,1], getty_df_porter1[,5], rownames(getty_df_porter1))

more_bliss_index <- which(getty_df_porter1[,2] > getty_df_porter1[,5])
more_nicolay_index <- which(getty_df_porter1[,2] < getty_df_porter1[,5])
(more_bliss_text <- rownames(getty_df_porter1)[more_bliss_index])
(more_nicolay_text <- rownames(getty_df_porter1)[more_nicolay_index])

biss_nicolay_index <- which(getty_df_porter1[,2] != getty_df_porter1[,5])
biss_nicolay_text <- rownames(getty_df_porter1)[biss_nicolay_index]

jpeg("freqcomp.jpg", width=480/3*4*1.5, height=480*1.5, pointsize=17)
textplot(getty_df_porter1[biss_nicolay_index,2], getty_df_porter1[biss_nicolay_index,5], biss_nicolay_text,
         xlim=c(-1,7), ylim=c(-1,7),
         main="Word frequency comparison", xlab="Biss Copy", ylab="Nicolay Copy")
text(0.5, 6, "Words with different frequncies shown only.", col="red")
abline(a=0,b=1, col="red")
dev.off()
