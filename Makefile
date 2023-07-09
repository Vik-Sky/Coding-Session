APP :=$(shell basename $(shell git remote get-url origin) | tr '[:upper:]' '[:lower:]')
# Имя вашего приложения
REGISTRY :=vitaliysazhevsky
# Имя реестра Docker, в который будет выполняться сборка и пуш контейнера
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
# Версия, созданная на основе последнего тега Git и хэша последнего коммита
TARGETOS=linux
# Целевая операционная система для сборки (linux, darwin, windows)
TARGETARCH=arm64
# Целевая архитектура для сборки (amd64, arm64)

format:
	gofmt -s -w ./ 
# Форматирование кода Go с помощью gofmt

lint:
	golint 
# Проверка стиля кода с помощью golint

test:
	go test -v 
# Запуск тестов Go

get:
	go get 
# Установка зависимостей Go

# Сборка исполняемого файла Go с помощью go build. Установлены переменные среды для целевой ОС и архитектуры.
# Компиляция без использования CGO.
# Компиляция с флагом ldflags, чтобы установить версию приложения.
build:
	go build -v -o kbot -ldflags "-X 'github.com/vik-sky/coding-session/cmd.appVersion=${VERSION}'"

# Сборка Docker-образа. Используется Dockerfile из текущего каталога.
# Установка тега образа на основе имени реестра, имени приложения, версии и целевой архитектуры.
# Передача аргумента TARGETARCH во время сборки с помощью --build-arg.
image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

# Загрузка Docker-образа в реестр Docker.
push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

# Удаление собранного исполняемого файла
# Удаление Docker-образа из локального репозитория
clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}