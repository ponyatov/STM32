# merge
MERGE += README.md LICENSE Makefile apt.txt .clang-format .doxygen
MERGE += .vscode bin doc lib inc src tmp ref mk
MERGE += hw cpu arch os

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout $(USER) -- $(MERGE)

.PHONY: $(USER)
$(USER):
	git push -v
	git checkout $(USER)
	git pull -v

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) $(USER)

ZIP = tmp/$(MODULE)_$(NOW)_$(REL)_$(BRANCH).zip
zip: $(ZIP)
$(ZIP): doxy
	git archive --format zip --output $(ZIP) HEAD
	zip -r $(ZIP) \
		doc/html
