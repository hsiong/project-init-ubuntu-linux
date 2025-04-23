



# 其他问题

## 【ubuntu更新驱动后联不上网】

https://blog.csdn.net/weixin_47869094/article/details/140512275

常见: 使用 autoinstall 导致内核更新

+ 查看内核版本：uname -a

+ 查看缺少的包: 输入 dpkg --get-selections | grep linux

+ 在可以联网的电脑上

  ```
  sudo apt-get install linux-headers-xxx
  sudo apt-get install linux-headers-xxx-generic
  sudo apt-get install linux-modules-extra-xxx-generic
  ```



## Nemo 
+ sftp://user@host/dir

