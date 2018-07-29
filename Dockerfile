FROM node:10.6-alpine

LABEL author='ertuil' email='936664530@qq.com'

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN npm config set registry https://registry.npm.taobao.org
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install -g @angular/cli \
    && cnpm install -g typescript \
    && cnpm install -g sass 

RUN cnpm install -g jquery \
    && cnpm install -g sortablejs && cnpm install -g angular-sortablejs \
    && cnpm install -g bootstrap

RUN ng set --global packageManager=cnpm
EXPOSE 4200

ADD ./install.sh /usr/src/app/install.sh
RUN chmod +x install.sh

CMD ng serve --open --host 0.0.0.0
