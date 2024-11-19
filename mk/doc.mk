# doc
LOGO = doc/logo.png
.PHONY: doxy
doxy: .doxygen doc/DoxygenLayout.xml $(LOGO)
	rm -rf doc/html ; doxygen $< 1>/dev/null

.PHONY: doc
doc: \
	doc/STM32/um1718-stm32cubemx-for-stm32-configuration-and-initialization-c-code-generation-stmicroelectronics.pdf \
	doc/STM32/pm0214-stm32-cortexm4-mcus-and-mpus-programming-manual-stmicroelectronics.pdf \
	doc/STM32/stm32f405rg.pdf

STM = https://www.st.com/resource/en

doc/STM32/um1718-stm32cubemx-for-stm32-configuration-and-initialization-c-code-generation-stmicroelectronics.pdf:
	$(CURL) $@ $(STM)/user_manual/um1718-stm32cubemx-for-stm32-configuration-and-initialization-c-code-generation-stmicroelectronics.pdf

doc/STM32/pm0214-stm32-cortexm4-mcus-and-mpus-programming-manual-stmicroelectronics.pdf:
	$(CURL) $@ $(STM)/programming_manual/pm0214-stm32-cortexm4-mcus-and-mpus-programming-manual-stmicroelectronics.pdf

doc/STM32/stm32f405rg.pdf:
	$(CURL) $@ $(STM)/datasheet/stm32f405rg.pdf
