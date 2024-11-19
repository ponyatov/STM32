# format
.PHONY: format
format: tmp/format_cpp tmp/format_js
tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@
tmp/format_js: $(J)
	$(CF) $? && touch $@
