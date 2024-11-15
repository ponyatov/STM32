REF += ref/microrl/README
ref/microrl/README:
	$(GITREF) -b master https://github.com/Helius/microrl.git $(dir $@)

REF += cmake/FindRAGEL.cmake
cmake/FindRAGEL.cmake:
	$(CURL) $@ https://github.com/gsauthof/cmake-ragel/raw/refs/heads/master/FindRAGEL.cmake
