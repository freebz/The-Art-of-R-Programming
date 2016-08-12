#include <omp.h>
#include <R.h>

int tot;  // 모든 스레드에 대한 전체 쌍의 수

// 각 두 행의 쌍(i,i+1), (i,i+2), ... 에 대한 프로세스
int procpairs(int i, int *m, int n)
{
  int j, k, sum = 0;
  for (j = i+1; j < n; j++) {
    for (k = 0; k < n; k++)
      // m[i][k]*m[j][k]를 찾는다.
      // 이때 R은 열 우선 순서를 사용한다는 것을 기억하자.
      sum += m[n*k+i] * m[n*k+j];
  }
  return sum;
}

void mutlinks(int *m, int *n, double *mlmean)
{
  int nval = *n;
  tot = 0;
  // # omp를 병렬 처리
  #pragma omp parallel
  {
    int i, mysum = 0,
      me = omp_get_thread_num(),
      nth = omp_get_num_threads();
    // 모든 (i,j) 쌍을 확인하고 i에 따라 일을 분할함
    // 이 스레드는 모든 i가 me와 같을 때 nth 간격에 따라 처리함
    for (i = me; i<nval; i += nth) {
      mysum += procpairs(i,m,nval);
    }
    # pragma omp atomic
    tot += mysum;
  }
  int divisor = nval * (nval-1) / 2;
  *mlmean = ((float) tot)/divisor;
}
