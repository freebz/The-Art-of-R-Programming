x <- c(88,5,12,13)
x <- c(x[1:3],168,x[4]) # 13 앞에 168을 넣음
x


x <- c(1,2,4)
length(x)


first1 <- function(x) {
    for (i in 1:length(x)) {
        if (x[i] == 1) break # 반복문 밖으로 빠져 나와서 return(i) 실행
    }
    return(i)
}


m
m + 10:13
