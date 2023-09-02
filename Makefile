TARGET = johnny_dc.elf
OBJS =  main.o \
        utils.o \
        uncompress.o \
        resource.o \
        story.o \
        walk.o \
        calcpath.o \
        ads.o \
        ttm.o \
        island.o \
        graphics.o \
        sound.o \
        events.o \
        config.o \


CFLAGS = -std=c99

all: clean $(TARGET) 

include $(KOS_BASE)/Makefile.rules

clean:
	-rm -f $(TARGET) $(OBJS) romdisk.img 

$(TARGET): $(OBJS)
	kos-cc -o $(TARGET) $(OBJS) $(DATAOBJS) $(OBJEXTRA) -lSDL

run:
	$(KOS_LOADER) $(TARGET)

dist: $(TARGET)
	$(KOS_STRIP) $(TARGET)

cdi: all
	mkdcdisc -m -v 3 -N -d flat -e johnny_dc.elf -o johnny_dreamcastaway.cdi

test: cdi
	mv johnny_dreamcastaway.cdi ./testing/ && redream ./testing/johnny_dreamcastaway.cdi 



