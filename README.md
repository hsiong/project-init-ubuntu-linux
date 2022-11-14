# project-init-ubuntu
轻量云主机如今日渐深入人心, 但是云主机的初始化和镜像迁移无疑是个非常痛苦的过程; 

本项目致力于快速配置基于Ubuntu 20的云主机初始化和镜像迁移; 

未来总结经验, 一键生成开发环境(可能会通过 docker-file 或 shell)的形式

# terminal -> zsh & OH-MY-ZSH
https://www.spacevast.com/archives/centos7-linux%E5%AE%89%E8%A3%85zsh%E5%92%8Coh-my-zsh%E5%86%85%E5%90%AB%E5%9B%BD%E5%86%85%E5%AE%89%E8%A3%85%E6%96%B9%E6%B3%95

# apt - vim
## show line number
http://c.biancheng.net/view/809.html#:~:text=%E5%9C%A8%E5%91%BD%E4%BB%A4%E6%A8%A1%E5%BC%8F%E4%B8%8B%E8%BE%93%E5%85%A5,%E5%A6%82%E5%9B%BE1%20%E6%89%80%E7%A4%BA%E3%80%82&text=%E5%A6%82%E6%9E%9C%E6%83%B3%E8%A6%81%E5%8F%96%E6%B6%88%E8%A1%8C,%E6%96%87%E4%BB%B6%E6%89%80%E5%9C%A8%E5%9C%B0%EF%BC%89%E4%B8%AD%E8%AF%BB%E5%8F%96.

# Linux config DNS
https://blog.csdn.net/u010416101/article/details/79719713

# ssh 
## ssh PasswordAuthentication no
https://www.jianshu.com/p/b294e9da09ad
## ssh ServerAliveInterval
https://blog.csdn.net/abld99/article/details/69388858

# docker 
## docker - redis
docker run -d --name myredis -p 6379:6379 redis --requirepass "mypassword"

## docker - postgresGis
docker run -d --name postgres -p 5432:5432 -e POSTGRES_USER=usr -e POSTGRES_PASSWORD=pwd kartoza/postgis

## docker - nginx
docker run --name nginx -p 80:80 \
-v /root/config/docker/:/etc/nginx/conf.d/ \
-v /root/download:/usr/share/nginx/download \
-d nginx
### nginx config

## docker - jekins
### jekins - maven - optimize
https://www.cnblogs.com/yatho/p/7233194.html
