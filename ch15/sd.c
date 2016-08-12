#include <R.h> // 필요 헤더 파일
// 인수:
//    m: 정사각행렬
//    n: m의 열과 행 수
//    k: 부분 대각행렬 인덱스-전체 대각행렬일 경우 0,
//       첫 번째 대각행렬일 때는 1, 두 번째인 경우 2...
//    result: 반환될 대각행렬용 공간

void subdiag(double *m, int *n, int *k, double *result)
{
  int nval = *n, kval = *k;
  int stride = nval + 1;
  for (int i = 0, j = kval; i<nval-kval; ++i, j+=stride)
    result[i] = m[j];
}
