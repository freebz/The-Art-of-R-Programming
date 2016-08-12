## 9.4 객체 관리하기

## 9.4.1 ls() 함수를 사용해 객체 나열하기

ls()
ls(pattern="ut")


## 9.4.2 rm() 함수를 사용해 특정 객체 제거하기

rm(a,b,x,y,z,uuu)

rm(list = ls())

ls()
ls(pattern="notebook")
rm(list=ls(pattern="notebook"))
ls()


## 9.4.3 save() 함수를 사용해 객체들을 저장하기

z <- rnorm(100000)
hz <- hist(z)
save(hz, file="hzfile")
ls()
rm(hz)
ls()
load("hzfile")
ls()
plot(hz) # 그래프 윈도우가 나타난다


## 9.4.4 '이건 뭐지?'

ct <- read.table("ct.dat",header=T)

cttab <- table(ct)
cttab

ctu <- unclass(cttab)
ctu
class(ctu)

edit(table)


## 9.4.5 exists() 함수

exists("acc")
