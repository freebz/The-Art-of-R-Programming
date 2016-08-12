## 9장 객체지향 프로그래밍

## 9.1 S3 클래스

## 9.1.1 S3 제네릭 함수

## 9.1.2 예제: 선형 모델 함수 lm()에서 OOP

x <- c(1,2,3)
y <- c(1,3,8)
lmout <- lm(y ~ x)
class(lmout)
lmout

print
print.lm

unclass(lmout)


## 9.1.3 제네릭 메소드 실행 내역 찾기

methods(print)

aspell("wrds")

aspout <- aspell("wrds")
print.aspell(aspout)

getAnywhere(print.aspell)

utils:::print.aspell(aspout)

methods(class="default")


## 9.1.4 S3 클래스 작성하기

lm

j <- list(name="Joe", salary=55000, union=T)
class(j) <- "employee"
attributes(j) # 확인해 보자

j

print.employee <- function(wrkr) {
    cat(wrkr$name,"\n")
    cat("salary",wrkr$salary,"\n")
    cat("union member",wrkr$union,"\n")
}

methods(,"employee")

j


## 9.1.5 상속 사용하기

k <- list(name="Kate", salary= 68000, union=F, hrsthismonth= 2)
class(k) <- c("hrlyemployee","employee")

k


## 9.1.6 확장 예제: 위 삼각 행렬 저장 클래스

## 위 삼각 행렬을 효과적으로 저장하기 위한 클래스 "ut"

## 1+...+i를 반환하는 함수
sum1toi <- function(i) return(i*(i+1)/2)

## 0이 포함된 전체 행렬 inmat에서 클래스 "ut" 생성
ut <- function(inmat) {
    n <- nrow(inmat)
    rtrn <- list() # 객체 생성 시작
    class(rtrn) <- "ut"
    rtrn$mat <- vector(length=sum1toi(n))
    rtrn$ix <- sum1toi(0:(n-1)) + 1
    for (i in 1:n) {
        ## i열 저장
        ixi <- rtrn$ix[i]
        rtrn$mat[ixi:(ixi+i-1)] <- inmat[1:i,i]
    }
    return(rtrn)
}

## utmat의 압축된 내용을 풀어 전체 행렬로 변환
expandut <- function(utmat) {
    n <- length(utmat$ix) # 행렬과 열과 행의 수
    fullmat <- matrix(nrow=n,ncol=n)
    for (j in 1:n) {
        ## fill jth column
        start <- utmat$ix[j]
        fin <- start + j - 1
        abovediagj <- utmat$mat[start:fin] # j열의 대각선 위쪽
        fullmat[,j] <- c(abovediagj,rep(0,n-j))
    }
    return(fullmat)
}

## 행렬 출력
print.ut <- function(utmat)
    print(expandut(utmat))

## ut에 다른 ut를 곱할 경우, ut 객체를 반환한다.
## 바이너리 연산으로 구현
"%mut%" <- function(utmat1,utmat2) {
    n <- length(utmat1$ix) # 행렬의 열과 행의 수
    utprod <- ut(matrix(0,nrow=n,ncol=n))
    for (i in 1:n) { # i열의 곱 계산
        ## a[j]와 bj 은 utmat1과 utmat2의 j열을 가리킨다.
        ## 예를 들어, b2[1]은 utmat2은 2열의 첫 번째 원소다.
        ## 열 i의 곱은 다음과 같다.
        ## bi[1]*a[1] + ... + bi[i]*a[i]
        ## utmat2의 열 i의 인덱스를 찾는다.
        startbi <- utmat2$ix[i]
        ## bi[1]*a[1] + ... + bi[i]*a[i]가 될 벡터를 초기화한다.
        prodcoli <- rep(0,i)
        for (j in 1:i) { # bi[j]*a[j]를 계산해 prodcoli에 더한다.
            startaj <- utmat1$ix[j]
            bielement <- utmat2$mat[startbi+j-1]
            prodcoli[1:j] <- prodcoli[1:j] +
                bielement * utmat1$mat[startaj:(startaj+j-1)]
        }
        ## 아래에 0을 채워준다.
        startprodcoli <- sum1toi(i-1)+1
        utprod$mat[startbi:(startbi+i-1)] <- prodcoli
    }
    return(utprod)
}

test <- function() {
    utm1 <- ut(rbind(1:2,c(0,2)))
    utm2 <- ut(rbind(3:2,c(0,1)))
    utp <- utm1 %mut% utm2
    print(utm1)
    print(utm2)
    print(utp)
    utm1 <- ut(rbind(1:3,0:2,c(0,0,5)))
    utm2 <- ut(rbind(4:2,0:2,c(0,0,1)))
    utp <- utm1 %mut% utm2
    print(utm1)
    print(utm2)
    print(utp)
}

test()

m <- matrix(1:6,3)
m
row(m)
col(m)


## 9.1.7 확장 예제: 다항 회귀분석 과정

## "polyreg," 단일 예측 변수를 위한 다항 회귀분석 S3 클래스

## polyfit(y,x,maxdeg)은 maxdeg 차의 모든 다항식을 사용해 모델을 만든다.
## y는 사용 변수에 대응하는 벡터이고
## x는"polyreg"클래스 객체인 예측치다.
polyfit <- function(y,x,maxdeg) {
    ## i번째 열이 i번째 차수를 의미하는 예측 변수의 멱함수를 생성한다.
    pwrs <- powers(x,maxdeg)
    ## 직교(orthogonal) 벡터를 사용해 정확성을 높인다.
    lmout <- list() # 클래스를 생성한다.
    class(lmout) <- "polyreg" # 새 클래스를 생성한다.
    for (i in 1:maxdeg) {
        lmo <- lm(y ~ pwrs[,1:i])
        ## 교차 확인된 예측 기능을 추가해 lm 클래스를 확장한다.
        lmo$fitted.cvvalues <- lvoneout(y,pwrs[,1:i,drop=F])
        lmout[[i]] <- lmo
    }
    lmout$x <- x
    lmout$y <- y
    return(lmout)
}

## "polyreg"를 위한 print() 확장:
## 교차 확인된 평균 제곱 예측 오차(Mean-Square Prediction Errors)포함
print.polyreg <- function(fits) {
    maxdeg <- length(fits) - 2
    n <- length(fits$y)
    tbl <- matrix(nrow=maxdeg,ncol=1)
    colnames(tbl) <- "MSPE"
    for (i in 1:maxdeg) {
        fi <- fits[[i]]
        errs <- fits$y - fi$fitted.cvvalues
        spe <- crossprod(errs,errs) # 제곱 예측 오차의 합
        tbl[i,1] <- spe/n
    }
    cat("mean squared prediction errors, by degree\n")
    print(tbl)
}

## db차수일 때의 벡터 x의 멱행렬 생성
powers <- function(x,dg) {
    pw <- matrix(x,nrow=length(x))
    prod <- x
    for (i in 2:dg) {
        prod <- prod * x
        pw <- cbind(pw,prod)
    }
    return(pw)
}

## 행렬 갱신 방법을 통해 훨씬 빠르게
## 교차 확인된 예측 값을 찾는다.
lvoneout <- function(y,xmat) {
    n <- length(y)
    predy <- vector(length=n)
    for (i in 1:n) {
        ## i번째 관측치를 제외하고 회귀분석
        lmo <- lm(y[-i] ~ xmat[-i,])
        betahat <- as.vector(lmo$coef)
        ## 1은 상수로 사용
        predy[i] <- betahat %*% c(1,xmat[i,])
    }
    return(predy)
}

## polynomial function of x, coefficients cfs
poly <- function(x,cfs) {
    val <- cfs[1]
    prod <- 1
    dg <- length(cfs) - 1
    for (i in 1:dg) {
        prod <- prod * x
        val <- val + cfs[i+1] * prod
    }
}


n <- 60
x <- (1:n)/n
y <- vector(length=n)
for (i in 1:n) y[i] <- sin((3*pi/2)*x[i]) + x[i]^2 + rnorm(1,mean=0,sd=0.5)
dg <- 15
(lmo <- polyfit(y,x,dg))

lmo$fitted.cvvalues <- lvoneout(y,pwrs[,1:i,drop=F])
