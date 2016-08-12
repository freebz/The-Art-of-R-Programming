# 2.11 벡터 원소의 이름

x <- c(1,2,4)
names(x)
names(x) <- c("a","b","ab")
names(x)

names(x) <- NULL
x

x <- c(1,2,4)
names(x) <- c("a","b","ab")
x["b"]
