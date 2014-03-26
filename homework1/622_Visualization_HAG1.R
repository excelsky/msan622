setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\1due0327j")

library(ggplot2)
library(plyr)
library(reshape2)
library(scales)
data(movies) 
data(EuStockMarkets)

movies <- subset(movies, budget > 0)

genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] <- "Mixed"
genre[which(count < 1)] <- "None"
genre[which(count == 1 & movies$Action == 1)] <- "Action"
genre[which(count == 1 & movies$Animation == 1)] <- "Animation"
genre[which(count == 1 & movies$Comedy == 1)] <- "Comedy"
genre[which(count == 1 & movies$Drama == 1)] <- "Drama"
genre[which(count == 1 & movies$Documentary == 1)] <- "Documentary"
genre[which(count == 1 & movies$Romance == 1)] <- "Romance"
genre[which(count == 1 & movies$Short == 1)] <- "Short"

movies$genre <- genre

eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))


#### Plot 1: Scatterplot ####
breakpoints <- seq(0, max(movies$budget), max(movies$budget)/4)
breakpoints[1] <- min(movies$budget)
breakpointslabels <- c("1000", "50M", "100M", "150M", "200M")
# http://www.cookbook-r.com/Graphs/Axes_(ggplot2)/
scatterplot <- ggplot(movies, aes(x=budget, y=rating, group=factor(genre), color=factor(genre))) +
  geom_point(alpha = 1) +
  ggtitle("Movies Budget and Rating") +
  xlab("Budget (US $)") + ylab("Rating (1 to 10)") +
  scale_x_continuous(breaks=breakpoints, labels=breakpointslabels) +
  labs(colour="Genre")
print(scatterplot)
ggsave("hw1-scatter.png", width = 9, height = 4.25, dpi = 300, units = "in")
dev.off()


#### Plot 2: Bar Chart ####
movies1 <- ddply(movies, "genre", summarise, count=length(genre))
# movies2 <- movies1[order(-movies1$count),]
# rm(movies1)
barchart <- ggplot(movies1, aes(x=genre, y=count)) +
  geom_bar(stat="identity", fill=I("tomato2")) +
  ggtitle("Movies Genre Version 1") +
  xlab("Genre") + ylab("Count")
print(barchart)
ggsave("hw1-bar-version1.png", width = 9, height = 4.25, dpi = 300, units = "in")
dev.off()


#### Plot 2. Version 2 ####
movies3 <- within(movies, genre <- factor(genre, levels=names(sort(table(genre), decreasing=TRUE))))
barchart <- ggplot(movies3, aes(x=genre, y=count)) +
  geom_bar(stat="identity", fill=I("tomato2")) +
  ggtitle("Movies Genre Version 2") +
  xlab("Genre") + ylab("Count")
print(barchart)
ggsave("hw1-bar-version2.png", width = 9, height = 4.25, dpi = 300, units = "in")
dev.off()


#### Plot 3: Small Multiples ####
# Re-use "breakpoints" from Plot 1
smallmultiples <- ggplot(movies, aes(x=budget, y=rating, group=factor(genre), colour=factor(genre))) +
  geom_point(alpha=1/2) +
  ggtitle("Movies Budget and Rating by Genre") +
  xlab("Budget (US $)") + ylab("Rating (1 to 10)") +
  scale_x_continuous(breaks=breakpoints, labels=breakpointslabels) +
  facet_wrap(~genre, ncol=3) +
  labs(colour="Genre")
print(smallmultiples)
ggsave("hw1-multiples.png", width = 9, height = 4.25, dpi = 300, units = "in", scale=2)
dev.off()


#### Plot 4: Multi-Line Chart ####
eu1 <- eu
eu1$time <- as.numeric(eu1$time)
eu_long <- reshape2::melt(eu1, id="time")
rm(eu1)
# eu_long$time <- ts(eu_long$time)
colnames(eu_long)[2] <- "index"
colnames(eu_long)[3] <- "price"

# eu_long$time <- as.character(eu_long$time)
# x <- scan(textConnection(eu_long$time))
# x.year <- floor(x) 
# x.frac <- x - x.year
# x.sec.yr <- unclass(ISOdate(x.year+1,1,1,0,0,0)) - unclass(ISOdate(x.year,1,1,0,0,0)) 
# x.actual <- ISOdate(x.year,1,1,0,0,0) + x.frac * x.sec.yr 
# min(x.actual)
# max(x.actual)
# x.actual.year <- 1900 + as.POSIXlt(x.actual)$year

min_year <- min(eu_long$time)
max_year <- max(eu_long$time)
# year <- as.Date(seq(floor(min_year), ceiling(max_year)), "%d%b%Y")
years <- seq(floor(min_year), ceiling(max_year))
years[1] <- min_year
years[length(years)] <- max_year
years_labels <- c("JUL1991", as.character(years[-c(1,length(years))]), "AUG1998")

multiline <- ggplot(eu_long, aes(x=time, y=price, group=factor(index), color=factor(index))) +
  geom_line(size=1) +
  ggtitle("European Stock Markets") +
  xlab("Time") + ylab("Price") +
  xlim(1991,1999) +
#   scale_x_date(labels=unique(x.actual.year)) +
#   scale_x_datetime(breaks=date_breaks("1 year")) +
  scale_x_continuous(breaks=years, labels=years_labels) +
  labs(color="Index") + 
  theme(legend.background = element_rect(fill="gray90", size=.5, linetype="dotted"))
print(multiline)
ggsave("hw1-multiline.png", width = 9, height = 4.25, dpi = 300, units = "in")
dev.off()