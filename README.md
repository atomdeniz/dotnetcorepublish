# Dotnet Core Publish

Her git comittinde projenizi pull edip, build eden ve docker compose ile yayınlayan uygulama

Not: Projenize [docker-compose](https://gist.github.com/atomdeniz/9f8211d07135adb94b56f62d75958d2b) ve [dockerfile](https://lmgtfy.com/?q=dockerfile+for+%20X+program) eklemeyi unutmayın

## Github bilgilerini kayıt etme

Bunun için iki yöntem var.
Birinci yöntem ile deploy key oluşturarak kullanıcı bağımsız clone ve pull işlemleri yapabilirsiniz.
İkinci yöntem ise kullanıcı şifre ve kullanıcı adını bilgisayara kayıt eder.

[1.Yöntem](https://gist.github.com/zhujunsan/a0becf82ade50ed06115)

2. Yöntem
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
şekilinde dosyayı kaydediniz.

### Pm2 yükleme

Nodejs'in arkaplanda çalışmasını sağlayan bir sistemdir.

```bash
npm install pm2 -g
```

### Kodumuzu çalıştırma 

```bash
pm2 start index.js
```

## Nginx, Domain ve SSL
[Kurulum Dosyası](https://docs.google.com/document/d/1jlJm0P5PS6XBRrtdsCQfr2UJuwGyAjmV8FZU9UJcNzA/edit?usp=sharing)


