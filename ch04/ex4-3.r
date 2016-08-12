# 4.3 리스트 구성요소와 값에 접근하기

names(j)
ulj <- unlist(j)
ulj
class(ulj)

z <- list(a=5,b=12,c=13)
y <- unlist(z)
class(y)

w <- list(a=5,b="xyz")
wu <- unlist(w)
class(wu)

names(wu) <- NULL
wu

wun <- unname(wu)
wun
