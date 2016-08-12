# 3.6 의도하지 않은 차원 축소 피하기

z <- matrix(1:8,nrow=4)
z

r <- z[2,]
r

attributes(z)
attributes(r)
str(z)
str(r)


r <- z[2,, drop=FALSE]
r
dim(r)

z[3,2]
"["(z,3,2)


u <- c(1,2,3)
v <- as.matrix(u)
attributes(u)
attributes(v)
