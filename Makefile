all: deps download

# download dependencies
deps: .get_flash_videos .bashpodder

GET_FLASH_VIDEOS_VER=8890ed9
.get_flash_videos:
	git clone https://github.com/monsieurvideo/get-flash-videos.git
	cd get-flash-videos; git checkout $(GET_FLASH_VIDEOS_VER)
	touch $@

.bashpodder: .xsltproc
	touch podcast.log
	touch $@

.xsltproc:
	which xsltproc
	touch $@

clean:
	echo "" > podcast.log
	find -maxdepth 1 -type d -name "????-??-??" | xargs rm -r
	rm -f temp.log

distclean: clean
	rm -f .get_flash_videos .bashpodder .xsltproc
	rm -f podcast.log
	rm -rf get-flash-videos

download:
	PATH=$$PWD:$$PWD/get-flash-videos:$$PATH; \
	bashpodder
