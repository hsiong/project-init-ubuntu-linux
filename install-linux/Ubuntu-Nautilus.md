# 在 Linux 中调整 Nautilus 文件管理器的 13 种方法

------

**Nautilus，又名 GNOME Files，是一个很好的文件管理器，具有很多功能。您可以通过使用这些扩展、调整和提示来进一步增强您的体验。**

Nautilus 是 GNOME 的默认文件管理器应用程序，您可能在许多 Linux 发行版中都见过它。

这是一个很好的文件管理器，具有很多功能。但是，您可以通过一些调整和技巧来增强您的体验。

我将在本文中分享这些技巧和调整。有些调整可能需要安装额外的 Nautilus 插件，而有些则是内置但鲜为人知的功能。一些技巧纯粹是装饰性的，只是改变外观和感觉。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/customizing-GNOME-Nautilus-File-Manager.png)

GNOME 的默认文件浏览器曾经被称为 Nautilus。它现在称为文件。然而，经验丰富的 Linux 用户仍然将其称为 Nautilus。我在这里使用了这两个术语。

还有一件事。 ***您不必尝试安装每个 Nautilus 插件\***。阅读这篇文章并选择对您有帮助的文章。

我为 Ubuntu/Debian 添加了 Nautilus 扩展命令。如果您使用其他发行版，请使用包管理器来安装它们。

## 1.显示文件夹中的项目数

您可以显示 GNOME 文件中一个文件夹内有多少个文件和文件夹。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Item-count-inside-folder-visible.png)

您不需要为其安装任何插件。这是一个内置功能。

转到 Nautilus 中的**首选项**。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/GNOME-Nautilus-Preferences-scaled.webp)

在**图标视图标题**下，将**第一个**位置设置为**大小**。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Nautilus-preferences.png)

## 2.右键菜单中添加新文档创建选项

这是一项可以提高您的工作效率的功能。右键单击文件夹内的空白位置，您应该会看到创建新的空文本文件或文档的选项。

几年前它已从 GNOME 中删除，并且很可能会在下一个 GNOME 版本中重新出现。

为此，您需要创建一个空文件并将其命名为**新文档**。然后将此文件保存到 Templates 目录中，以便在右键单击上下文菜单中获取它。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Nautilus-Empty-file-in-Templates-Directory.png)

之后，您应该在右键单击上下文菜单中看到该选项。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Nautilus-Right-Click-New-Document.png)

您还可以类似地在右键菜单中添加Word文档、PPT演示选项等。

## 3.右键菜单添加永久删除选项

默认情况下，Nautilus 在右键单击上下文菜单中提供“移至垃圾箱”选项。如果您想永久删除文件或文件夹，则需要**shift+删除**或将其从垃圾箱中清空。

您可以在 Nautilus **首选项**的右键单击上下文菜单下启用“删除永久”按钮。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Delete-option-in-nautilus-preferences.png)

现在，您可以在右键单击上下文菜单中选择永久删除文件和文件夹。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Delete-option-under-right-click-context-menu.png)

## 4. 彻底擦除磁盘上的文件和文件夹

即使您永久删除文件，数据仍有可能恢复。

Nautilus 提供了一个扩展来安全地擦除文件并填充空白位置，以便数据无法再恢复。

首先安装 Nautilus 扩展。

```undefined
sudo apt install nautilus-wipe
```

然后重新启动文件资源管理器：

```undefined
nautilus -q
```

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Secure-wipe-in-nautilus.png)

## 5.启用快速文件预览

对于文件管理器来说，快速预览是一个相当方便的功能。 KDE 的 Dolphin 文件管理器将其作为内置功能提供。

您可以预览 PDF、文本、图像、音频等文件。您可以在预览时滚动文档。

在 Nautilus 中，您需要安装 gnome-sushi 才能获得此功能。

```undefined
sudo apt install gnome-sushi
```

现在，关闭文件管理器的所有实例并再次打开它。要查看预览，请选择一个文件并按空格键。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/preview-files-in-nautilus-using-gnome-sushi.png)

## 6. 获取最近访问过的目录列表

Nautilus 具有显示“最近访问的文件”的功能。但是最近访问过的文件夹呢？

那也可以访问。在左上角，**右键单击后退箭头**即可获取以前访问过的文件夹的列表。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/List-of-directories-visited.png)

## 7. 将文件夹添加到左侧边栏以便快速访问

如果您经常访问某些文件夹，最好从左侧边栏快速访问它们。

实际上，这很简单。选择文件夹并拖放到左侧边栏。该文件夹将被添加为书签。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/add-folder-as-bookmark-GNOME-Files-scaled.webp)

您可以用同样的方法删除书签。只需将其从侧边栏拖放即可。

## 8. 右键单击图像旋转和调整图像大小

要启用此功能，您需要安装 ImageMagick 和 nautilus-image-converter。

```undefined
sudo apt install imagemagick nautilus-image-converter
```

安装后，使用 *nautilus -q* 退出 nautilus，然后重新打开 nautilus。

现在选择图像并右键单击以调整图像大小和旋转图像。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Rotate-and-Resize-Images-with-nautilus.png)

## 9.更改单个文件夹的颜色

如果您想为文件资源管理器添加一些颜色，更改文件夹的颜色怎么样？

您可以使用不同的图标和主题更改所有文件夹的图标和颜色。

但您也可以选择仅更改选定的几个文件夹的颜色。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Custom-Folder-Color-in-nautilus-file-manager.png)

为此，请安装以下软件包。

```dos
sudo apt install folder-color
```

现在，使用 **nautilus -q** 命令退出 Nautilus。重新打开后，选择一个文件夹并右键单击它。您将找到更改文件夹颜色的选项。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Change-Folder-Color-Right-Click-Option.png)

更进一步，您可以向文件或文件夹添加标志，例如重要文件、收藏夹等。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Folder-and-File-Emblem-in-Nautilus.png)

## 10.更改各个目录的图标

这让我回到了Windows XP时代。 Nautilus 还具有更改所选目录图标的内置功能。

为此，请右键单击文件夹并转到属性。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/properties-dialog-box-of-a-directory.png)

从那里选择图标，浏览并选择您喜欢的图像。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Changing-Folder-Icon.png)

## 11.打开终端中的任意位置

这不需要任何额外的步骤。从文件管理器中的任何位置，只需右键单击并选择“在终端中打开”选项。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/open-in-terminal-ubuntu-scaled.webp)

它将打开一个新终端，您将位于 Nautilus 文件管理器的确切位置。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/location-opened-in-terminal.png)

当您必须在终端中对特定位置的文件执行某些操作时，这会派上用场。它节省了输入长路径的精力。

## 12. 从文件管理器中以 root 身份打开文件和文件夹

有时您想将文件粘贴到受限目录，例如 /usr/share/backgrounds。除非您是 root 或使用 sudo，否则您无法粘贴此类位置或无法编辑此类文件。

您可以轻松地在终端中切换执行此操作，但是文件管理器呢？

使用 nautilus-admin 扩展，您可以在 Nautilus 中以 root 身份打开文件。无需打开终端并执行 sudo 操作。

```undefined
sudo apt install nautilus-admin
```

安装插件后退出 Nautilus：

```undefined
nautilus -q
```

您现在应该在右键菜单中看到“以管理员身份打开”选项。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/open-as-admin-in-nautilus.png)

## 13. 验证文件的哈希校验和

Linux 中有专门的工具来验证文件的校验和。您还可以使用 nautilus-gtkhash 扩展名检查 Nautilus 文件管理器中的哈希值。

```undefined
sudo apt install nautilus-gtkhash
```

现在使用 **nautilus -q** 退出 nautilus 并重新打开。选择要检查哈希的文件，然后转到属性中的**摘要**选项卡。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Check-hashes-in-nautilus.png)

现在输入要检查的哈希值并按哈希值。它将开始计算哈希值。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Nautilus-Checking-Hash-Progress.png)

一段时间后，它将显示结果（如果哈希有效，则为绿色勾号）。

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Nautilus-Checking-Hash-Success.png)

## 奖励：嵌入终端

在 Nautilus 文件管理器中，您可以嵌入终端。每次更改目录时，都会启动 cd 命令，并且嵌入式终端中的位置也会更改。

安装它需要先获取几个Python包。命令如下，一一使用：

```sql
sudo apt install python3-nautilus python3-psutil python3-pip libglib2.0-bin dconf-editor
sudo pip3 install nautilus-terminal
sudo nautilus-terminal --install-system
nautilus -q
```

![img](https://cn.linux-console.net/common-images/nautilus-tips-tweaks/Embedded-terminal-in-nautilus.png)

## 更多 Nautilus 扩展和调整

自定义 GNOME 文件管理器是永无止境的。我只能包括选定的几个。我能想到的还有：

- 在首选项中显示或隐藏“位置”面板
- 集成各种云存储平台，如 Google Drive、Dropbox、Nextcloud、Owncloud 等
- 通过将项目拖到垃圾箱文件夹中来删除项目
- 通过按 Control 键并滚动来放大和缩小

您可能还想掌握 Nautilus 中的文件搜索。

如果您需要更多自定义功能，请查看有关调整 Ubuntu Dock 的指南。

还有一篇类似的文章关于调整 Cinnamon 桌面的 Nemo 文件管理器。

我希望你能在这里找到一些有趣的东西。你最喜欢哪些？你还知道我在这里没有提到的其他一些调整吗？在评论中分享一下吧。