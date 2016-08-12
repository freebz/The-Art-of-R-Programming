## 11장 문자열 처리

## 11.1 문자열 처리 함수 개요

## 11.1.1 grep()

grep("Pole",c("Equator","North Pole","South Pole"))
grep("pole",c("Equator","North Pole","South Pole"))


## 11.1.2 nchar()

nchar("South Pole")


## 11.1.3 paste()

paste("North","Pole")
paste("North","Pole",sep="")
paste("North","Pole",sep=".")
paste("North","and","South","Poles")


## 11.1.4 sprint()

i <- 8
s <- sprintf("the square of %d is %d",i,i^2)
s


## 11.1.5 substr()

substring("Equator",3,5)


## 11.1.6 strsplit()

strsplit("6-16-2011",split="-")


## 11.1.7 regexpr()

regexpr("uat","Equator")


## 11.1.8 gregexpr()
gregexpr("iss","Mississippi")
