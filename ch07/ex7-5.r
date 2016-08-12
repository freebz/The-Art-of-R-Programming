## 7.5 함수는 객체다

g <- function(x) {
    return(x+1)
}

?"{"

formals(g)
body(g)

g

abline

page(abline)

sum

f1 <- function(a,b) return(a+b)
f2 <- function(a,b) return(a-b)
f <- f1
f(3,2)
f <- f2
f(3,2)
g <- function(h,a,b) h(a,b)
g(f1,3,2)
g(f2,3,2)

g1 <- function(x) return(sin(x))
g2 <- function(x) return(sqrt(x^2+1))
g3 <- function(x) return(2*x-1)
plot(c(0,1),c(-1,1.5)) # 그래프를 그리기 위해 X와 Y의 범위를 잡아줌
for (f in c(g1,g2,g3)) plot(f,0,1,add=T) # 잡아놓은 그래프 위에 플로팅

## 대치함수
g <- function(h,a,b) h(a,b)
body(g) <- quote(2*x + 3)
g
