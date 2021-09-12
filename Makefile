ifeq ($(ARCH), arm)
    TARGET=$(ARCH)-xxx-eabi
else ifeq ($(ARCH), aarch64)
    TARGET=$(ARCH)-xxx-elf
endif

hahaha:
	./build.sh $(TARGET)

.PHONY : clean
clean:
	rm -rf out/
