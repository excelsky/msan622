# setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\final")
library(plyr)
library(reshape2)

data1 <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", sep=",", header=F, na.strings=" ?")
# data1 <- read.table("adult.data", sep=",", header=F, na.strings=" ?")
data1 <- na.omit(data1)
# table(data1[,length(data1)])
colnames(data1) <- c("age", "workclass", "fnlwgt", "education", "education_num",
                     "marital_status", "occupation", "relationship", "race", "sex",
                     "capital_gain", "capital_loss", "hours_per_week", "native_country", "income")
data1 <- data1[,-3]
levels(data1$native_country) <- c("Cambodia", "Canada", "China", "Columbia",
                          "Cuba", "Dominican Republic", "Ecuador", "El Salvador",
                          "England", "France", "Germany", "Greece",
                          "Guatemala", "Haiti", "Netherlands", "Honduras",
                          "Hong Kong", "Hungary", "India", "Iran",
                          "Ireland", "Italy", "Jamaica", "Japan",            
                          "Laos", "Mexico", "Nicaragua", "Guam and USVI",
                          "Peru", "Philippines", "Poland", "Portugal",
                          "Puerto Rico", "Scotland", "South Korea", "Taiwan",
                          "Thailand", "Trinadad&Tobago", "United States", "Vietnam",
                          "Yugoslavia")
# levels(data1$native_country) <- sort(levels(data1$native_country), dec=T)
# data1$native_country <- factor(data1$native_country, levels=names(sort(table(data1$native_country), dec=T)))
levels(data1$race) <- c("Native American", "Asian", "Black", "Other", "White")
data1$race <- factor(data1$race, levels=levels(data1$race)[c(2,3,1,5,4)])
data1$education <- factor(data1$education, levels=levels(data1$education)[c(14,4,5,6,7,1,2,3,12,9,8,16,10,13,15,11)])
levels(data1$relationship) <- c("Husband", "Not in family", "Other", "Own child",
                              "Unmarried", "Wife")
data1$relationship <- factor(data1$relationship, levels=levels(data1$relationship)[c(1,2,4,6,5,3)])
levels(data1$workclass) <- c("Federal gov", "Local gov", "Never worked", "Private",
                             "Self emp inc", "Self emp not inc", "State gov", "Without pay")
levels(data1$marital_status) <- c("Divorced", "Married to Armed Forces", "Married to civilian",
                                  "Married spouse absent", "Never married", "Separated", "Widowed")
levels(data1$education) <- c("Preschool", "1st to 4th", "5th to 6th", "7th to 8th", "9th", "10th",
                             "11th", "12th", "HS grad", "Assoc voc", "Assoc acdm", "Some college",
                             "Bachelors", "Masters", "Prof school", "Doctorate")
levels(data1$occupation) <- c("Admin", "Armed Forces", "Craft and Repair",
                              "Executive", "Farming and fishing", "Handlers and cleaners",
                              "Mechanic", "Other service", "Private house service", "Prof specialty",
                              "Protective service", "Sales", "Tech support", "Transportation")
levels(data1$income) <- c("<= 50K USD", "> 50K USD")


#### data2 ####
data2 <- ddply(data1, .(native_country), summarize,
               mean_age = round(mean(age), 2),
               mean_education_num = round(mean(education_num), 2),
               mean_capital_gain = round(mean(capital_gain), 2),
               mean_capital_loss = round(mean(capital_loss), 2),
               mean_hours_per_week = round(mean(hours_per_week), 2))
data2 <- data2[-28,]
data2$continents <- c("Asia", "North America", "Asia", "South America",
                      "North America", "North America",
                      "South America", "North America", "Europe", "Europe",
                      "Europe", "Europe", "North America", "North America",
                      "Europe", "North America", "Asia", "Europe",
                      "Asia", "Asia", "Europe", "Europe",
                      "North America", "Asia", "Asia", "North America",
                      "North America", "South America", "Asia",
                      "Europe", "Europe", "North America", "Europe",
                      "Asia", "Asia", "Asia", "South America",
                      "North America", "Asia", "Europe")
data2$continents <- as.factor(data2$continents)
data2$native_country <- as.character(data2$native_country)
data2$native_country <- as.factor(data2$native_country)

#### data3 ####
data3 <- data1[c(2,3,5,6,7,8,9,14)]
# data3$workclass <- factor(data3$workclass, levels=names(sort(table(data3$workclass), dec=T)))
# data3$education <- factor(data3$education, levels=names(sort(table(data3$education), dec=T)))
# data3$marital_status <- factor(data3$marital_status, levels=names(sort(table(data3$marital_status), dec=T)))
# data3$occupation <- factor(data3$occupation, levels=names(sort(table(data3$occupation), dec=T)))
# data3$relationship <- factor(data3$relationship, levels=names(sort(table(data3$relationship), dec=T)))
# data3$race <- factor(data3$race, levels=names(sort(table(data3$race), dec=T)))
# data3$sex <- factor(data3$sex, levels=names(sort(table(data3$sex), dec=T)))

#### data4 ####
data4 <- data1[c("workclass", "education", "occupation", "native_country")]
data4w <- data.frame(matrix(ncol = length(levels(data4$workclass)), nrow = length(levels(data4$native_country))))
data4e <- data.frame(matrix(ncol = length(levels(data4$education)), nrow = length(levels(data4$native_country))))
data4o <- data.frame(matrix(ncol = length(levels(data4$occupation)), nrow = length(levels(data4$native_country))))
colnames(data4w) <- levels(data4$workclass)
colnames(data4e) <- levels(data4$education)
colnames(data4o) <- levels(data4$occupation)
rownames(data4w) <- levels(data4$native_country)
rownames(data4e) <- levels(data4$native_country)
rownames(data4o) <- levels(data4$native_country)
for (i in levels(data4$native_country)) {
  for (j in levels(data4$workclass)) {
    data4w[i,j] <- length(intersect(which(data4$native_country == i), which(data4$workclass == j)))
  }
}
for (i in levels(data4$native_country)) {
  for (j in levels(data4$education)) {
    data4e[i,j] <- length(intersect(which(data4$native_country == i), which(data4$education == j)))
  }
}
for (i in levels(data4$native_country)) {
  for (j in levels(data4$occupation)) {
    data4o[i,j] <- length(intersect(which(data4$native_country == i), which(data4$occupation == j)))
  }
}
data4w <- data4w[,-3]
data4w <- data4w/rowSums(data4w)
data4e <- data4e/rowSums(data4e)
data4o <- data4o/rowSums(data4o)
data4w$native_country <- rownames(data4w)
data4e$native_country <- rownames(data4e)
data4o$native_country <- rownames(data4o)
melt4w <- reshape2::melt(data4w, "native_country")
melt4e <- reshape2::melt(data4e, "native_country")
melt4o <- reshape2::melt(data4o, "native_country")




#### Save in csv files ####
write.csv(data1, file = "data1.csv", row.names = FALSE)
write.csv(data2, file = "data2.csv", row.names = FALSE)
write.csv(data3, file = "data3.csv", row.names = FALSE)
write.csv(melt4e, file = "melt4e.csv", row.names = FALSE)
write.csv(melt4o, file = "melt4o.csv", row.names = FALSE)
write.csv(melt4w, file = "melt4w.csv", row.names = FALSE)
