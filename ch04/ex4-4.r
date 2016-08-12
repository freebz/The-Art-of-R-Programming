# 4.4 리스트에 함수 적용하기

# 4.4.1 lapply()와 sapply() 함수 사용하기
lapply(list(1:3,25:29),median)
sapply(list(1:3,25:29),median)


# 4.4.2 확장 예제: 텍스트 일치 확인하기(2)
# wrdlst를 정렬해 findwords()의 결과값의 단어를 알파벳 순으로 보여준다.
alphawl <- function(wrdlst) {
    nms <- names(wrdlst) # 단어들
    sn <- sort(nms) # 해당 단어들을 알파벳 순서로 정렬
    return(wrdlst[sn]) # 정렬된 내용 반환
}

wl <- findwords("textconcorda.txt")
alphawl(wl)


# findwords()의 결과를 단어 빈도 순으로 정렬한다.
freqwl <- function(wrdlst) {
    freqs <- sapply(wrdlst,length) # get word frequencies
    return(wrdlst[order(freqs)])
}

x <- c(12,5,13,8)
sort(x)
order(x)

freqwl(wl)


nyt <- findwords("nyt.txt")
snyt <- freqwl(nyt)
ssnyt <- sapply(snyt,length)
nwords <- length(ssnyt)
barplot(ssnyt[round(0.9*nwords):nwords])


# 4.4.3 확장 예제: Abalone 데이터 사용하기
g <- c("M","F","F","I","M","M","F")

lapply(c("M","F","I"),function(gender) which(g==gender))
