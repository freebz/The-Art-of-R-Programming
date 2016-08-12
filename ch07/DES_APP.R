## DES 애플리케이션: M/M/1 큐, 도착 비율: 0.5, 서비스 비용: 1.0

## 호출
## dosim(mm1initglbls,mm1reactevnt,mm1prntrslts,10000.0,
##    list(arrvrate=0.5,srvrate=1.0))
## 2 정도의 값을 반환함(시간이 약간 걸릴 수 있음)

## 이 애플리케이션에 한해 광역변수를 초기화함
mm1initglbls <- function(apppars) {
    mm1glbls <<- list()
    ## 시뮬레이션 매개 변수
    mm1glbls$arrvrate <<- apppare$arrvrate
    mm1glbls$srvrate <<- apppars$srvrate
    ## 큐 작업들의 도착 시간으로 구성된 서버 큐
    mm1glbls$srvq <<- vector(length=0)
    ## 통계
    mm1glbls$njobsdone <<- 0 # 실행된 작업
    mm1glbls$totwait <<- 0.0 # 총 대기 시간
    ## 첫 도착 이벤트를 설정하고 각 이벤트의 도착시간으로 구성된
    ## 데이터 세트를 만드는데 이는
    ## 시스템 내의 작업 상주 시간을
    ## 계산하기 위해 필요하다.
    arrvtime <- rexp(1,mm1glbls$arrvrate)
    schedevnt(arrvtime,"arrv",list(arrvtime=arrvtime))
}

## dosim()이 호출한 애플리케이션 단계의 이벤트 실행 함수
## 일반 DES 라이브러리에 포함돼 있다.
mm1reactevnt <- function(head) {
    if (head$evnttype == "arrv") { # 이벤트 도착
        ## 서버가 유휴 상태라면 서비스를 시작하고 아니라면 큐에 추가한다.
        ## (필요하담면 큐가 비어 있어도 그냥 추가한다).
        if (length(mm1glbls$srvq) == 0) {
            mm1glbls$srvq <<- head$arrvtime
            srvdonetime <- sim$currtime + rexp(1,mm1glbls$srvrate)
            schedevnt(srvdonetime,"srvdone",list(arrvtime=
                                                     head$arrvtime))
        } else mm1glbls$srvq <<- c(mm1glbls$srvq,head$arrvtime)
        ## 다음 도착 이벤트를 생성한다.
        arrvtime <- sim$currtime + rexp(1,mm1glbls$arrvrate)
        scheevnt(arrvtime,"arrv",list(arrvtime=arrvtime))
    } else { # 서비스가 실행됐다.
        ## 작업 진행이 끝났다.
        ## 내용 계산
        mm1glbls$njobsdone <<- mm1glbls$njobsdone + 1
        mm1glbls$totwait <<-
            mm1glbls$totwait + sim$currtime - head$arrvtime
        ## 큐에서 제거한다.
        mm1glbls$srvq <<- mm1glbls$srvq[-1]
        ## 큐에 남은 것이 있는지 확인한다.
        if (length(mm1glbls$srvq) > 0) {
            ## 새 서비스를 스케줄링한다.
            srvdonetime <- sim$currtime + rexp(1,mm1glbls$srvrate)
            schedevnt(srvdonetime,"srvdone",list
            (arrvtime=mm1glbls$srvq[1]))
        }
    }
}

mm1prntrslts <- function() {
    print("mean wait:")
    print(mm1glbls$totwait/mm1glbls$njobsdone)
}
