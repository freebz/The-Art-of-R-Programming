## 8.3 정렬

x <- c(13,5,12,5)
sort(x)
x

order(x)

y <- data.frame(V1=c("def","ab","zzzz"),V2=c(2,5,1))
y
r <- order(y$V2)
r
z <- y[r,]
z

d <- data.frame(kids=c("Jack","Jill","Billy"),ages=c(12,10,13))
d
d[order(d$kids),]
d[order(d$ages),]

x <- c(13,5,12,5)
rank(x)
