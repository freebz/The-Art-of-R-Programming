## 12.4 3차원 그래프 생성하기

library(lattice)
a <- 1:10
b <- 1:15
eg <- expand.grid(x=a,y=b)
eg$z <- eg$x^2 + eg$x * eg$y
wireframe(z ~ x+y, eg)
