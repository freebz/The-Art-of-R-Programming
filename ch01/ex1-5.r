examsquiz <- read.table("ExamsQuiz.txt",header=FALSE)
class(examsquiz)
head(examsquiz)

lma <- lm(examsquiz[,2] ~ examsquiz[,1])
lma <- lm(examsquiz$V2 ~ examsquiz$V1)

attributes(lma)
str(lma)
lma
summary(lma)

lmb <- lm(examsquiz[,2] ~ examsquiz[,1] + examsquiz[,3])
