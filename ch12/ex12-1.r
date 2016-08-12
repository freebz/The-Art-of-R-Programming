## 12장 그래픽

## 12.1 그래프 만들기

## 12.1.1 R 기본 그래픽의 주요 담당자: plot() 함수

plot(c(1,2,3), c(1,2,4))

plot(c(-3,3), c(-1,5), type = "n", xlab="x", ylab="y")


## 12.1.2 선 추가하기: abline() 함수

x <- c(1,2,3)
y <- c(1,3,8)
plot(x,y)
lmout <- lm(y ~ x)
abline(lmout)

abline(c(2,1))

lines(c(1.5,2.5),c(3,3))

plot(x,y,type="l")


## 12.1.3 기존 것을 유지한 상태로 새 그래프 그리기

hist(x)
x11()    # x11(), macintosh(), windows()
hist(y)


## 12.1.4 확장 예제: 한 화면에 두 개의 밀도 추정 그래프 나타내기

testscores <- read.table('testscores.txt',header=T,sep=",")

d1 <- density(testscores$Exam1,from=0,to=100)
d2 <- density(testscores$Exam2,from=0,to=100)
plot(d1,main="",xlab="")
lines(d2)

plot(d2,main="",xlab="")
lines(d1)


## 12.1.5 확장 예제: 다항 회귀 예제

## polyfit(y,x,maxdeg)은 maxdeg 차의 모든 다항식을 사용해 모델을 만든다.
## y는 대응하는 변수 벡터, x는 예측 변수다.
## 여러 회귀 모델의 결과값과 원 데이터가 포함된
## "polyreg" 클래스 객체를 생성한다.
polyfit <- function(y,x,maxdeg) {
    pwrs <- powers(x,maxdeg) # 예측 변수의 멱함수
    lmout <- list() # 클래스 생성 시작
    class(lmout) <- "polyreg" # 새 클래스 생성
    for (i in 1:maxdeg) {
        lmo <- lm(y ~ pwrs[,1:i])
        ## lm 클래스에 교차 확인된 예측값을 추가해 확장한다.
        lmo$fitted.xvvalues <- lvoneout(y,pwrs[,1:i,drop=F])
        lmout[[i]] <- lmo
    }
    lmout$x <- x
    lmout$y <- y
    return(lmout)
}

## "polyreg" 클래스 객체에 대한 print()의 제네릭 함수
## 교차 확인된 평균 제곱 오류값을 같이 출력
print.polyreg <- function(fits) {
    maxdeg <- length(fits) - 2 # $x와 $y 뿐만이 아닌 lm의 다른 결과들도 센다.
    n <- length(fits$y)
    tbl <- matrix(nrow=maxdeg,ncol=1)
    cat("mean squared prediction errors, by degree\n")
    colnames(tbl) <- "MSPE"
    for (i in 1:maxdeg) {
        fi <- fits[[i]]
        errs <- fits$y - fi$fitted.xvvalues
        spe <- sum(errs^2)
        tbl[i,1] <- spe/n
    }
    print(tbl)
}

## 제네릭 함수 plot(); 실데이터에 대해 플로팅
plot.polyreg <- function(fits) {
    plot(fits$x,fits$y,xlab="X",ylab="Y") # 배경에 데이터를 점으로 플로팅
    maxdg <- length(fits) - 2
    cols <- c("red","green","blue")
    dg <- curvecount <- 1
    while (dg < maxdg) {
        prompt <- paste("RETURN for XV fit for degree",dg,
                        "or type degree", "or q for quit ")
        rl <- readline(prompt)
        dg <- if (rl == "") dg else if (rl != "q")
                                   as.integer(rl) else break
        lines(fits$x,fits[[dg]]$fitted.values,col=cols
              [curvecount%%3 + 1])
        dg <- dg + 1
        curvecount <- curvecount + 1
    }
}

## dg를 사용해 x의 멱행렬 생성
powers <- function(x,dg) {
    pw <- matrix(x,nrow=length(x))
    prod <- x
    for (i in 2:dg) {
        prod <- prod * x
        pw <- cbind(pw,prod)
    }
    return(pw)
}

## 교차 확인 예측값 찾기
## 행렬을 사용해 훨씬 빠르게 찾을 수 있다.
lvoneout <- function(y,xmat) {
    n <- length(y)
    predy <- vector(length=n)
    for (i in 1:n) {
        ## regress, leaving out ith observation
        lmo <- lm(y[-i] ~ xmat[-i,])
        betahat <- as.vector(lmo$coef)
        ## the 1 accommodates the constant term
        predy[i] <- betahat %*% c(1,xmat[i,])
    }
    return(predy)
}

## cfs를 계수로 한 x의 다항 함수
poly <- function(x,cfs) {
    val <- cfs[1]
    prod <- 1
    dg <- length(cfs) - 1
    for (i in 1:dg) {
        prod <- prod * x
        val <- val + cfs[i+1] * prod
    }
}


## 12.1.6 점 추가: points() 함수

points(testscores$Exam1,testscores$Exam3,pch="+")

par(bg="yellow")


## 12.1.7 범례 추가: legend() 함수

example(legend)


## 12.1.8 텍스트 추가: text() 함수

text(2.5,4,"abc")

text(46.7,0.02,"Exam 1")
text(12.3,0.008,"Exam 2")


## 12.1.9 위치 찾기: locator() 함수

locator(1)

hist(c(12,5,13,25,16))
locator(1)

text(locator(1),"nv=75")


## 12.1.10 그래프 복구

d1 = density(testscores$Exam1,from=0,to=100)
d2 = density(testscores$Exam2,from=0,to=100)
plot(d1,main="",xlab="")
lines(d2)
text(46.7,0.02,"Exam 1")
text(12.3,0.008,"Exam 2")

source("examplot.R")
