all: deps updatedeps download

# download dependencies
deps: .get_flash_videos .bashpodder

.get_flash_videos:
	git clone https://github.com/monsieurvideo/get-flash-videos.git
	touch $@

.bashpodder: .xsltproc
	wget http://lincgeek.org/bashpodder/bashpodder.shell -O bashpodder
	wget http://lincgeek.org/bashpodder/parse_enclosure.xsl -O parse_enclosure.xsl
	chmod +x bashpodder
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
	rm -f parse_enclosure.xsl bashpodder

download:
	PATH=$$PWD:$$PWD/get-flash-videos:$$PATH; \
	bashpodder
