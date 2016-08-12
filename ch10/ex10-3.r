## 10.3 인터넷에 접근하기

## 10.3.1 TPC/IP 개요

## 10.3.2 R의 소켓

## 10.3.3 확장 예제: 병렬처리 R 구현하기

## 클라이언트와 소켓 커넥션을 설정함
##
cons <<- vector(mode="list",length=ncon) # 커넥션 리스트
## 디버그나 무리한 처리로 커넥션이 죽는 것을 방지함
options("timeout"=10000)
for (i in 1:ncon) {
    cons[[i]] <<-
        socketConnection(port=port,server=TRUE,blocking=TRUE,
                         open="a+b")
    ## 클라이언트 i로부터 응답을 기다림
    checkin <- unserialize(cons[[i]])
}
## ACK를 전송함
for (i in 1:ncon) {
    ## 클라이언트에게 ID 번호와 그룹의 크기를 전송함
    serialize(c(i,ncon),cons[[i]])
}

repeat {
    ## 아직 클래이언트가 있는가?
    if (remainingclients == 0) break
    ## 서비스 응답을 기다린 후 데이터를 읽어온다.
    ## 지연된 클라이언트 응답을 모두 찾는다.
    rdy <- which(socketSelect(cons))
    ## 하나를 고른다
    j <- sample(1:length(rdy),1)
    con <- cons[[rdy[j]]]
    ## 클라이언트의 응답을 읽는다.
    req <- unserialize(con)
}

## 실수형 중 정수형 형식의 md를 커넥션 cn을 사용해 데이터 dt에 기록한다.
binwrite <- function(dt,md,cn) {
    writeBin(dt,con=cn)
}

## 실수형 중 정수형 형식의 md의 원소 sz를 커넥션 cn을 통해 읽어온다.
binread <- function(cn,md,sz) {
    return(readBin(con=cn,what=md,n=sz))
}

options("timeout"=10000)
## 서버에 접속한다.
con <- socketConnection(host=host,port=port,blocking=TRUE,
                        open="a+b")
serialize(list(req="checking in"),con)
## 서버로부터 클라이언트의 ID와 전체 클라이언트의 수를 받아온다.
myidandnclnt <- unserialize(con)
myinfo <<-
    list(con=con,myid=myidandnclnt[1],nclnt=myidandclnt[2])
