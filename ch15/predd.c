#include <R.h>

void predd(int *x, int *n, int *k, double *errrate)
{
  int nval =  *n, kval = *k, nk = nval - kval, i;
  int sm = 0;  // 이동 평균
  int errs = 0;  // 오류 수
  int pred;  // 예측값
  double k2 = kval/2.0;
  // 초기 윈도우를 계산함으로써 초기화함
  for (i = 0; i<kval; i++) sm += x[i];
  if (sm >= k2) pred = 1; else pred = 0;
  errs = abs(pred-x[kval]);
  for (i = 1; i<nk; i++) {
    sm = sm + x[i+kval-1] - x[i-1];
    if (sm >= k2) pred = 1; else pred = 0;
    errs += abs(pred-x[i+kval]);
  }
  *errrate = (double) errs / nk;
}
