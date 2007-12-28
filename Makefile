.PHONY: themes tarballs

colors=blue yellow brown grey green violet viorange red purple navy sea_blue emerald hot_orange white

themes:

tarballs:

.colorrules: Makefile
	-rm .colorrules
	for color in $(colors); do \
	for rule in theme-$$color oxygen-cursors-$$color.tar.bz2; do \
		echo -e "$$rule: .depend\n\t\$$(MAKE) -f Makefile.colors COLOR=$$color $$rule" \
		>> .colorrules; \
	done; \
	echo -e ".PHONY: theme-$$color \nthemes: theme-$$color \ntarballs: oxygen-cursors-$$color.tar.bz2" >> .colorrules; \
	done

.depend: $(patsubst %.in,%.dep,$(wildcard configs/*.in))
	cat $^ > $@

configs/%.dep: configs/%.in
	echo "cursors/\$$(COLOR)/$(notdir $(patsubst %.in,%,$<)): \$$(addprefix pngs/\$$(COLOR)/,$$(cut -d ' ' -f 4 $< | xargs echo))" > $@

include .colorrules
