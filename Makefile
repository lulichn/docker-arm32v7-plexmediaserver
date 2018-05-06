name = lulichn/arm32v7-plexmediaserver
tag = latest

build:
	docker build -t $(tag):$(latest) .

push:
	docker push $(name):$(tag)

