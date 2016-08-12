# 4.2 일반 리스트 연산

j <- list(name="Joe", salary=55000, union=T)

# 4.2.1 리스트 인덱싱
j$salary
j[["salary"]]
j[[2]]


j[1:2]
j2 <- j[2]
j2
class(j2)
str(j2)

#j[[1:2]]  # Error in j[[1:2]] : subscript out of bounds
j2a <- j[[2]]
j2a
class(j2a)


# 4.2.2 리스트에 원소 추가/삭제하기
z <- list(a="abc",b=12)
z

z$c <- "sailing"  # c 구성 요소 추가
# c가 제대로 추가됐는가?
z

z[[4]] <- 28
z[5:7] <- c(FALSE,TRUE,TRUE)
z


c(list("Joe", 55000, T),list(5))


# 4.2.3 리스트의 크기 확인하기
length(j)


# 4.2.4 확장 예제: 텍스트 일치 확인하기(1)
findwords <- function(tf) {
    # 파일에서 단어를 읽어와 문자형 벡터로 변환한다.
    txt <- scan(tf,"")
    wl <- list()
    for (i in 1:length(txt)) {
        wrd <- txt[i] # 입력 파일의 i번째 단어
        wl[[wrd]] <- c(wl[[wrd]],i)
    }
    return(wl)
}   

findwords("textconcorda.txt")
