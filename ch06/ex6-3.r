# 6.3 테이블 사용하기

u <- c(22,8,33,6,8,29,-2)
fl <- list(c(5,12,13,12,13,5,13),c("a","bc","a","a","bc","a","a"))
tapply(u,fl,length)

table(fl)


ct <- read.table("ct.dat",header=T)
ct

cttab <- table(ct)
cttab

table(c(5,12,13,12,8,5))


v <- read.table("v.dat",header=T)
v # 데이터 프레임
vt <- table(v)
vt


## 6.3.1 테이블로 행렬.배열 연산하기

class(cttab)
cttab[1,1]
cttab[1,]

cttab/5

apply(cttab,1,sum)

addmargins(cttab)

dimnames(cttab)


## 6.3.2 확장 예제: 부분 테이블 추출하기

cttab

list(Vote.for.X=c("No","Yes"),Vote.for.X.Last.Time=c("No","Yes"))

subtable(cttab,list(Vote.for.X=c("No","Yes"),
                    Vote.for.X.Last.Time=c("No","Yes")))

subtable <- function(tbl,subnames) {
    ## tbl의 셀 수를 가진 배열을 만든다.
    tblarray <- unclass(tbl)
    ## do.call()을 사용해
    ## [ 안에 들어갈 인수 리스트를 먼저 만든다.
    ## 그 이후 각 이름에 따른 부분 배열을 만들 것이다.
    dcargs <- list(tblarray)
    ndims <- length(subnames)  # 차원 수
    for (i in 1:ndims) {
        dcargs[[i+1]] <- subnames[[i]]
    }
    subarray <- do.call("[",dcargs)
    ## 부분 배열로 이뤄진 새 테이블을 만든다.
    ## 각 차원은 레벨 수로 하고 dimnames() 값을 부여한 후
    ## "table" 클래스를 명시한다.
    dims <- lapply(subnames,length)
    subtbl <- array(subarray,dims,dimnames=subnames)
    class(subtbl) <- "table"
    return(subtbl)
}


## 6.3.3 확장 예제: 테이블에서 가장 큰 셀 찾기

tabdom(tbl,k)

d <- c(5,12,13,4,3,28,12,12,9,5,5,13,5,4,12)
dtab <- table(d)
tabdom(dtab,3)

tabdom(cttab,2)

as.data.frame(cttab)

## tbl 테이블에서 k개의 최고 빈도 셀을 찾는다.
## 수가 같은 경우는 따로 처리하지 않았다.
tabdom <- function(tbl,k) {
    ## Freq 열을 추가해 tbl을 나타내는 데이터 프레임을 생성한다.
    tbldf <- as.data.frame(tbl)
    ## 빈도 순으로 정렬해 보다 명확한 위치를 판단할 수 있게 한다.
    freqord <- order(tbldf$Freq,decreasing=TRUE)
    ## 이 순서대로 데이터 프레임을 재배열한 후 위의 k 행을 가져온다.
    dom <- tbldf[freqord,][1:k,]
    return(dom)
}
