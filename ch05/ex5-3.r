# 5.3 데이터 프레임 결합하기

kids <- c("Jack","Jill","Jillian","John")
states <- c("CA","MA","MA","HI")
d1 <- data.frame(kids,states,stringsAsFactors=FALSE)

ages <- c(10,7,12)
kids <- c("Jill","Lillian","Jack")
d2 <- data.frame(ages,kids,stringsAsFactors=FALSE)

d <- merge(d1,d2)
d

ages <- c(12,10,7)
pals <- c("Jack","Jill","Lillian")
d3 <- data.frame(ages,pals,stringsAsFactors=FALSE)
d3
merge(d1,d3,by.x="kids",by.y="pals")


d1
d2a <- rbind(d2,list(15,"Jill"))
d2a
merge(d1,d2a)


## 5.3.1 확장 예제: 직원 데이터베이스

count.fields("DA",sep=",")
all(count.fields("DA",sep",") >= 5)
table(count.fields("DA",sep=","))

da <- read.csv("DA",header=TRUE,stringsAsFactors=FALSE)
db <- read.csv("DB",header=FALSE,stringsAsFactors=FALSE)

for (col in 1:6)
    print(unique(sort(da[,col])))

mrg <- merge(da,db,by.x=1,by.y=1)
