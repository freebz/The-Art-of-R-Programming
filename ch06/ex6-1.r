# 6.1 팩터와 레벨

x <- c(5,12,13,12)
xf <- factor(x)
xf

str(xf)
unclass(xf)

length(xf)

x <- c(5,12,13,12)
xff <- factor(x,levels=c(5,12,13,88))
xff
xff[2] <- 88
xff

xff[2] <- 28
