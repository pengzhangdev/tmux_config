

update:
	git submodule update --init

libevent: update
	mkdir -p libs include out
	cd libevent \
	&& ./autogen.sh \
	&& ./configure
	make -C libevent/
	cp libevent/.libs/libevent* libs/
	cp -rf libevent/include/event2 include/
	cp -f libevent/evdns.h libevent/event.h libevent/evhttp.h libevent/evrpc.h libevent/evutil.h include/

ncurses: update
	mkdir -p libs include out
	cd ncurses \
	&& ./configure --datarootdir=${PWD}/out/
	make -C ncurses/
	make -C ncurses/misc install
	cp ncurses/lib/libncurses* libs/
	cp -rf ncurses/include/* include/
	cd libs/ \
	&& ln -sf libncurses.a libcurses.a

tmux: update libevent ncurses
	mkdir -p libs include out
	cd tmux-code \
	&& ./autogen.sh \
	&& export CFLAGS="-I../includes/ -static" \
	&& export CPPFLAGS="-I../includes/ -static" \
	&& export LDFLAGS="-L../libs/" \
	&& ./configure --enable-static \
	&& git am ../patch/patch_for_tmux/*.patch
	make -C tmux-code
	cp tmux-code/tmux ./out/
	@echo "INSTALL tmux and terminfo to out/"

clean: 
	-rm -r libs include out
	-rm tmux
	make -C libevent/ clean
	make -C ncurses/ clean
	make -C tmux-code/ clean
	git submodule update --init

