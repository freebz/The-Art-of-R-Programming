## 11.3 디버깅 도구 edtdbg에서 문자열 관련 기능 사용하기

## 에디터에 명령어를 보냄
dbgsendeditcmd <- function(cmd) {
    syscmd <- paste("vim --remote-send ",cmd," --servername",vimserver,sep="")
    system(syscmd)
}

linenumstart <- regexpr("#",debugline) + 1
buffname <- substr(debugline,10,linenumstart-2)
colon <- regexpr(":",debugline)
linenum <- substr(debugline,linenumstart,colon-1)
