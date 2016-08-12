## 7.7 R에는 포인터가 없다.

## Python
x = [13,5,12]
x.sort()
x
## >>> [5, 12, 13]

x <- c(13,5,12)
sort(x)
x

x <- sort(x)
x

oddsevens <- function(v) {
    odds <- which(v %% 2 == 1)
    evens <- which(v %% 2 == 1)
    list(o=odds,e=evens)
}
