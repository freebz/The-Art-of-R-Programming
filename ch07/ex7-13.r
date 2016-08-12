## 7.13 무기명 함수

inc <- function(x) return(x+1)

z <- matrix(1:6, 3)
z
f <- function(x) x/c(2,8)
y <- apply(z,1,f)
y

y <- apply(z,1,function(x) x/c(2,8))
y
