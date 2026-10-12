# 交接

## remove server ssh



## 账号登出

+ codex 
+ gemini
+ antigravity
+ frp => 影响 钉钉机器人 
+  clash verge + config
+  idea & pycharm 
	+  jetbrain crack
    + codeium
+ github
+ chrome
+ wechat
+ sunlogin
+ wps
+ sing-box
+ docker proxy
+ git proxy


```
sudo systemctl stop sing-box 2>/dev/null || true
sudo systemctl disable sing-box 2>/dev/null || true

systemctl --user stop sing-box-client 2>/dev/null || true
systemctl --user disable sing-box-client 2>/dev/null || true

sudo apt remove --purge -y sing-box sing-box-beta
sudo apt autoremove -y

rm -f ~/.config/systemd/user/sing-box-client.service
systemctl --user daemon-reload
systemctl --user reset-failed

sudo rm -f /etc/apt/sources.list.d/sagernet.sources
sudo rm -f /etc/apt/keyrings/sagernet.asc

sudo rm -rf /etc/sing-box
sudo rm -rf  ~/.single-box
```

```
sudo vim /etc/docker/daemon.json
{
  "proxies": {
    "http-proxy": "http://192.168.1.10:7890",
    "https-proxy": "http://192.168.1.10:7890",
    "no-proxy": "localhost,127.0.0.1,::1,.local,10.0.0.0/8,192.168.0.0/16"
  }
}
```


```
git config --global --unset http.proxy
git config --global --unset https.proxy
```