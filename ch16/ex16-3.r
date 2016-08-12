## 16.3 C 사용하기

## 16.3.1 멀티코어 사용하기

## 16.3.2 확장 예제: OpenMP에서의 상호 아웃링크 문제

dyn.load("romp.so")
Sys.setenv(OMP_NUM_THREADS=4)
n <- 1000
m <- matrix(sample(0:1,n^2,replace=T),nrow=n)
system.time(z <- .C("mutlinks",as.integer(m),as.integer(n),result=double(1)))
z$result


## 16.3.4 OpenMP 코드 분석

## 16.3.5 다른 OpenMP 프라그마

## 16.3.5.1 omp barrier 프라그마

#pragma omp barrier
#pragma omp single
#pragma omp parallel


## 16.3.5.2 omp ciritical 프라그마

#pragma omp critical
{
    // 한줄 또는 여러 줄의 코드를 넣음
}


## 16.3.5.3 omp single 프라그마

#pragma omp single
{
    // 한 줄 또는 여러 줄의 코드를 넣음
}


## 16.3.6 GPU 프로그래밍
