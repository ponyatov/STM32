HW = STM32L496G-DISCO

.PHONY: disco
disco:
	rm -rf $(TMP)/$(HW)
	cmake -S $(CWD)/cubemx/$(HW) -B $(TMP)/$(HW)
