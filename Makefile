APP :=$(shell basename $(shell git remote get-url origin)) # Имя вашего приложения, извлеченное из URL удаленного репозитория Git
REGISTRY :=Vik-Sky # Имя реестра Docker, в который будет выполняться сборка и пуш контейнера
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD) # Версия, созданная на основе последнего тега Git и хэша последнего коммита
TARGETOS=linux # Целевая операционная система для сборки (linux, darwin, windows)
TARGETARCH=arm64 # Целевая архитектура для сборки (amd64, arm64)

format:
	gofmt -s -w ./ # Форматирование кода Go с помощью gofmt

lint:
	golint # Проверка стиля кода с помощью golint

test:
	go test -v # Запуск тестов Go

get:
	go get # Установка зависимостей Go

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X 'github.com/Vik-Sky/Coding-Session/cmd.appVersion=${VERSION}'"
	# Сборка исполняемого файла Go с помощью go build. Установлены переменные среды для целевой ОС и архитектуры.
	# Компиляция без использования CGO.
	# Компиляция с флагом ldflags, чтобы установить версию приложения.

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}  --build-arg TARGETARCH=${TARGETARCH}
	# Сборка Docker-образа. Используется Dockerfile из текущего каталога.
	# Установка тега образа на основе имени реестра, имени приложения, версии и целевой архитектуры.
	# Передача аргумента TARGETARCH во время сборки с помощью --build-arg.

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} # Загрузка Docker-образа в реестр Docker.

clean:
	rm -rf kbot # Удаление собранного исполняемого файла
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} # Удаление Docker-образа из локального репозитория
