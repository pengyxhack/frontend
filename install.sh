#!/bin/sh
echo "重新初始化，将会清空项目文件夹"
cd /usr/src/app
ng new igem
cd igem
ls
ng add ng-zorro-antd 
ng update @angular/cli
ng serve --open --host 0.0.0.0

