colors=blue yellow brown grey green violet viorange red purple navy sea_blue emerald hot_orange white

tarballs: .depend
	for color in $(colors); do \
		$(MAKE) -f Makefile.colors COLOR=$$color || exit 1; \
	done

.depend: $(patsubst %.in,%.dep,$(wildcard configs/*.in))
	cat $^ > $@

configs/%.dep: configs/%.in
	echo "cursors/\$$(COLOR)/$(notdir $(patsubst %.in,%,$<)): \$$(addprefix pngs/\$$(COLOR)/,$$(cut -d ' ' -f 4 $< | xargs echo))" > $@
