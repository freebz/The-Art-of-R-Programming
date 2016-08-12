## 12.2 그래프 꾸미기

## 12.2.1 문자 크기 조절: cex 옵션

text(2.5,4,"abc",cex = 1.5)


## 12.2.2 축의 범위 바꾸기: xlim과 ylim 옵션

d1

plot(c(0, 100), c(0, 0.03), type = "n", xlab="score", ylab="density")
lines(d2)
lines(d1)


## 12.2.3 다각형 추가: polygon() 함수

f <- function(x) return(1-exp(-x))
curve(f,0,2)
polygon(c(1.2,1.4,1.4,1.2),c(0,0,f(1.3),f(1.3)),col="gray")

polygon(c(1.2,1.4,1.4,1.2),c(0,0,f(1.3),f(1.3)),density=10)


## 12.2.4 선의 곡선화: lowess()와 loess() 함수

plot(testscores)
lines(lowess(testscores))


## 12.2.5 명시적 함수 그래프화

g <- function(t) { return (t^2+1)^0.5 } # g() 정의하기
x <- seq(0,5,length=10000) # x = [0.0004, 0.0008, 0.0012,..., 5]
y <- g(x) # y = [g(0.0004), g(0.0008), g(0.0012), ..., g(5)]
plot(x,y,type="l")

curve((x^2+1)^0.5,0,5)

curve((x^2+1)^0.5,0,5,add=T)

f <- function(x) return((x^2+1)^0.5)
plot(f,0,5) # the argument must be a function name


## 12.2.6 확장 예제: 곡선의 일부 확대하기

