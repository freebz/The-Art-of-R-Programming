## 14.4 코드에서 느린 부분을 찾을 때 사용하는 Rprof()

## 14.4.1 Rprof()를 사용한 모니터링

x <- runif(1000000)
Rprof()
invisible(powers1(x,8))
Rprof(NULL)
summaryRprof()

Rprof()
invisible(powers2(x,8))
Rprof(NULL)
summaryRprof()

Rprof()
invisible(powers3(x,8))
Rprof(NULL)
summaryRprof()


## 14.4.2 Pprof()의 작동 원리

