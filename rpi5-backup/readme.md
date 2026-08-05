## Backup Raspberry Pi

Backup of raspberry pi home server use the similar structure as [MacBook backup strategy](../mac-backup/readme.md)

It uses Borgmatic + borg as the service. One difference is that on Rpi5, besides the /home/ directory. /etc, /opt and /root also needs to be backed up. Thus Borgmatic needs to be run as root, this creates following complications,

1. Needs to use `sudo borgmatic` consistently.
1. borgmatic config.yml needs to locate under the /etc/config.yml. Softlink would be a solution.
1. Passwords is plain_text file to ensure the realibity of automation.

Additionally, borgmatic on rpi5 comes with two system services. borgmatic.timer and borgmatic.service. The first one counts the time and trigger the second one when the time comes. The second do a single round of back up according to the config.yml file. Following are some useful commands for the purpose,

```bash
systemctl list-timers borgmatic.timer       # Check next planned time
sudo systemctl start borgmatic.service      # Trigger the backup now

journalctl -u borgmatic.service -f          # 实时跟随,配合上面那条
journalctl -u borgmatic.service -n 50       # 最近 50 行
journalctl -u borgmatic.service --since today
journalctl -u borgmatic.service -p err      # 只看错误

systemctl status borgmatic.service

sudo systemctl edit borgmatic.timer      # 改时间
sudo systemctl edit borgmatic.service    # 改参数、降载设置
sudo systemctl cat borgmatic.service     # 看完整定义,包括你的 override

sudo systemctl stop borgmatic.service # 中断正在跑的
sudo systemctl disable --now borgmatic.timer # 彻底关掉调度
sudo systemctl enable --now borgmatic.timer # 恢复
```
