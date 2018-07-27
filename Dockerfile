FROM node:10.6-alpine

MAINTAINER ertuil 936664530@qq.com

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN npm config set registry https://registry.npm.taobao.org
RUN npm install -g @angular/cli \
    && npm install -g typescript \
    && npm install -g sass 

RUN apk add git
RUN ng new igem

WORKDIR igem
RUN npm install --save jquery \
    && npm install --save sortablejs && npm install --save angular-sortablejs \
    && npm install --save bootstrap
RUN ng add ng-zorro-antd

EXPOSE 4200

CMD ng serve --open 



