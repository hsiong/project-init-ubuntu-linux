

当前目录下，按文件夹汇总：

```
sudo du -sh ./*
```

## 1）清理 apt 缓存

安全，优先做：

```
sudo apt clean
sudo apt autoclean
sudo apt autoremove -y
```

再看效果：

```
sudo du -h --max-depth=1 /var/cache | sort -h
```

------

## 2）清理 systemd 日志

很多 Ubuntu 机器 `/var/log/journal` 会很大。

先看占用：

```
journalctl --disk-usage
sudo du -h --max-depth=1 /var/log | sort -h
```

清到只保留 7 天：

```
sudo journalctl --vacuum-time=7d
```

或者限制到 500M：

```
sudo journalctl --vacuum-size=500M
```

------

## 3）清理 `/var/log` 里的大日志

看看哪些日志最大：

```
sudo find /var/log -type f -printf '%s %p\n' | sort -nr | head -30
```

把特别大的 `.log` 清空，而不是直接删文件：

```
sudo truncate -s 0 /var/log/syslog
sudo truncate -s 0 /var/log/kern.log
sudo truncate -s 0 /var/log/auth.log
```

如果文件不存在就跳过。

顺手删已经轮转压缩过的旧日志：

```
sudo find /var/log -type f \( -name "*.gz" -o -name "*.1" -o -name "*.old" \) -delete
```

## 4）如果用了 Docker，这里很可能是元凶

很多服务器 `/var/lib/docker` 会吃掉几十 G。

先看：

```
sudo du -h --max-depth=1 /var/lib/docker | sort -h
docker system df
```

安全清理未使用内容：

```
docker system prune -a -f
docker volume prune -f
```

如果你机器上跑着重要容器，先别乱删镜像和 volume。

**最常见的大头：容器日志**

先找最大的日志文件：

```
sudo find /var/lib/docker/containers -type f -name "*-json.log" -printf '%s %p\n' | sort -nr | head -20
```

## 5）如果用了 Snap，可以清理旧版本

你这里 `/snap` 有 1.4G，不算离谱，但可以瘦身。

查看：

```
snap list --all
```

删除已禁用的旧版本：

```
snap list --all | awk '/disabled/{print $1, $3}' | while read snapname revision; do
  sudo snap remove "$snapname" --revision="$revision"
done
```

限制以后最多保留 2 个版本：

```
sudo snap set system refresh.retain=2
```