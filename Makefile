ASM=nasm

SRC_DIR=src
BUILD_DIR=build


run: $(BUILD_DIR)/main_floppy.img
	qemu-system-i386 -fda $(BUILD_DIR)/main_floppy.img


$(BUILD_DIR)/main_floppy.img:$(BUILD_DIR)/main.bin
	cp $< $@ 
	truncate -s 1440k $@


$(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
	$(ASM) $< -f bin -o $@



clean:
	rm -rf $(BUILD_DIR)/*.bin $(BUILD_DIR)/*.o $(BUILD_DIR)/*.img
