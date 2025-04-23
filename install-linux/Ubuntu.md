# Install

## Before you start

+ rufus(3.22)
+ ubuntu desktop LTS iso(22.04.4 LTS)
  + GPT ⭐️
  + UEFI ⭐️
  + FAT32
  + 8192 bit


## Enter Bios
usually F12, otherwise F2+Enter

## Install ubuntu
+ choose **Ubuntu(safe graphics)**, other choice would lead error

+ click top-right corner of the screen, then switch from Balance to Performance

+ If the display appears correctly, proceed with the installation using the instructions at https://blog.csdn.net/Flag_ing/article/details/121908340. 

+ Otherwise, resolve the display error first.

+ `Connect Network` & Keep waiting even if 'install ubuntu is not responding'

+ `Normal installation` & `Download Updates` &  unclick `install third-party for graphics`  ⭐️

+ `Install Ubuntu alongside Windows Boot`

+ Patition Table: `Warning: Be aware Device Loc`

  | 目录  | 建议大小     | 格式 | 描述                                                         |
  | :---- | :----------- | :--- | :----------------------------------------------------------- |
  | /     | 150G-200G    | ext4 | 根目录                                                       |
  | swap  | 物理内存两倍 | swap | 交换空间：交换分区相当于Windows中的“虚拟内存”，如果内存低的话（1-4G），物理内存的两倍，高点的话（8-16G）要么等于物理内存，要么物理内存+2g左右， |
  | /boot | 1G左右       | ext4 | **空间起始位置** 分区格式为ext4 **/boot** **建议：应该大于400MB或1GB** Linux的内核及引导系统程序所需要的文件，比如 vmlinuz initrd.img文件都位于这个目录中。在一般情况下，GRUB或LILO系统引导管理器也位于这个目录；启动撞在文件存放位置，如kernels，initrd，grub。 |
  | /tmp  | 5G左右       | ext4 | 系统的临时文件，一般系统重启不会被保存。（建立服务器需要？） |
  | /home | 尽量大些     | ext4 | 用户工作目录；个人配置文件，如个人环境变量等；所有账号分配一个工作目录。 |

> No such device Can not mount /dev/loop0
>
> flash driver version error, change another version

> error: ....
>
> just wait....

> During installation, Ubuntu's resolution is fixed at 800x600 and cannot be changed
![image-20231204171220562](../pic/image-20231204171220562.png)

> Black Screen

## Graphic & Internet Drivers

Ubuntu advanced -> recovery mode

在 Ubuntu 上自动安装 Nvidia 显卡驱动和网卡驱动，你可以按照以下步骤进行：

+ [**更新软件包列表**](https://blog.csdn.net/weixin_52490336/article/details/133139105)

```
sudo apt-get update
```

+ [**安装编译依赖**](https://blog.csdn.net/weixin_52490336/article/details/133139105)(https://blog.csdn.net/weixin_52490336/article/details/133139105)：

```
sudo apt-get install g++ gcc make
```

+ [**获取可用驱动信息**](https://blog.csdn.net/clancy_wu/article/details/119838008)：

```
ubuntu-drivers devices
```

[这将会输出一些信息，其中包含了系统推荐安装的驱动程序，比如 `nvidia-driver-440`](https://blog.csdn.net/clancy_wu/article/details/119838008)(https://blog.csdn.net/clancy_wu/article/details/119838008)。

+ [**自动安装驱动**](https://blog.csdn.net/clancy_wu/article/details/119838008)：

```
sudo ubuntu-drivers autoinstall
```

这里的 `nvidia-driver-440` 应该替换为你在上一步中找到的驱动程序。

+ [**重启系统**](https://blog.csdn.net/clancy_wu/article/details/119838008)：

```
sudo reboot
```

[安装完成后，需要重启系统以使新的驱动程序生效](https://blog.csdn.net/clancy_wu/article/details/119838008)。

+ [**检查驱动程序是否安装成功**](https://blog.csdn.net/clancy_wu/article/details/119838008)：

```
nvidia-smi
```

## software manager

1. [**Ubuntu软件中心**](https://www.cnblogs.com/citrus/p/13879838.html)[：这是Ubuntu自带的一个图形化软件管理工具，你可以通过它来安装、更新和卸载软件。要卸载一个软件，你可以点击左侧菜单栏上的“Ubuntu Software”，然后在软件中心界面，点击“Installed”，这样可以列出已经安装过的软件。找到你想要卸载的软件，点击它右侧的“Remove”按钮，即可卸载](https://www.cnblogs.com/citrus/p/13879838.html)。非常不好用! ⭐️

2. [**Synaptic Package Manager**](https://www.cnblogs.com/citrus/p/13879838.html)：这是一个基于APT的图形化包管理工具，它可以列出Ubuntu系统中所有已经安装的程序，还可以用于安装、卸载、升级软件。首先，你需要通过命令行来安装它：

   ```
   sudo apt update
   sudo apt install synaptic
   ```

安装完成后，运行Synaptic  `sudo synaptic`，通过搜索，查找出需要删除的软件，选中它，右键选择“Mark for Complete Removal”，点击"Apply"，即可卸载

### install app from deb

+ gdebi

  ```
  sudo apt-get install gdebi
  ```

  .deb -> open with -> GDebi Package Installer -> Set as default

+ dpkg shell

  ```
  sudo dpkg -i your-package.deb
  ```

### invalid permissions on Desktop file

+ see user group 

  ```
  ll
  ```

+ ```
  sudo chown -R user:group xxx.desktop
  ```

+ Other Access: Read-only
+ Enable "Allow Launching"

### Untrusted application launcher

Right click , then `allow execute`

## VPN 

Refer: [Linux/ubuntu下实现科学上网使用 clash for windows 详细步骤|翻墙|vpn|v2ray (cfmem.com)](https://www.cfmem.com/2021/09/linux-clash-for-windows-vpnv2ray.html)

+ download pkg: https://github.com/Mejituu/clash_for_windows_pkg
+ Unzip the archive
+ run `cfw`
+ click `General` -> `Start with Linux`
+ import profiles: `Profiles` -> `Download from a URL`
+ click `Allow LAN`

### Proxy

+ System proxy: 127.0.0.1 7890

  ```
  vim ~/.bashrc
  ```

  ```
  export http_proxy="http://127.0.0.1:7890"
  export https_proxy="http://127.0.0.1:7890"
  export ftp_proxy="http://127.0.0.1:7890"
  ```

  ```
  source ~/.bashrc
  ```
  
+ apt
  ```azure
    sudo gedit /etc/apt/apt.conf.d/proxy.conf
  
    Acquire {
    HTTP::proxy "http://127.0.0.1:7890";
    HTTPS::proxy "http://127.0.0.1:7890";
    FTP::proxy "http://127.0.0.1:7890";
    }
  ```

+ git
  
  ```
  git config --global http.proxy http://192.168.55.100:7890
  git config --global https.proxy http://192.168.55.100:7890
  ```
  
  

## Terminal

### 我想让 Guake 完全替代默认终端

To make Guake completely replace the default terminal in Ubuntu, follow these steps:

1. **Ensure Guake is Installed**: If Guake is not already installed, you can install it using the following command:

   ```
   bashCopy code
   sudo apt-get update
   sudo apt-get install guake
   ```

2. **Set Guake to Autostart**:

   - Open “Startup Applications”.
   - Click “Add” to create a new startup entry.
   - In the “Command” field, enter `guake` and give this entry a name, such as “Guake Terminal”.
   - Save and close.

3. **Change the Default Terminal Shortcut**:

   - Go to the “Keyboard” section in the system settings.
   - Find the shortcut setting for “Open Terminal,” usually Ctrl+Alt+T.
   - Change this shortcut to launch Guake. This might involve creating a custom shortcut with the command `guake -t`. This command toggles the Guake terminal’s visibility.

### Guake 优化

+ click `Stay on top`, otherwise would lead shortcut keys conflict
+ click `Refocus if open`
+ adjust `Geometry` : height, width...
+ Appearance -> Dock
+ shortcuts: cant use `ctrl + c` 

### Install oh-my-zsh

## Theme - Gnome

Refer: https://blog.csdn.net/ksws0292756/article/details/79953155

+ `sudo apt-get install gnome-tweaks gnome-shell-extensions ` 

### 更换主题

+ Gnome-tweaks-extension(Extensions) 启用 user-theme
+ https://www.gnome-look.org/
+ 下载 theme, 解压缩到 ~/.themes 目录下
+ icon -> /usr/share/icons
  + sudo mv icon /usr/share/icons
  + sudo chown -R root:root icon
  + sudo chmod 755 icon

+ (Tweaks) -> Appearance

## Chinese Font

## Soft

### Nautilus

https://cn.linux-console.net/?p=17881

右键单击左上角后退箭头, 即可获取以前访问的文件夹

### Pycharm

https://github.com/hsiong/learning-my-note/blob/main/tool/system/idea.md

[Linux（Ubuntu）安装idea-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/905483#:~:text=Linux)

**linux下安装idea创建桌面快捷方式**

```
touch idea.desktop　　　　#创建快捷方式
vi idea.desktop　　　　　　#编辑此文件
```

```
[Desktop Entry]     
Name=IntelliJ IDEA
Comment=IntelliJ IDEA
Exec=/opt/idea-IU-212.5284.40/bin/idea.sh          
Icon=/opt/idea-IU-212.5284.40/bin/idea.png
Terminal=false
Type=Application
Categories=Developer;
```

 \"Exec"是执行脚本的路径，就是idea的bin目录的路径 注意路径要正确! ⭐️

 然后，给给此文件添加执行权限：`chmod u+x idea.desktop`

+ main menu
  + Click `Show main menu in a separate toolbar`

### Sogou Input

https://shurufa.sogou.com/linux/guide

sudo /opt/sogoupinyin/files/bin/sogoupinyin-watchdog

Fcitx Config Tool:

+ add input method: unclick `Only show current Language` -> sogou pinyin

+ addon: unclick `Simplified Chinese To Traditional Chinese` & cancel shortcuts
+ cancel all shortcuts (esc)

```
sudo apt install \
    libqt5gui5 \
    libqt5core5a \
    libqt5widgets5 \
    qtwayland5 \
    libx11-xcb1 \
    libxcb-xinerama0 \
    libxcb1 \
    libxkbcommon-x11-0

3、通过命令行安装aptitude 
sudo apt-get install aptitude

4、通过命令行利用aptitude 安装fcitx、qt
sudo aptitude install fcitx-bin fcitx-table fcitx-config-gtk fcitx-config-gtk2 fcitx-frontend-all
sudo aptitude install qt5-default qtcreator qml-module-qtquick-controls2

5、如果右上角没有出现fcitx，在终端中输入im-config进行配置

6、通过命令行安装百度输入法
sudo dpkg –i fcitx-baidupinyin.deb

```

+ fcitx add input Chinese

+ final solution: use baidu input

### Docker

### Sublime

### Git

### Anaconda

### Other

+ teminal: ctrl+alt+t
+ file manager: nautilus
+ text editor: gedit 
+ markdown: typora(permanent use)

## Start up

+ clash
+ guake
+ Dingding
+ 

## sudo ubuntu-drivers autoinstall ;  mint no connection
https://blog.csdn.net/weixin_47869094/article/details/140512275

+ uname -a
+ dpkg --get-selections | grep linux
+ http://archive.ubuntu.com/ubuntu/pool/main/l/linux/
  + header
  + header-generic
  + extra
+ sudo dpkg -i *.deb
