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
>
> #### 启动失败, 直接进入 grub
> -> 没找到 EFI, 把硬盘重新插一下试试
> 

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

```
~/.profile
git config --global http.proxy http://127.0.0.1:7897
git config --global https.proxy http://127.0.0.1:7897

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
export PATH=$JAVA_HOME/bin:$PATH

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# export PATH=$PATH:~/.npm-global/bin 不需要, 会导致全局安装失败
```

> 在 Linux Mint Cinnamon 桌面环境中，你打开文件浏览器（默认是 Nemo）

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

+ 自定义规则 -> `Open File`

  ```
      # ---- OpenAI / ChatGPT 必走代理 ----
      - DOMAIN-SUFFIX,chatgpt.com,PROXY
      - DOMAIN-SUFFIX,openai.com,PROXY
      - DOMAIN-KEYWORD,openai,PROXY
      - DOMAIN-KEYWORD,chatgpt,PROXY
      # 鉴权与常见依赖（可选但推荐）
      - DOMAIN-SUFFIX,auth0.com,PROXY
      - DOMAIN-SUFFIX,sentry.io,PROXY
      - DOMAIN-SUFFIX,stripe.com,PROXY
      - 'DOMAIN-SUFFIX,chatgpt.com,CATNET'
      - 'DOMAIN-SUFFIX,openai.com,CATNET'  # 建议也加上
      - 'GEOIP,CN,DIRECT,no-resolve' # 防止 GeoIP 规则提前解析域名：
      - MATCH,龙猫云 - TotoroCloud
  ```
  

+ curl 设置代理

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

http_proxy=http://127.0.0.1:7897 \
https_proxy=http://127.0.0.1:7897 \
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

#### mac install Tailscale
不要使用桌面端, 各种问题
```
brew install --formula tailscale
sudo brew services start tailscale # 加入自启服务
tailscale up
tailscale status

```

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

### 输入法 - 谷歌

在 **Linux Mint（基于 Ubuntu 22/24 系列）** 上安装 **Google 拼音输入法（Fcitx 版）**。
 下面是完整、稳定的安装方法👇

------

🧩 一、确认输入法框架（必须用 Fcitx 4）

Mint 默认使用 `ibus`，而 **Google Pinyin 仅支持 Fcitx 4**。

先切换输入法框架：

```
im-config -n fcitx
```

如果系统没装 Fcitx，先装上：

```
sudo apt update
sudo apt install -y fcitx fcitx-bin fcitx-ui-classic fcitx-table fcitx-config-common \
  fcitx-frontend-gtk3 fcitx-frontend-qt5
```

然后重启一次系统或执行：

```
fcitx-autostart &
```

------

🧰 二、安装 Google 拼音输入法模块

Fcitx 自带 Google 拼音模块，不用额外下载 `.deb`。

```
sudo apt install -y fcitx-googlepinyin
```

------

⚙️ 三、添加输入法

打开配置界面：

```
fcitx-config-gtk3
```

1. 点击 “+”
2. 搜索 “Google Pinyin”
3. 选中并添加到输入法列表顶部
4. 保存后退出

切换快捷键默认是：`Ctrl + Space`（或在 Fcitx 设置里改）。

------

🔠 四、设置环境变量（确保 Fcitx 全局生效）

执行：

```
grep -q "GTK_IM_MODULE=fcitx" ~/.xprofile 2>/dev/null || cat >> ~/.xprofile <<'EOF'
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
EOF
```

然后重启系统（或注销再登录）。

------

✅ 五、验证是否生效

执行：

```
fcitx-diagnose | grep google
```

应当看到：

```
Input Method Configurations:
  Google Pinyin: Enabled
```

在输入框按 `Ctrl + Space` 试试，就能切换到 Google 拼音输入法。

六、快捷键

你可以生成一个默认配置：

```
fcitx-configtool
```

- 打开 GUI 配置器 → 选择 'addon'
- 找到 "Simplified Chinese....Traditional..." 双击
- 修改为 `Ctrl+Shift+F` 或 “无(None)”

#### 云拼音

fcitx4 不存在云

#### 快捷键

打开输入法管理器, 关闭所有快捷键; 切换中英文用ctrl

### Chrome

+ 注释掉 Google Chrome 源

```
sudo xed /etc/apt/sources.list.d/google-chrome.list
```

改成：

```
# deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main
```

+ 1106/180558.090845:ERROR:third_party/crashpad/crashpad/snapshot/elf/elf_dynamic_array_reader.h:64 tag not found
```
sudo apt update
sudo apt install --reinstall libnss3 libatk-bridge2.0-0 libatspi2.0-0 libdrm2 \
  libx11-6 libx11-xcb1 libxkbcommon0 libgtk-3-0
sudo apt -f install
sudo apt full-upgrade
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

+ pycharm - Linux linux
+ IDEA - Linux x86_64

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

> 不需要 xx.sh; 直接使用 xx 启动

1️⃣ IntelliJ IDEA

```
cat <<EOF > ~/.local/share/applications/idea.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA
Icon=/home/hsiong/code/Software/idea-IU-241.19416.15/bin/idea.png
Exec=/home/hsiong/code/Software/idea-IU-241.19416.15/bin/idea
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
Exec=/home/hsiong/code/Software/pycharm-2024.1.7/bin/pycharm
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

#### 六、其他

#### pycharm 导入 setting文件后导致了这个报错￼￼￼

可能是导入的 pycharm  key/vmoptions 导致的错误

```
cd ~/.config/JetBrains/PyCharm<版本号>/
rm -rf pycharm.key pycharm64.vmoptions
```

### idea 2025 闪退

kotlin 导致的报错, 停用Kotlin, 删除 /idea/plugins/Kotlin/*, 保留 Kotlin 目录, 重新下载即可

### Sublime

```
# === 安装 Sublime Text 官方版 ===
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install -y sublime-text

# === 改名 “sublime” ===
sudo mv /usr/bin/subl /usr/bin/sublime
hash -r

# === 创建桌面快捷方式 ===
sudo tee /usr/share/applications/sublime-text.desktop > /dev/null <<'EOF'
[Desktop Entry]
Name=Sublime Text
GenericName=Text Editor
Comment=Sophisticated text editor for code, markup and prose
Exec=sublime %F
Terminal=false
Type=Application
Icon=sublime-text
Categories=TextEditor;Development;
StartupNotify=true
MimeType=text/plain;
EOF

# === 复制到桌面并授予执行权限 ===
cp /usr/share/applications/sublime-text.desktop ~/Desktop/
chmod +x ~/Desktop/sublime-text.desktop

# === 更新系统菜单缓存 ===
sudo update-desktop-database

```

#### 想让 Sublime Text 每次启动时都打开一个“全新的空窗口”，而不是自动恢复上次打开的文件或项目。

这其实是两个设置项控制的行为：hot_exit 和 remember_open_files。

解决方法（永久设置）打开：Preferences → Setting

在右侧（用户设置）里添加或修改以下内容：

```
{    
	"hot_exit": false,    
	"remember_open_files": false
}
```



### Docker

🧩 一、清理旧源（防止冲突）

```
sudo rm -f /etc/apt/sources.list.d/docker.listsudo 

rm -f /etc/apt/keyrings/docker.gpg
```

二、更新系统并安装依赖

```
sudo apt update
sudo apt install ca-certificates curl gnupg lsb-release
```

------

🗝️ 三、添加 Docker 官方 GPG 密钥

```
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

> 💡 Mint 基于 Ubuntu，所以使用 Ubuntu 的源。

------

📦 四、添加 Docker 软件源

> ☆☆☆ 这步要先查 lsb_release -a

```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

------

🔄 五、更新并安装 Docker

```
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

------

🚀 六、验证 Docker 是否安装成功

```
sudo docker ps
```

若输出类似：

```
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

说明安装成功 ✅

------

👤 七、可选：让当前用户无需 sudo 使用 Docker

```
sudo usermod -aG docker $USER
```

然后退出并重新登录终端，让组权限生效。

验证：

```
docker ps
```

如果不再提示 “permission denied”，说明配置成功。

------

🧩 八、安装 Docker Compose（旧版）

如果你需要传统的 `docker-compose` 命令：

```
sudo apt install docker-compose
```

九、配置国内源

+ 代理

  ```
  sudo mkdir -p /etc/systemd/system/docker.service.d
  sudo vim /etc/systemd/system/docker.service.d/proxy.conf
  ```

  ```
  [Service]
  Environment="HTTP_PROXY=http://127.0.0.1:7890"
  Environment="HTTPS_PROXY=http://127.0.0.1:7890"
  Environment="NO_PROXY=localhost,127.0.0.1,::1"
  ```

  ```
  sudo systemctl daemon-reexec
  sudo systemctl daemon-reload
  sudo systemctl restart docker
  systemctl show --property=Environment docker
  
  ```

+ 国内源

  ```
  sudo mkdir -p /etc/docker
  sudo tee /etc/docker/daemon.json <<-'EOF'
  {
    "registry-mirrors": [
      "https://docker.m.daocloud.io",
      "https://dockerproxy.com",
      "https://docker.1panel.live"
    ]
  }
  EOF
  ```

  ```
  sudo systemctl daemon-reload
  sudo systemctl restart docker
  ```


### NPM

```
curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_22.x/setup_22.x | sudo -E bash -

sudo apt install -y nodejs
node -v
npm -v
npm config set registry https://registry.npmmirror.com

sudo npm install -g pnpm
pnpm config set proxy http://127.0.0.1:7897
pnpm config set https-proxy http://127.0.0.1:7897
pnpm config set registry https://registry.npmmirror.com/

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && pip config set global.proxy http://127.0.0.1:7897

```

#### Claude Code

+ https://www.aicodemirror.com/dashboard/official-installation/macos-linux

  ```
  curl -fsSL https://download.aicodemirror.com/env_deploy/env-install.sh | bash
  
  sudo npm uninstall -g @anthropic-ai/claude-code
  sudo npm install -g @anthropic-ai/claude-code
  claude -v
  ```
  
  ```
  sudo apt-get install jq
  curl -fsSL https://download.aicodemirror.com/env_deploy/env-deploy.sh | bash -s -- "你的API_KEY"
  claude -v
  ```

+ https://api.codemirror.codes/about

  ```
  curl -fsSL https://gitee.com/CoderRouter/scripts/raw/master/install_claude.sh \
  | sed 's/\r$//' \
  | bash
  npm install -g @anthropic-ai/claude-code
  ```
  
  ```
  curl -fsSL https://gitee.com/CoderRouter/scripts/raw/master/setup_claude_env.sh \
  | sed 's/\r$//' \
  | bash -s -- "你的API_KEY"
  ```

#### 在设置里**直接封禁写入这些文件**

在 `~/.claude/settings.json`（全局）或项目内的 `.claude/settings.json` 写入对 **Edit/Write** 的拒绝规则即可。规则使用 *gitignore 风格的路径匹配*（相对该 settings 文件路径）：

```
{
  "permissions": {
    "deny": [
      "Edit(MIGRATION_REPORT.md)",
      "Write(MIGRATION_REPORT.md)",
      "Edit(/**/MIGRATION_REPORT*.md)",
      "Write(/**/MIGRATION_REPORT*.md)",
      "Edit(/**/migration_report*.md)",
      "Write(/**/migration_report*.md)",
      "Edit(/**/ARCHITECTURE.md)",
      "Write(/**/ARCHITECTURE.md)",
      "Edit(/**/PROJECT_INTAKE.md)",
      "Write(/**/PROJECT_INTAKE.md)"
    ]
  }
}
```

### Github ssh

```
ssh-keygen -t ed25519 -C "你的邮箱"
ls -l ~/.ssh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

vim ~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  AddKeysToAgent yes
  IdentitiesOnly yes

cat ~/.ssh/id_ed25519.pub # 加入 github
```

```
ssh-keygen -R github.com  # 清除旧记录（如果有）
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts
ssh -T git@github.com  # 按提示重新加入 host key
```

#### 无法提交

hsiong:base-backend/ (main*) $ git push -u origin HEAD                                                                                                                                                                           [16:39:47] Username for 'https://github.com':    依然提示....

> 注意地址要使用 ssh 而不是 https

### Redis Desktop

```
#!/bin/bash
# === 创建 Redis Desktop Manager 启动器 ===
APP_PATH="/home/hsiong/code/Software/Another-Redis-Desktop-Manager-linux-1.7.1-x86_64.AppImage"
ICON_PATH="/home/hsiong/.local/share/icons/redis.png"
DESKTOP_FILE="$HOME/.local/share/applications/another-redis-desktop-manager.desktop"
DESKTOP_SHORTCUT="$HOME/Desktop/Another-Redis-Desktop-Manager.desktop"

# 创建图标目录
mkdir -p "$(dirname "$ICON_PATH")"

# https://icon2.cleanpng.com/20180630/zte/kisspng-redis-database-erlang-cache-computer-servers-5b3814aade3601.5242758815304019629102.jpg
手动下载

# 生成菜单项
cat << EOF > "$DESKTOP_FILE"
[Desktop Entry]
Name=Another Redis Desktop Manager
Comment=Manage Redis databases with a GUI client
Exec=env LIBGL_ALWAYS_SOFTWARE=1 $APP_PATH --in-process-gpu
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Development;Database;
StartupNotify=true
EOF

# 设置权限
chmod +x "$DESKTOP_FILE"

# 同步数据库（让菜单立即刷新）
update-desktop-database ~/.local/share/applications >/dev/null 2>&1

# 复制到桌面（可双击启动）
cp "$DESKTOP_FILE" "$DESKTOP_SHORTCUT"
chmod +x "$DESKTOP_SHORTCUT"

echo "✅ 已完成：
1️⃣ 应用菜单已创建 → 搜索 'Another Redis Desktop Manager'
2️⃣ 桌面图标已生成 → 双击即可启动
3️⃣ 启动命令：LIBGL_ALWAYS_SOFTWARE=1 --in-process-gpu
图标文件路径：$ICON_PATH
"

```



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
