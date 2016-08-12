## 12.3 그래프를 파일에 저장하기

## 12.3.1 R 그래픽 장치

pdf("d12.pdf")

dev.list()

dev.cur()


## 12.3.2 출력된 그래프 저장하기

dev.set(2)
dev.copy(which=3)


## 12.3.3 R 그래픽 장치 닫기

dev.set(3)
dev.off()
