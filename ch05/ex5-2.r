# 5.2 기타 행렬 방식 연산

## 5.2.1 부분 데이터 프레임 추출하기
examsquiz[2:5,]
examsquiz[2:5,2]
class(examsquiz[2:5,2])
examsquiz[2:5,2,drop=FALSE]
class(examsquiz[2:5,2,drop=FALSE])

examsquiz[examsquiz$Exam.1 >= 3.8,]


## 5.2.2 NA 값을 다루는 추가적 방법들
x <- c(2,NA,4)
mean(x)
mean(x,na.rm=TRUE)

examsquiz[examsquiz$Exam.1 >= 3.8,]
subset(examsquiz,Exam.1 >= 3.8)
subset(examsquiz,examsquiz$Exam.1 >= 3.8)


kids <- c("Jack",NA,"Jillian","John")
states <- c("CA","MA","MA",NA)
d4 <- data.frame(kids,states,stringsAsFactors=FALSE)
d4
complete.cases(d4)

d5 <- d4[complete.cases(d4),]
d5


## 5.2.3 rbind()와 cbind() 및 관련 함수 사용하기
d
rbind(d,list("Laura",19))

eq <- cbind(examsquiz,examsquiz$Exam.2-examsquiz$Exam.1)
class(eq)
head(eq)

examsquiz$ExamDiff <- examsquiz$Exam.2 - examsquiz$Exam.1
head(examsquiz)

d
d$one <- 1
d


## 5.2.4 apply() 적용하기
apply(examsquiz,1,max)


## 5.2.5 확장 예제: 월급 연구
all2006 <- read.csv("2006.csv",header=TRUE,as.is=TRUE)

all2006 <- all2006[all2006$Wage_Per=="Year",] # 시간제 직원 제외
all2006 <- all2006[all2006$Wage_Offered_From > 20000,] # 특이한 경우 제외
all2006 <- all2006[all2006$Prevailing_Wage_Amount > 200,] # 시간제 임금 지불 제외

all2006$rat <- all2006$Wage_Offered_From / all2006$Prevailing_Wage_Amount

medrat <- function(dataframe) {
    return(median(dataframe$rat,na.rm=TRUE))
}


se2006 <- all2006[grep("Software Engineer",all2006),]
prg2006 <- all2006[grep("Programmer",all2006),]
ee2006 <- all2006[grep("Electronics Engineer",all2006),]

makecorp <- function(corpname) {
    t <- all2006[all2006$Employer_Name == corpname,]
    return(t)
}

corplist <- c("MICROSOFT CORPORATION","ms","INTEL CORPORATION","intel",
              "SUN MICROSYSTEMS, INC.","sun","GOOGLE INC.","google")
for (i in 1:(length(corplist)/2)) {
    corp <- corplist[2*i-1]
    newdtf <- paste(corplist[2*i],"2006",sep="")
    assign(newdtf,makecorp(corp),pos=.GlobalEnv)
}
