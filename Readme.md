# USTC-Software 2018 前端docker开发环境

## 简介
由于本次前端开发环境较为复杂，主要使用angular框架开发，另外需要使用多种插件加以辅助。在裸机上进行开发环境的配置需要花费相当长的时间，还有可能遇到版本冲突等各种情况。为了简化前端配置和防止版本冲突影响进度。本渣将我们的开发环境和常用框架打包成docker镜像。（注意：此举目前并未得到皓神和易同学的表态，后果自行承担）

## 关于docker

### 什么是 docker 
docker是一套非常轻量级的容器环境。可以很方便的部署各种环境，比如python、node之类的。由于类似的沙河机制，可以防止各种软件和编程环境互相冲突（典型例子php各个版本兼容）。


## 环境
下面列举docker镜像中的主要环境：

| Package | Version |
| :---: | :---:|
| node.js | 10.6.0 |
| npm | 6.1.0 |
| cnpm | 6.0.0 |
| typescript | 2.7.2 |
| angular | 6.1.1 |

另有angular-sortable.js、jquery、bootstrap、ng-zorro、sass等插件库。
由于已经安装了阿里爸爸的angularUI库 ng-zorro，所以angular和默认样式有所区别。

## 使用

#### 下载并安装docker
centos等：yum install docker
mac：去官网下载dmg包或者找本渣要
windows：自行解决

#### 获取镜像

##### 方法一：
```
docker pull ertuil/igem:v4
```
即可获得当前版本（v4）的镜像包

##### 方法二：使用github下载Dockfile自行创建镜像
github地址：
```
https://github.com/andytt/frontend
```
下载后运行
```
docker build -t igem .
```
即可在本地构建名为igem的镜像。

#### 运行镜像
同样是从上述github地址可以pull到本地的文件中有一个igem-run.sh，是本渣写的一个方便使用docker的脚本。

需要基于脚本权限：
```
chmod +x igem-run.sh
```

脚本中需要自己配置的是第二行的变量workdir指的是运行docker容器之后，angular项目代码所在位置，*一定要修改合适*，首次生成项目的话，应当使得文件夹为空。

#### 使用脚本

##### 创建新angular项目
创建一个新的angular项目的指令是
```
./igem-run.sh init
```

这个命令会使用之前下载的ertuil/igem:v4镜像创建一个新的容器，名字叫做igem-dev，并且会在docker容器之中的/usr/src/app位置创建一个名字叫做igem的新的项目，并把宿主机workdir所指定的文件夹和容器中项目文件夹绑定。最后运行angular服务器，由于对docker容器的4200端口映射到了宿主机器的4200端口。我们应当能从localhost:4200地址访问到angular生成的网站。

##### 启动、停止docker服务器运行

启动angular服务器有两种方式，一种是
```
./igem-run.sh
```
这时候会删除原先的igem-dev容器，并创建新的igem-dev容器。这样类似电脑的开机恢复，保证开发环境的纯净性。如果是第一次在某一个宿主机上运行docker镜像，请一定要使用上述命令，因为需要配置数据挂载、端口映射等等。

或者是
```
docker start igem-dev
```
此时不会删除旧有容器，而是直接启动已经存在的容器并且启动angular服务器，端口4200.

暂停的话使用一下命令即可
```
docker stop igem-dev
```

##### 关于执行命令

在docker容器中需要经常执行很多命令，比如：
```
ng g c xxx
```
这时候可以使用一下命令：
```
docker exec -it igem-dev ng g c xxx
``

为了简化命令，在igem-run.sh脚本中提供了对ng命令的支持，比如：
```
docker exec -it igem-dev ng g c xxx # docker命令方法
./igem-run.sh g c xxx # 不需要 ng，可以起到相同的效果。
```

## 注意

###  在美帝的同学
由于国内的种种限制，这个镜像配置的 npm 软件源修改成为淘宝的软件源镜像地址。同时cnpm（国内npm命令）也使用淘宝的镜像源。甚至 ng 也默认配置使用cpm 。所以国外访问速度有待考证。因此可以多执行一下两句指令恢复镜像为默认镜像

```
npm config delete registry
ng set --global packageManager=npm
```

### 关于安装软件包
如果真的需要扩展安装其他软件包的话可以有一下两种方式：
1. 最好联系本渣更新docker 的镜像
2. 使用npm install --save 局部安装，千万不要使用npm install -g 
