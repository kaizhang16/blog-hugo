export PATH := bin:$(PATH)

build:
	rm -rf public && hugo

watch:
	hugo server -D
