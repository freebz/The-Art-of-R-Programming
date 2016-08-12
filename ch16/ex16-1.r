## 16장 병렬R

## 16.1 상호 아웃링크 문제

sum = 0
for i = 0...n-1
  for j = i+1...n-1
    for k = 0...n-1 sum = sum + a[i][k]*a[j][k]
mean = sum / (n*(n-1)/2)
