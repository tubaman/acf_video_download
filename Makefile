all: deps updatedeps download

# download dependencies
deps: .get_flash_videos .bashpodder

.get_flash_videos:
	git clone https://github.com/monsieurvideo/get-flash-videos.git
	touch $@

.bashpodder: .xsltproc
	touch podcast.log
	touch $@

.xsltproc:
	which xsltproc
	touch $@

# update deps
GET_FLASH_VIDEOS_VER=8890ed9
updatedeps: deps update_get_flash_videos

update_get_flash_videos:
	cd get-flash-videos; git checkout $(GET_FLASH_VIDEOS_VER)


clean:
	echo "" > podcast.log
	rm -rf 20*
	rm -f temp.log

distclean: clean
	rm -f .get_flash_videos .bashpodder .xsltproc
	rm -f podcast.log
	rm -rf get-flash-videos

download:
	PATH=$$PWD:$$PWD/get-flash-videos:$$PATH; \
	bashpodder
