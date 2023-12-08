# Install

## Before you start

+ rufus
+ ubuntu desktop LTS iso

## Enter Bios
usually F2/F12

## Install ubuntu
+ choose **Ubuntu(safe graphics)**, other choice would lead error
+ If the display appears correctly, proceed with the installation using the instructions at https://blog.csdn.net/Flag_ing/article/details/121908340. 
+ Otherwise, resolve the display error first.

> During installation, Ubuntu's resolution is fixed at 800x600 and cannot be changed
![image-20231204171220562](/Users/vjf/Library/Application Support/typora-user-images/image-20231204171220562.png)

## Graphic & Internet Drivers

在 Ubuntu 上自动安装 Nvidia 显卡驱动和网卡驱动，你可以按照以下步骤进行：

+ [**更新软件包列表**](https://blog.csdn.net/weixin_52490336/article/details/133139105)

```
sudo apt-get update
```

+ [**安装编译依赖**](https://blog.csdn.net/weixin_52490336/article/details/133139105)(https://blog.csdn.net/weixin_52490336/article/details/133139105)：

```
sudo apt-get install g++
sudo apt-get install gcc
sudo apt-get install make
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

### manager

1. [**Ubuntu软件中心**](https://www.cnblogs.com/citrus/p/13879838.html)[：这是Ubuntu自带的一个图形化软件管理工具，你可以通过它来安装、更新和卸载软件。要卸载一个软件，你可以点击左侧菜单栏上的“Ubuntu Software”，然后在软件中心界面，点击“Installed”，这样可以列出已经安装过的软件。找到你想要卸载的软件，点击它右侧的“Remove”按钮，即可卸载](https://www.cnblogs.com/citrus/p/13879838.html)。

2. [**Synaptic Package Manager**](https://www.cnblogs.com/citrus/p/13879838.html)：这是一个基于APT的图形化包管理工具，它可以列出Ubuntu系统中所有已经安装的程序，还可以用于安装、卸载、升级软件。首先，你需要通过命令行来安装它：

   ```
   sudo apt update
   sudo apt install synaptic
   ```

安装完成后，运行Synaptic  `sudo synaptic`，通过搜索，查找出需要删除的软件，选中它，右键选择“Mark for Complete Removal”，点击"Apply"，即可卸载

### install app from deb

```
sudo dpkg -i your-package.deb
```

### invalid permissions on Desktop file

```
sudo chown -R user:group xxx.desktop
```

### Untrusted application launcher

Right click , then `allow execute`

## VPN 

Refer: [Linux/ubuntu下实现科学上网使用 clash for windows 详细步骤|翻墙|vpn|v2ray (cfmem.com)](https://www.cfmem.com/2021/09/linux-clash-for-windows-vpnv2ray.html)

+ download clash_for_windows_pkg: https://github.com/Mejituu/clash_for_windows_pkg
+ Unzip the archive
+ run `cfw`
+ click `General` -> `Start with Linux`
+ import profiles: `Profiles` -> `Download from a URL`

### Proxy

+ System proxy: 127.0.0.1 7890
+ git

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

### Install oh-my-zsh

## Theme - Gnome

Refer: https://blog.csdn.net/ksws0292756/article/details/79953155

### 命名变化

+ sudo apt-get install gnome-tweak-tool -> `sudo apt-get install gnome-tweaks`
+ Gnome-tweaks-extension -> extension

### 更换主题

+ extension 启用 user-theme
+ 下载 theme, 解压缩到 ~/.theme 目录下
https://www.gnome-look.org/



## Chinese Font

## Soft

### Nautilus

https://cn.linux-console.net/?p=17881

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

 \#"Exec"是执行脚本的路径，就是idea的bin目录的路径

 然后，给给此文件添加执行权限：`chmod u+x idea.desktop`

+ main menu
  + Click `Show main menu in a separate toolbar`

### Sublime

### Git

### Anaconda

### Other

+ teminal: ctrl+alt+t
+ file manager: nautilus
+ text editor: gedit

## Start up

+ clash
+ guake
+ Dingding

+ 

