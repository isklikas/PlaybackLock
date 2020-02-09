INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PlaybackLock

PlaybackLock_FILES = Tweak.x
PlaybackLock_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
