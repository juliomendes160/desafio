echo desafio .bash
bash="C:\Program Files\Git\bin"
cmd="C:\WINDOWS\system32"
powershell="C:\WINDOWS\System32\WindowsPowerShell\v1.0"
code="C:\Program Files\Microsoft VS Code\bin"
git="C:\Program Files\Git\mingw64\bin"
node="\\Program Files\node\16.16.0\app"
mysql="\\Program Files\mysql\8.0.42\app"
PATH=$(/bin/cygpath "$bash;$cmd;$powershell;$code;$git;$node;$mysql" -p)
