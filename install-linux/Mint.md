> 写到最前
>
> mint 22.04 基于 ubuntu 24.04, 千万不要搞错
>
> z790+4090 需要用 compatibility mode 启动

# 准备

## Refus 烧录

+ linux mint
+ GPT (mbr只支持老款windows)
+ Fat32 / exFat
+ DD Image mode
  + ISO 适用于 Windows
+ 提前分区 >200GB
+ 安全模式
  + msi: F11
+ Start  Cinnamon 64-bit

## Mint 磁盘分配

### ✅ 标准推荐方案

| 分区             | 挂载点      | 文件系统 | 大小     | 说明                       |
| ---------------- | ----------- | -------- | -------- | -------------------------- |
| EFI 分区         | `/boot/efi` | FAT32    | 512 MB   | 系统引导分区（UEFI 必需）  |
| 交换空间（Swap） | 无挂载点    | swap     | 4–8 GB   | 系统休眠/虚拟内存          |
| 家目录分区       | `/home`     | ext4     | 80 GB    | 存放用户文件               |
| 根分区           | `/`         | ext4     | 其余全部 | 系统文件及软件(apt, deb等) |

🧠 **Primary（主分区）**：MBR 结构中可以直接启动的分区（最多 4 个）
 💾 **Logical（逻辑分区）**：扩展分区中的“子分区”，数量不限但不能直接引导
 🚀 **GPT 结构中**：所有分区都是主分区，不再区分 primary/logical。

**最关键一步：引导加载器安装位置**

> bootloader可以装在efi分区中吗
>
> 非常棒的问题 💡！
>  答案是：**✅ 可以，而且在 UEFI 系统中，这就是正确、标准、推荐的做法。**

直接物理卸载硬盘

在安装界面底部有一行：

```
Device for boot loader installation:
```

一定要选择你的移动硬盘 efi 分区，比如：

```
/dev/sdb
```

> #### **安装错 boot 怎么办**
>
> lsblk -f
>
> sudo mkdir /mnt/win-efi
>
> sudo umount /mnt/win-efi
>
> sudo mount /dev/nvme0n1p1 /mnt/win-efi
>
> ls /mnt/win-efi/EFI
>
> sudo rm -rf /mnt/win-efi/EFI/ubuntu
>
> 
>
> sudo efibootmgr
>
> sudo efibootmgr -b 0005 -B

### 网卡

+ **如何确认是 8125 还是 8126（精确识别）**

在 Windows 的「设备管理器」里可以看到更详细的 **硬件 ID**：

1. 右键点「开始」→「设备管理器」
2. 展开「网络适配器」
3. 右键你的 “Realtek PCIe 5GbE Family Controller” → **属性**
4. 打开 **详细信息** 选项卡
5. 属性下拉选「硬件 ID（Hardware Ids）」

你会看到类似：

```
PCI\VEN_10EC&DEV_8126&SUBSYS_XXXX
```

+ MTK MT7927 无法识别

## Install

**`~/.zshrc`**：仅交互式 zsh 打开时执行。放别名/函数/轻量 PATH 追加。

**`~/.profile`**：登录会话（含 GUI）加载；**GUI 启动的应用能继承**。放 `PATH/JAVA_HOME/ANDROID_HOME/LANG/EDITOR` 等。

**`/etc/environment`**：系统级、键值对格式（不支持 shell 语法/变量引用），适合全局 `PATH`、`LANG` 等。

### VIM

```
sudo apt update
sudo apt install vim -y
```

### VPN

+ Clash Verge
  + subscript: Home -> Direct
+ sublime ~/.zshrc
+ startup - add application

```
export https_proxy="http://127.0.0.1:7897"
#export http_proxy="http://127.0.0.1:7897" 
export all_proxy=
```

#### APT

用代理, 国内源差的东西太多了

```
sudo vim /etc/apt/apt.conf.d/01proxy
```

写入：

```
Acquire::http::Proxy "http://127.0.0.1:7897/";
Acquire::https::Proxy "http://127.0.0.1:7897/";
```

不要用代理, 使用国内源

```
sudo xed /etc/apt/sources.list.d/official-package-repositories.list

deb http://mirrors.aliyun.com/linuxmint zara main upstream import backport #id:linuxmint_main
deb http://mirrors.aliyun.com/ubuntu/ noble main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ noble-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ noble-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ noble-security main restricted universe multiverse
sudo add-apt-repository universe -y & sudo apt update
```

### 显卡驱动

> 适用于 4090/5090 新显卡, 需要重新安装

1. **开机时，出现 GRUB 启动菜单：**
    一般会看到：

   ```
   Linux Mint 22.1 Cinnamon
   Advanced options for Linux Mint 22.1 Cinnamon
   ```

   如果没出现这个菜单，就在开机时 **反复按 `Shift`（BIOS 机）或 `Esc`（UEFI 机）**。

2. **选中要启动的那一行（通常是第一个）**，但不要按回车。
    然后按下键盘上的 **`e`**（编辑）键。
    → 你会看到一个黑底白字的文本编辑界面。

3. **找到这一行：**

   ```
   linux   /boot/vmlinuz-... root=UUID=xxxxxx ro quiet splash
   ```

   （重点在 `quiet splash`）

4. **在这行最后面加上：**

   ```
   nomodeset
   ```

   ⚠️ 注意：与前面之间留一个空格，比如：

   ```
   ... ro quiet splash nomodeset
   ```

5. 按下 **F10** 或 **Ctrl + X** 启动。

   👉 这次系统会用“兼容模式”启动，不加载显卡驱动。
    进入桌面后你就可以安装官方 NVIDIA 驱动。

6. 安装驱动

   > 千万不要执行 `sudo ubuntu-drivers autoinstall `, 会导致各种驱动异常
   >
   > 万一执行了, 那么
   >
   > ```
   > uname-a
   > ```
   >
   > 下载对应的 extra xxx
   >
   >  https://packages.ubuntu.com/noble/linux-modules-extra-6.14.0-33-generic
   >
   > ```
   > cd ~/Downloads
   > sudo dpkg -i linux-modules-extra-6.14.0-33-generic_*.deb
   > sudo update-initramfs -u
   > sudo reboot
   > lspci -nnk | grep -A3 -i eth
   > ```

   ```
   sudo apt update
   # 不需要 graphics-drivers PPA，Ubuntu 官方仓库现在已经内置主流 NVIDIA 驱动（550/560）
   sudo apt install nvidia-driver-550 -y
   sudo reboot
   ```

### Mint Panel 调整

move; size

> reboot

### oh-my-zsh

**1. 安装 Zsh**

```
sudo apt update
sudo apt install zsh git -y
```

------

🔍 **2. 检查是否安装成功**

```
zsh --version
```

如果显示版本号（例如 `zsh 5.9`），说明安装成功。

------

💡 **3. 设置默认 Shell 为 Zsh**

```
chsh -s $(which zsh)
sudo chsh -s $(which zsh) $USER
echo $SHELL
```

> setttings -> Keyboard  -> shortcut -> bindings
>
> + ctrl + alt + t -> Lauch terminal -> unassigned
>
> + Add custom shortcut

然后退出重新登录（或重启终端），Zsh 就会成为默认的 Shell。

> ⚠️ 如果没有立即生效，可以重新登录账户，或者在终端手动输入：
>
> ```
> zsh
> ```

------

🎨 **4. （推荐）安装 Oh My Zsh**

Oh My Zsh 是一个让 Zsh 更漂亮、更强大的配置框架。 => 使用国内镜像

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

安装后你会看到一个新的、彩色的命令提示符。

------

🧠 **5. 可选：更换主题 / 插件**

- 修改配置文件：

  ```
  vim ~/.zshrc
  ```

- 修改主题：

  ```
  ZSH_THEME="philips"
  ```

- 常见插件（自动补全 / 高亮）：

  ```
  sudo apt install zsh-autosuggestions zsh-syntax-highlighting
  ```

  然后在 `~/.zshrc` 中添加：

  ```
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ```

> `plugins=(git) `改为 `plugins=()`
>
> 否则会因为 git 原因卡死

+ pokemonsay

```
sudo apt install fortune-mod -y
sudo apt install -y cowsay
cd ~
git clone https://github.com/possatti/pokemonsay.git
cd pokemonsay
./install.sh
# add to zshrc
fortune | pokemonsay
source ~/.zshrc
```

### Git

+ ~/.profile

```
git config --global http.proxy http://127.0.0.1:7897
git config --global https.proxy http://127.0.0.1:7897
```

### DeskFlow

+ 使用 flatpak 安装

```
sudo apt install flatpak

# https://github.com/deskflow/deskflow/releases/download/v1.20.1/deskflow-1.20.1-linux-x86_64.flatpak

http_proxy=http://127.0.0.1:10808 \
https_proxy=http://127.0.0.1:10808 \
flatpak install --user ./deskflow-1.20.1-linux-x86_64.flatpak
```

+ 启动

```
flatpak run org.deskflow.deskflow
```

可以`Coinfigure Server`来调整左右屏幕

+ 自启动   使用 Cinnamon 自启动（图形界面）【推荐】
  + 打开菜单 → **系统设置** → **启动应用程序 (Startup Applications)**
  + 点击 “添加” → “自定义命令”
  + 填写：

> 名称：Deskflow
>
> 命令：`flatpak run org.deskflow.deskflow`

+ mac 与 linux 共用快捷键

#### Tailscale

Google 账号统一登录

实现跨网端控制

+ Linux
  + `sudo tailscale up`  
  + 输入 Tailscale Machine Ip

+ Mac 
  	+ Configure Server 控制
  	+ 一段时间可能会掉线 ⭐️ 需优化

#### mint 如何通过 deskflow 把 ctrl 与  alt 颠倒

现在的情况

| mac键盘 | mint |
| ------- | ---- |
| cmd     | ctrl |
| opt     | alt  |
| ctrl    | win  |

希望
| mac键盘 | mint |
| ------- | ---- |
| cmd     | alt  |
| opt     | win  |
| ctrl    | ctrl |

> 未实现, 回家搞

### 输入法 - 百度

✅ 一、准备工作：安装 `aptitude`（可选）

```
sudo apt update
sudo apt install -y aptitude
```

`aptitude` 只是 `apt` 的增强界面，也可以直接用 `apt`。

------

✅ 二、安装 Fcitx 4 框架（百度输入法依赖的是 Fcitx 4，而不是 Fcitx 5）

Mint 22 默认没有 Fcitx 4，你需要手动安装：

```
sudo apt install -y fcitx fcitx-bin fcitx-table fcitx-ui-classic fcitx-config-common fcitx-frontend-gtk3 fcitx-frontend-qt5
```

> ⚠️ 不要安装 `fcitx5` 系列，会冲突。

------

✅ 三、安装 Qt 环境（旧版 fcitx-baidupinyin 依赖 Qt 5）

Ubuntu 24.04 已弃用 `qt5-default`，用以下包替代：

```
sudo apt install -y qtbase5-dev qtbase5-dev-tools qtchooser qttools5-dev-tools qml-module-qtquick-controls2
```

✅ 四、设置输入法框架

运行配置工具选择 Fcitx 为默认输入法系统：

```
im-config -n fcitx
```

注销或重启桌面一次，让 Fcitx 生效。
 如果右上角仍无小键盘图标，执行：

```
fcitx-autostart &
```

✅五、添加输入法

打开 Fcitx 配置工具：

```
fcitx-config-gtk3
```

点击 “+” 号 → 搜索 “Baidu Pinyin” → 添加为默认输入法。
 切换快捷键通常为 `Ctrl + Space`。

### Chrome

+ 注释掉 Google Chrome 源

```
sudo xed /etc/apt/sources.list.d/google-chrome.list
```

改成：

```
# deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main
```

### Typora

下载安装包, 安装即可

- https://lizhi.shop/products/typora?cid=jxlwguir
- 新用户免费加入会员，首单立减 5 元
- 结算页面输入“APPINN”优惠码，额外再享 95 折优惠；

### Java

```
sudo apt update
sudo apt install openjdk-17-jdk
vim ~/.profile
```

在末尾添加：

```
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
export PATH=$JAVA_HOME/bin:$PATH
```

然后让配置生效：

```
source ~/.profile
```

验证：

```
echo $JAVA_HOME
java -version
```

验证编译器

```
javac -version
```

输出示例：

```
javac 17.0.9
```

### Python

Mint 通常自带 Python 3：

```
python3 --version
```

输出类似：

```
Python 3.10.12
```

说明已经安装。如果没有，或者你想安装其他版本，继续看下去。

```
sudo apt update
sudo apt install -y python3 python3-pip python3-venv python3-dev
python3 --version
pip3 --version
```

`python3-venv`: 创建虚拟环境

`python3-dev`: 编译 C 扩展时所需

`build-essential`: gcc、make 等基础工具

### Pycharm & IDEA

+ pycharm - Linux Arm64
+ IDEA - Linux aarch64

#### 一、路径确认

你的软件路径是：

- IntelliJ IDEA:
   `/home/hsiong/code/Software/idea-IU-241.19416.15`
- PyCharm:
   `/home/hsiong/code/Software/pycharm-2024.1.7`

可执行文件一般在它们的 `bin/` 目录中：

- IDEA 启动器：`/home/hsiong/code/Software/idea-IU-241.19416.15/bin/idea.sh`
- PyCharm 启动器：`/home/hsiong/code/Software/pycharm-2024.1.7/bin/pycharm.sh`

------

#### 🧩 二、生成桌面图标（.desktop 文件）

运行以下命令来创建两个快捷方式 👇

1️⃣ IntelliJ IDEA

```
cat <<EOF > ~/.local/share/applications/idea.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA
Icon=/home/hsiong/code/Software/idea-IU-241.19416.15/bin/idea.png
Exec=/home/hsiong/code/Software/idea-IU-241.19416.15/bin/idea.sh
Comment=JetBrains IntelliJ IDEA
Categories=Development;IDE;
Terminal=false
StartupNotify=true
EOF
```

------

2️⃣ PyCharm

```
cat <<EOF > ~/.local/share/applications/pycharm.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=PyCharm
Icon=/home/hsiong/code/Software/pycharm-2024.1.7/bin/pycharm.png
Exec=/home/hsiong/code/Software/pycharm-2024.1.7/bin/pycharm.sh
Comment=JetBrains PyCharm
Categories=Development;IDE;
Terminal=false
StartupNotify=true
EOF
```

------

#### 🧰 三、赋予执行权限

```
chmod +x ~/.local/share/applications/idea.desktop
chmod +x ~/.local/share/applications/pycharm.desktop
```

------

#### 🖥️ 四、添加到桌面（可选）

Mint 允许从菜单拖动图标到桌面，
 但你也可以直接复制：

```
cp ~/.local/share/applications/idea.desktop ~/Desktop/
cp ~/.local/share/applications/pycharm.desktop ~/Desktop/
chmod +x ~/Desktop/idea.desktop ~/Desktop/pycharm.desktop
```

------

#### 🧼 五、刷新菜单

执行：

```
update-desktop-database ~/.local/share/applications/
```

然后你就可以在 Mint 菜单中搜索到 “IntelliJ IDEA” 和 “PyCharm”，
 或在桌面上双击运行 🎉

#### pycharm 导入 setting文件后导致了这个报错￼￼￼

可能是导入的 pycharm  key/vmoptions 导致的错误

```
rm -rf pycharm.key pycharm64.vmoptions
```

### Sublime



### 我想让 Guake 完全替代默认终端

因为原生 terminal 不支持撤销和重做

ctrl + c & ctrl + v 也不支持



### Wechat



### BaiduDisk

### Node(可选)



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

## 更换电脑后卡死在mint启动

常见原因是因为显卡驱动不兼容, 先进非图形化 boot

只能去之前那台电脑, 去更新最新的英伟达驱动, 比如4090要用550

grub 没用; 或者重装系统

## Nemo 
+ sftp://user@host/dir

## mint 怎么把文件夹放到 mycomputer 或 bookmarks 上

### 通过图形界面（最简单）

适用于 Mint 自带的文件管理器 **Nemo**。

✅ 把文件夹添加到“书签”（Bookmarks）

1. 打开文件管理器（Nemo）

2. 找到要添加的文件夹，比如：

   ```
   /home/hsiong/code/Software
   ```

3. 右键该文件夹 → 选择 **“添加到书签”**（Add to Bookmarks）

4. 现在它会出现在左侧侧边栏的 “书签” 区域中

📍 你也可以拖动文件夹直接到左侧书签区域来添加。

#### 命令行快速恢复

执行下面这条命令即可恢复 **下载（Downloads）** 到侧边栏：

```
echo "file:///home/$USER/Downloads Downloads" >> ~/.config/gtk-3.0/bookmarks
```

然后重新打开文件管理器（或按 `F5` 刷新），
 你会看到左侧栏中出现了 “Downloads”。
