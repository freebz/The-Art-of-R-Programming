# 5.1 데이터 프레임 생성학

kids <- c("Jack","Jill")
ages <- c(12,10)
d <- data.frame(kids,ages,stringsAsFactors=FALSE)
d # matrix-like viewpoint


## 5.1.1 데이터 프레임에 접근하기
d[[1]]
d$kids
d[,1]

str(d)


## 5.1.2 확장 예제: 시험 성적을 회귀분석하기(2)
examsquiz <- read.table("exams",header=TRUE)
head(examsquiz)
