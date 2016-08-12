## 7장 R 프로그래밍 구조

## 7.1 조건문

## 7.1.1 반복문

x <- c(5,12,13)
for (n in x) print(n^2)

i <- 1
while (i <= 10) i <- i+4
i

i <- 1
repeat { # 위와 유사
    i <- i+4
    if (i > 10) break
}
i


sim <- function(nreps) {
    commdata <- list()
    commdata$countabsamecomm <- 0
    for (rep in 1:nreps) {
        commdata$whosleft <- 1:20
        commdata$numabchosen <- 0
        commdata <- choosecomm(commdata,5)
        if (commdata$numabchosen > 0) next
        commdata <- choosecomm(commdata,4)
        if (commdata$numabchosen > 0) next
        commdata <- choosecomm(commdata,3)
    }
    print(commdata$countabsamecomm/nreps)
}

sim <- function(nreps) {
    commdata <- list()
    commdata$countabsamecomm <- 0
    for (rep in 1:nreps) {
        commdata$whosleft <- 1:20
        commdata$numabchosen <- 0
        commdata <- choosecomm(commdata,5)
        if (commdata$numabchosen == 0) {
            commdata <- choosecomm(commdata,4)
            if (commdata$numabchosen == 0) {
                commdata <- choosecomm(commdata,3)
            }
        }
    }
    print(commdata$countabsamecomm/nreps)
}


for (fn in c("file1","file2")) print(scan(fn))


## 7.1.2 벡터 이외의 유형을 사용하는 반복문

u <- matrix(c(1,2,3,1,2,4), 3)
v <- matrix(c(8,12,20,15,10,2), 3)
u
v
for (m in c("u","v")) {
    z <- get(m)
    print(lm(z[,2] ~ z[,1]))
}


## 7.1.3 if-else

if (r == 4) {
    x <- 1
} else {
    x <- 3
    y <- 4
}

x <- 2
y <- if(x == 2) x else x+1
y
x <- 3
y <- if(x == 2) x else x+1
y
