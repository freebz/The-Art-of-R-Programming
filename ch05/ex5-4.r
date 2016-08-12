# 5.4 데이터 프레임에 함수 적용하기

## 5.4.1 데이터 프레임에 lapply()와 sapply() 사용하기

kids <- c("Jack","Jill")
ages <- c(12,10)
d <- data.frame(kids,ages,stringsAsFactors=FALSE)

d
dl <- lapply(d,sort)
dl

as.data.frame(dl)


## 5.4.2 확장 예제: 로지스틱 회귀 모델 적용하기
aba <- read.csv("abalone.data",header=T)
abamf <- aba[aba$Gender != "I",] # 새끼 전복은 분석에서 제외
lftn <- function(clmn) {
    glm(abamf$Gender ~ clmn, family=binomial)$coef
}
loall <- sapply(abamf[,-1],lftn)


## 5.4.3 확장 예제: 중국어 사투리 공부 도와주기

head(canman8)
m2cx <- mapsound(canman8,"Man cons","Can cons","x")
m2cx$counts
head(m2cx$images[["ch"]])
head(can8)
c2meung <- mapsound(canman8,c("Can cons","Man cons"), "eung")

## 두 지역어 데이터 프레임을 합침
merge2fy <- function(fy1,fy2) {
    outdf <- merge(fy1,fy2)
    ## 발음에서 성조를 분리해 새 열으로 만듦
    for (fy in list(fy1,fy2)) {
        ## saplout 은 초성 자음은 1열에,
        ## 나머지는 2열에, 성조는 3열에 넣은 행렬임
        saplout <- sapply((fy[[2]]),sepsoundtone)
        ## 데이터 프레임으로 변환
        tmpdf <- data.frame(fy[,1],t(saplout),row.names=NULL,
                            stringsAsFactors=F)
        ## 열에 이름 붙이기
        consname <- paste(names(fy)[[2]]," cons",sep="")
        restname <- paste(names(fy)[[2]]," sound",sep="")
        tonename <- paste(names(fy)[[2]]," tone",sep="")
        names(tmpdf) <- c("Ch char",consname,restname,tonename)
        ## outdf와 tmpdf의 배열 순서가 다를 수 있으므로
        ## cbind() 대신 merge() 사용
        outdf <- merge(outdf,tmpdf)
    }
    return(outdf)
}

## 로마자 발음에서 초성 자음과
## 나머지 발음 및 성조 분리
sepsoundtone <- function(pronun) {
    nchr <- nchar(pronun)
    vowels <- c("a","e","i","o","u")
    ## how many initial consonants?
    numcons <- 0
    for (i in 1:nchr) {
        ltr <- substr(pronun,i,i)
        if (!ltr %in% vowels) numcons <- numcons + 1 else break
    }
    cons <- if (numcons > 0) substr(pronun,1,numcons) else NA
    tone <- substr(pronun,nchr,nchr)
    numtones <- tone %in% letters # T이면 1, F이면 0
    if (numtones == 1) tone <- NA
    therest <- substr(pronun,numcons+1,nchr-numtones)
    return(c(cons,therest,tone))
}


mapsound <- function(df,fromcol,tocol,sourceval) {
    base <- which(df[[fromcol]] == sourceval)
    basedf <- df[base,]
    ## determine which rows of basedf correspond to the various mapped
    ## values
    sp <- split(basedf,basedf[[tocol]])
    retval <- list()
    retval$counts <- sapply(sp,nrow)
    retval$images <- sp
    return(retval)
}
