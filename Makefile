# 'make' builds everything
# 'make clean' deletes everything except source files and Makefile
# You need to set TARGET, MCU and SOURCES for your project.
# TARGET is the name of the executable file to be produced
# $(TARGET).elf $(TARGET).hex and $(TARGET).txt nad $(TARGET).map are all generated.
# The TXT file is used for BSL loading, the ELF can be used for JTAG use
#
TARGET     = fifocamtest
MCU        = msp430g2452
F_CPU      = 16000000L
# List all the source files here
# eg if you have a source file foo.c then list it here
SOURCES = main.c uart.c i2c.c ov7670.c tprintf.c utils.c
# Include are located in the Include directory
INSTALL_DIR=$(HOME)/ti/msp430_gcc

GCC_DIR =  $(INSTALL_DIR)/bin
SUPPORT_FILE_DIRECTORY = $(INSTALL_DIR)/include
INCLUDES = -I $(SUPPORT_FILE_DIRECTORY)

#INCLUDES = -IInclude
# Add or subtract whatever MSPGCC flags you want. There are plenty more
#######################################################################################
CFLAGS   = -mmcu=$(MCU) -DF_CPU=${F_CPU} -g -O0 -Wall -Wunused $(INCLUDES)
ASFLAGS  = -mmcu=$(MCU) -x assembler-with-cpp -Wa,-gstabs
LDFLAGS  = -mmcu=$(MCU) -L $(SUPPORT_FILE_DIRECTORY)
########################################################################################
CC       = msp430-elf-gcc
LD       = msp430-elf-ld
AR       = msp430-elf-ar
AS       = msp430-elf-gcc
GASP     = msp430-elf-gasp
NM       = msp430-elf-nm
OBJCOPY  = msp430-elf-objcopy
RANLIB   = msp430-elf-ranlib
STRIP    = msp430-elf-strip
SIZE     = msp430-elf-size
READELF  = msp430-elf-readelf
MAKETXT  = srec_cat
CP       = cp -p
RM       = rm -f
MV       = mv
########################################################################################
# the file which will include dependencies
DEPEND = $(SOURCES:.c=.d)
# all the object files
OBJECTS = $(SOURCES:.c=.o)
all: $(TARGET).elf $(TARGET).hex $(TARGET).txt
$(TARGET).elf: $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) $(LIBS) -o $@
	$(SIZE) $(TARGET).elf
# %.hex: %.elf
# 	$(OBJCOPY) -O ihex $< $@
# %.txt: %.hex
# 	$(MAKETXT) -O $@ -TITXT $< -I
%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<
# rule for making assembler source listing, to see the code
%.lst: %.c
	$(CC) -c $(CFLAGS) -Wa,-anlhd $< > $@
# include the dependencies unless we're going to clean, then forget about them.
ifneq ($(MAKECMDGOALS), clean)
-include $(DEPEND)
endif
# dependencies file
# includes also considered, since some of these are our own
# (otherwise use -MM instead of -M)
%.d: %.c
	$(CC) -M ${CFLAGS} $< >$@
.PHONY: clean
clean:
	-$(RM) $(OBJECTS)
	-$(RM) $(TARGET).*
	-$(RM) $(SOURCES:.c=.lst)
	-$(RM) $(DEPEND)
