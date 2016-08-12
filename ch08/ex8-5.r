## 8.5 집합 연산

x <- c(1,2,5)
y <- c(5,1,8,9)
union(x,y)
intersect(x,y)
setdiff(x,y)
setdiff(y,x)
setequal(x,y)
setequal(x,c(1,2,5))
2 %in% x
2 %in% y
choose(5,2)

symdiff <- function(a,b) {
    sdfxy <- setdiff(x,y)
    sdfyx <- setdiff(y,x)
    return(union(sdfxy,sdfyx))
}

x
y
symdiff(x,y)

"%subsetof%" <- function(u,v) {
    return(setequal(intersect(u,v),u))
}

c(3,8) %subsetof% 1:10
c(3,8) %subsetof% 5:10

c32 <- combn(1:3,2)
c32

combn(1:3,2,sum)
