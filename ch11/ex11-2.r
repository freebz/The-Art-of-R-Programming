## 11.2 정규 표현식

grep("[au]",c("Equator","North Pole","South Pole"))

grep("o.e",c("Equator","North Pole","South Pole"))

grep("N..t",c("Equator","North Pole","South Pole"))

grep(".",c("abc","de","f.g"))

grep("\\.",c("abc","de","f.g"))


## 11.2.1 확장 예제: 주어진 확장자의 파일명 테스트

testsuffix <- function(fn,suff) {
    parts <- strsplit(fn,".",fixed=TRUE)
    nparts <- length(parts[[1]])
    return(parts[[1]][nparts] == suff)
}

testsuffix("x.abc","abc")
testsuffix("x.abc","ac")
testsuffix("x.y.abc","ac")
testsuffix("x.y.abc","abc")

testsuffix <- function(fn,suff) {
    parts <- strsplit(fn,"\\.")
    nparts <- length(parts[[1]])
    return(parts[[1]][nparts] == suff)
}

testsuffix("x.y.abc","abc")

testsuffix <- function(fn,suff) {
    ncf <- nchar(fn) # nchar()는 문자열의 길이를 알려준다.
    ## suff가 fn의 확장자인 경우 확장자가 어디서 시작하는지 찾는다.
    dotpos <- ncf - nchar(suff) + 1
    ## suff가 맞는지 확인한다.
    return(substr(fn,dotpos,ncf)==suff)
}


## 11.2.2 확장 예제: 파일명 구성하기

for (i in 1:5) {
    fname <- paste("q",i,".pdf")
    pdf(fname)
    hist(rnorm(100,sd=i))
    dev.off()
}

for (i in 1:5) {
    fname <- paste("q",i,".pdf",sep="")
    pdf(fname)
    hist(rnorm(100,sd=i))
    dev.off()
}

for (i in 1:5) {
    fname <- sprintf("q%d.pdf",i)
    pdf(fname)
    hist(rnorm(100,sd=i))
    dev.off()
}

sprintf("abc%fdef",1.5)
sprintf("abc%gdef",1.5)
