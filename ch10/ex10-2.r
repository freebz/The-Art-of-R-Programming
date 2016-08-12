## 10.2 파일 읽고 쓰기

## 10.2.1 파일에서 데이터 프레임이나 행렬 읽어오기

z <- read.table("z",header=TRUE)
z

x <- matrix(scan("x"),nrow=5,byrow=TRUE)

read.matrix <- function(filename) {
    as.matrix(read.table(filename))
}


## 10.2.2 텍스트 파일 읽기

z1 <- readLines("z1")
z1


## 10.2.3 커넥션 입문

c <- file("z1","r")
readLines(c,n=1)
readLines(c,n=1)
readLines(c,n=1)
readLines(c,n=1)

c <- file("z","r")
while(TRUE) {
    rl <- readLines(c,n=1)
    if (length(rl) == 0) {
        print("reached the end")
        break
    } else print(rl)
}

c <- file("z1","r")
readLines(c,n=2)
seek(con=c,where=0)
readLines(c,n=1)


## 10.2.4 확장 예제: PUMS 통계 파일

## PUMS 파일 pf를 읽어서 Person 레코드를 추출한 후 데이터 프레임으로 반한함
## 결과의 각 행은 Household 시리얼 번호와
## 리스트에 정의된 필드들로 구성된다.
## 데이터 프레임의 열은 필드별 인덱스명을 갖는다.

extractpums <- function(pf,flds) {
    dtf <- data.frame() # 데이터 프레임 생성
    con <- file(pf,"r") # 커넥션
    ## 입력 파일 처리
    repeat {
        hrec <- readLines(con,1) # Household 데이터를 읽음
        if (length(hrec) == 0) break # 파일의 끝인 경우 반복문에서 벗어남
        ## 가계 시리얼 번호를 가져옴
        serno <- intextract(hrec,c(2,8))
        ## 얼마나 많은 Person 데이터가 있는가?
        npr <- intextract(hrec,c(106,107))
        if (npr > 0)
            for (i in 1:npr) {
                prec <- readLines(con,1) # Person 데이터를 가져옴
                ## 데이터 프레임에 이 사람에 대한 데이터 행을 넣음
                person <- makerow(serno,prec,flds)
                ## 데이터 프레임에 추가
                dtf <- rbind(dtf,person)
            }
    }
    return(dtf)
}

## 데이터 프레임에 이 사람에 대한 데이터를 설정함
makerow <- function(srn,pr,fl) {
    l <- list()
    l[["serno"]] <- srn
    for (nm in names(fl)) {
        l[[nm]] <- intextract(pr,fl[[nm]])
    }
    return(l)
}

## 문자열 s에서 문자의 위치를 찾는 정수형 필드를 추출함
## rng[2]를 기준으로 rng[1]을 찾아냄
intextract <- function(s,rng) {
    fld <- substr(s,rng[1],rng[2])
    return(as.integer(fld))
}

pumsdf <- extractpums("pumsa",list(Gender=c(23,23),Age=c(25,26)))

head(pumsdf)


## 10.2.5 URL을 통해 원격으로 파일에 접속하기

uci <- "http://archive.ics.uci.edu/ml/machine-learning-databases/"
uci <- paste(uci,"echocardiogram/echocardiogram.data",sep="")
ecc <- read.csv(uci)

head(ecc)


## 10.2.6 파일에 쓰기

kids <- c("Jack","Jill")
ages <- c(12,10)
d <- data.frame(kids,ages,stringsAsFactors=FALSE)
d
write.table(d,"kds")

cat("abc\n",file="u")
cat("de\n",file="u",append=TRUE)

cat(file="v",1,2,"xyz\n")

c <- file("www","w")
writeLines(c("abc","de","f"),c)
close(c)


## 10.2.7 파일과 디렉터리 정보 얻기

file.info()
dir()
file.exists()
getwd(), setwd()


## 10.2.8 확장 예제: 많은 파일의 내용의 합

sumtree <- function(drtr) {
    tot <- 0
    ## 트리 내의 모든 파일의 이름을 가져온다
    fls <- dir(drtr,recursive=TRUE)
    for (f in fls) {
        ## is f a directory?
        f <- file.path(drtr,f)
        if (!file.info(f)$isdir) {
            tot <- tot + sum(scan(f,quiet=TRUE))
        }
    }
    return(tot)
}

sumtree("dir1")
