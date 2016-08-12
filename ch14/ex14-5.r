## 14.5 바이트 코드 컴파일

z <- x + y

for (i in 1:length(x)) z[i] <- x[i] + y[i]

library(compiler)
f <- function() for (i in 1:length(x)) z[i] <<- x[i] + y[i]
cf <- cmpfun(f)
system.time(cf())
