# 4.5 재귀 리스트

b <- list(u = 5, v = 12)
c <- list(w = 13)
a <- list(b,c)
a
length(a)

c(list(a=1,b=2,c=list(d=5,e=9)))
c(list(a=1,b=2,c=list(d=5,e=9)),recursive=T)
