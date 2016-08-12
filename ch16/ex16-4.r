## 16.4 성능에 대해 일반적으로 고려할 사항

## 16.4.1 과부하의 원인

## 16.4.1.1 컴퓨터 공유 메모리

## 16.4.1.2 네트워크 시스템

## 16.4.2 당황스러운 병렬 애플리케이션과 그렇지 않은 애플리케이션의 차이

## 16.4.3 정적 할당 대 동적 할당

for (i = me; i<nval; i += nth) {
    mysum += procpairs(i,m,nval);
}

int nexti = 0; // 광역변수
...
for ( ;myi < n; ) { // for 반복문 수정
    #pragma omp critical
    {
        nexti += 1;
        myi = nexti;
    }
    if (myi < n) {
        mysum += procpairs(myi,m,nval);
        ...
    }
}
...

sum = 0
for i = 0...n-1
  for j = i+1...n-1
    for k = 0..n-1 sum = sum + a[i][k]*a[j][k]
mean = sum / (n*(n-1)/2)


## 16.4.4 소프트웨어 연금술: 일반적인 문제를 당황스러운 병렬 문제로 바꾸기

## 16.5 병렬 R 코드 디버깅하기

