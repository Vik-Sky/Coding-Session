# Coding-Session
Coding Session - програмування телеграм бота на мові Golang
Інструкція покрокова:

```
- Встановити GOLANG (https://go.dev/dl/)
- Створити Telegram-бота за допомогою BotFather.
- Отримати токен бота та зберегти його у змінну середовища TELE_TOKEN.
- Скопіювати отриманій токен до буферу і далі виконати наступні комманди:
- read -s TELE_TOKEN - додаємо скопійований токен до змінної Ctrl+C
- echo $TELE_TOKEN - перевіряємо, що змінна отримала наш токен
- export TELE_TOKEN - експортуємо наш токен
- Збираємо нашого бота до купи - go build -ldflags "-X="github.com/Vik-Sky/Coding-Session/cmd.appVersion=1.0.2
- Запустити бінарний файл на виконнаня - ./Coding-Section start
- Запустити бота та перевірити, як він працює. 
  Написати боту повідомлення /start hello і бот відповість вам Hello I'm csbot 1.0.2!

Мій бот t.me/Vizotikos_bot (csbot)
```