# 6.2 팩터에 사용되는 일반적인 함수

## 6.2.1 tapply() 함수

ages <- c(25,26,55,37,21,42)
affils <- c("R","D","D","R","U","D")
tapply(ages,affils,mean)

d <- data.frame(list(gender=c("M","M","F","M","F","F"),
                     age=c(47,59,21,32,33,24),income
                     =c(55000,88000,32450,76500,123000,45650)))
d
d$over25 <- ifelse(d$age > 25,1,0)
d
tapply(d$income,list(d$gender,d$over25),mean)


## 6.2.2 split() 함수

d
split(d$income,list(d$gender,d$over25))

g <- c("M","F","F","I","M","M","F")
split(1:7,g)

findwords <- function(tf) {
    ## read in the words from the file, into a vector of mode character
    txt <- scan(tf,"")
    words <- split(1:length(txt),txt)
    return(words)
}


## 6.2.3 by() 함수

aba <- read.csv("abalone.data",header=TRUE)
by(aba,aba$Gender,function(m) lm(m[,2]~m[,3]))
