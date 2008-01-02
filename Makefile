.PHONY: themes tarballs

colors=blue yellow brown grey green violet viorange red purple navy sea_blue emerald hot_orange white black red-argentina

themes:

tarballs:

.colorrules: Makefile
	( \
	for color in $(colors); do \
		for rule in theme-$$color oxygen-cursors-$$color.tar.bz2; do \
			echo "$$rule: .depend"; \
			echo "	\$$(MAKE) -f Makefile.colors COLOR=$$color $$rule"; \
		done; \
		echo ".PHONY: theme-$$color"; \
		echo "themes: theme-$$color"; \
		echo "tarballs: oxygen-cursors-$$color.tar.bz2"; \
	done; \
	) > .colorrules

.depend: $(patsubst %.in,%.dep,$(wildcard configs/*.in))
	cat $^ > $@

configs/%.dep: configs/%.in Makefile
	echo "cursors/oxy-\$$(COLOR)/cursors/$(notdir $(patsubst %.in,%,$<)): \$$(addprefix pngs/\$$(COLOR)/,$$(cut -d ' ' -f 4 $< | xargs echo))" > $@

include .colorrules
