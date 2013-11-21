

update:
	git submodule update --init

libevent: update
	mkdir -p libs
	cd libevent \
	&& ./autogen.sh \
	&& ./configure 
	make -C libevent/ 
	cp libevent/.libs/libevent* libs/

ncurses: update
	mkdir -p libs
	cd ncurses \
	&& ./configure 
	make -C ncurses/
	cp ncurses/lib/libncurses* libs/
	cd libs/ \
	&& ln -sf libncurses.a libcurses.a

tmux: update libevent ncurses
	mkdir -p libs
	cd tmux-code \
	&& ./autogen.sh \
	&& ./configure \
	&& cp ../patch/tmux_code_Makefile ./Makefile 
	make -C tmux-code
	cp tmux-code/tmux ./

clean: 
	-rm -r libs
	-rm tmux
	make -C libevent/ clean
	make -C ncurses/ clean
	make -C tmux-code/ clean
	git submodule update --init

