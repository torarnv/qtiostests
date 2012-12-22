TARGET = TestGallery

OBJECTIVE_SOURCES += $$files(*.m) $$files(*.mm)

CONFIG += no_main_wrapper
QMAKE_IOS_TARGETED_DEVICE_FAMILY = 2 # iPad

LIBS += -framework UIKit

nibs.files = $$files(*.xib)
QMAKE_BUNDLE_DATA += nibs
