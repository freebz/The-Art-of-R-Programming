x <- c(88,NA,12,168,13)
x
mean(x)
mean(x,na.rm=T)

x <- c(88,NULL,12,168,13)
mean(x)


x <- c(5,NA,12)
mode(x[1])
mode(x[2])
y <- c("abc","def",NA)
mode(y[2])
mode(y[3])


# 1:10에서 짝수로 된 벡터를 생성함
z <- NULL
for (i in 1:10) if (i %% 2 == 0) z <- c(z,i)
z

seq(2,10,2)
2*1:5

z <- NA
for (i in 1:10) if (i %% 2 == 0) z <- c(z,i)
z

u <- NULL
length(u)
v <- NA
length(v)

