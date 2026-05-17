




# clash verge

# idea & pycharm 


# github

# chrome

# codex 

# gemini

# wechat

# sunlogin

# wps


# sing-box


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