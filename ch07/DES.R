## DES.R: 이산 사건 시뮬레이션(DES)을 위한 R코드

## 각 이벤트는 다음 구성 요소로 이뤄진 행들에 의해 데이터 프레임으로 나타난다.
## evnttime: 이벤트가 발생한 시간
## evnttype: 프로그래머가 정의한 이벤트 유형에 대한 문자열
## 애플리케이션 구성요소(선택적)
## 예: 큐 애플리케이션의 작업 종료 시간

## "sim"이라는 광역 리스트가 이벤트 데이터 프레임, 이벤트(evnt),
## 현재 시뮬레이션 시간(currtime)을 갖고 있으며,
## dbg라는 디버그 모드를 가리키는 구성요소도 포함하고 있다.

## 각 행에는 이벤트 유형(evntty)과 이에 따른 이벤트별 시간(evnttm)이 있다.
## appin에 대한 schedevnt()의 주석을 참고하라.
evntrow <- function(evnttm,evntty,appin=NULL) {
    rw <- c(list(evnttime=evnttm,evnttype=evntty),appin)
    return(as.data.frame(rw))
}

## evnttm 이벤트 시간과 evntty 유형의 이벤트를 이벤트 리스트에 넣는다.
## appin은 이 이벤트의 애플리케이션 단에서 사용되는 선택적인 특성이다.
## 명명된 구성요소의 리스트 형태로 나타나 있다
schedevnt <- function(evnttm,evntty,appin=NULL) {
    newevnt <- evntrow(evnttm,evntty,appin)
    ## 이벤트 리스트가 비어있다면 evnt를 채우고 결과를 반환한다.
    if (is.null(sim$evnts)) {
        sim$evnts <<- newevnt
        return()
    }
    ## 아니라면 이벤트를 넣을 곳을 찾는다.
    inspt <- binsearch((sim$evnts)$evnttime,evnttm)
    ## 이제 데이터 프레임을 다시 만들어서 "넣는다".
    ## 새 이벤트가 추가되면서 현재 행렬에서 어떤 부분이 앞으로 가야 하고 어떤 부분이
    ## 새 이벤트 뒤로 가야 하는지, 그리고 이를 어떻게 연결해야 하는지 판단한다.
    before <-
        if (inspt == 1) NULL else sim$evnts[1:(inspt-1),]
    nr <- nrow(sim$evnts)
    after <- if (inspt <- nr) sim$evnts[inspt:nr,] else NULL
    sim$evnts <<- rbind(before,newevnt,after)
}

## 정렬된 벡터 x에서 삽입 부분 y를 바이너리 서치를 통해 찾는다.
## y가 들어가기 전에 x의 위치를 찾아서 반환한다.
## 만약 y가 x[length(x)]보다 크다면 length(x)+1을 반환한다.
## 이 부분은 효율성을 위해 C로 변환해서 사용할 수 있다.
binsearch <- function(x,y) {
    n <- length(x)
    lo <- l
    hi <- n
    while(lo+1 < hi) {
        mid <- floor((lo+hi)/2)
        if (y == x[mid]) return(mid)
        if (y < x[mid]) hi <- mid else lo <- mid
    }
    if (y <= x[lo]) return(lo)
    if (y < x[hi]) return(hi)
    return(hi+1)
}

## 다음 이벤트 진행을 시작한다(reactevnt() 호출을 통해
## 애플리케이션 프로그래머가 일정 부분 진행한 상태이다).
getnextevnt <- function() {
    head <- sim$evnts[1,]
    ## head를 삭제한다.
    if (nrow(sim$evnts) == 1) {
        sim$evnts <<- NULL
    } else sim$evnts <<- sim$evnts[-1,]
    return(head)
}

## 시뮬레이션 부분
## 인수:
##    initglbls: 애플리케이션 단의 초기화 함수; inits
##       애플리케이션의 통계적 총합 등에 사용되는 광격변수,
##       광역적으로 쓰여야 하는 값들, 처음 이벤트의 스케쥴 등을 초기화한다.
##    reactevnt: 애플리케이션 단의 이벤트 처리 함수
##       각 이벤트 유형별로 적절한 동작을 취한다.
##    prntrslts: 큐의 평균 대기 시간 등의
##       애플리케이션 단 결과값을 출력한다.
##    apppars: 애플리케이션 단의 매개 변수 리스트
##       예) 큐 애플리케이션의 서버의 수
##    maxsimtime: 가능한 최대 시뮬레이션 시간
##    dbg: 디버그 상태; TRUE 상태라면 매 이벤트 후 sim을 출력한다
dosim <- function(initglbls,reactevnt,prntrslts,maxsimtime,
                  apppars=NULL, dbg=FALSE) {
    sim <<- list()
    sim$currtime <<- 0.0 # 현재 시뮬레이션 시간
    sim$evnts <<- NULL # 이벤트 데이터 프레임
    sim$dbg <<- dbg
    initglbls(apppars)
    while(sim$currtime < maxsimtime) {
        head <- getnextevnt()
        sim$currtime <<- head$evnttime # 현재 시뮬레이션 시간 갱신
        reactevnt(head) # 이 이벤트를 진행함
        if (dbg) print(sim)
    }
    prntrslts()
}
