# Docker-MTProxy
Docker for Telegram MTProxy-TLS

# Usage
```bash
docker run -d --name mtproxy --restart=always -p443:443 xiaokaixuan/mtproxy <32ch-secret> [domain]

docker logs -f mtproxy # MTProxy client secret is in the first line.
```
#  Reference
*https://hub.docker.com/r/xiaokaixuan/mtproxy*

*https://github.com/TelegramMessenger/MTProxy*

