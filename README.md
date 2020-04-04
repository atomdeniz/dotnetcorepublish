# Dotnet Core Publish

Her git comittinde projenizi pull edip, build eden ve docker compose ile yayınlayan uygulama

## Github bilgilerini kayıt etme
Mevcut projenizin dosya yoluna giriniz.

```bash
git config --global credential.helper store
```
bu satırı çalıştırın ve

```bash
git pull
```
işlemi ile mevcut projenizi tekrar çekin. 
Bu sayede github bilgileriniz mevcut makineye kaydedildi.

## Kurulum

Mevcut projenizin dosya yoluna giriniz. Bu projeyi çekiniz ardından bu projenin dizinine giriniz.

### Docker ve Nodejs hızlı kurulum

```bash
sh nodedocker.sh
```

### Npm dosyalarını yükleme

```bash
npm install 
```
### .env dosyası oluşturma

```bash
nano .env
```

```bash
SECRET=buraya şifre 
```
şekilinde dosyayı giriniz. Ctrl + X çıkış

### Pm2 yükleme

Nodejs'in arkaplanda çalışmasını sağlayan bir sistemdir.

```bash
pm2 install -g
```

### Kodumuzu çalıştırma 

```bash
pm2 start index.js
```

## Nginx ve Reverse Proxy

[NGNİX KURULUM](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04)

cd etc/nginx/sites-enabled/ dizinindeki default dosyamızı aşağıdaki gibi yapılandırıyoruz.  service nginx restart Nginx’i yeniden başlatmayı unutmayalım.

```bash
upstream coreapp {
    server localhost:5000;
    server localhost:5001;
    server localhost:5002;
}
server {
    listen 80;
 
        location / {
            proxy_pass http://coreapp;
        }
}
```
