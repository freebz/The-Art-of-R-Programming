## 7.9 재귀

## 7.9.1 퀵소트 구현

qs <- function(x) {
    if (length(x) <= 1) return(x)
    pivot <- x[1]
    therest <- x[-1]
    sv1 <- therest[therest < pivot]
    sv2 <- therest[therest >= pivot]
    sv1 <- qs(sv1)
    sv2 <- qs(sv2)
    return(c(sv1,pivot,sv2))
}


## 7.9.2 확장 예제: 바이너리 서치 트리

## 트리를 만들고 아래에 아이템을 추가하는 내용
## 삭제하는 부분은 독자를 위해 연습용으로 남겨두겠다.

## 저장은 m이라는 행렬에 하고 한 줄에 트리의 노드 하나씩을 넣는다.
## 만약 i행에 (u,v,w)가 들어 있다면, i는 w를 저장하고 왼쪽과 오른쪽은 u와 v행에 연결된다.
## 빈 링크는 NA 값을 가진다.

## 트리는 리스트 (mat,nxt,inc)로 표현된다.
## mat는 행렬이고 nxt는 다음에 사용될 빈 행이고,
## inc는 행렬이 꽉 찼을 경우 추가 확장할 행의 수다.

## 트리를 순차적으로 따라가면서 출력한다.
printtree <- function(hdidx,tr) {
    left <- tr$mat[hdidx,1]
    if (!is.na(left)) printtree(left,tr)
    print(tr$mat[hdidx,3]) # print root
    right <- tr$mat[hdidx,2]
    if (!is.na(right)) printtree(right,tr)
}

## 저장할 행렬을 firstval 값을 넣어 초기화함
newtree <- function(firstval,inc) {
    m <- matrix(rep(NA,inc*3),nrow=inc,ncol=3)
    m[1,3] <- firstval
    return(list(mat=m,nxt=2,inc=inc))
}

## subtree의 루트는 인덱스 hdidx에 위치한다.
## 반환되는 값은 재귀 연산에 따라
## ins()가 포함된 호출자에 의해 tr에 재할당됨을 기억하자.
ins <- function(hdidx,tr,newval) {
    ## 왼쪽인지 오른쪽인지 노드가 가야 할 방향을 설정함
    dir <- if (newval <= tr$mat[hdidx,3]) 1 else 2
    ## 대신 빈 링크라면 새 노드를 생성한다.
    ## 재귀
    if (is.na(tr$mat[hdidx,dir])) {
        newidx <- tr$nxt # 새 노드가 위치할 곳
        ## 새 원소가 추가될 곳을 확인함
        if (tr$nxt == nrow(tr$mat) + 1) {
            tr$mat <-
                rbind(tr$mat, matrix(rep(NA,tr$inc*3),
                                     nrow=tr$inc,ncol=3))
        }
        ## 새 트리 노드 추가
        tr$mat[newidx,3] <- newval
        ## 새 노드 연결
        tr$mat[hdidx,dir] <- newidx
        tr$nxt <- tr$nxt + 1 # ready for next insert
        return(tr)
    } else tr <- ins(tr$mat[hdidx,dir],tr,newval)
}


x <- newtree(8,3)
x
x <- ins(1,x,5)
x
x <- ins(1,x,6)
x
x <- ins(1,x,2)
x
x <- ins(1,x,20)
x
