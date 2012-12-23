TARGET = TestGallery

OBJECTIVE_SOURCES += $$files(*.m) $$files(*.mm)
HEADERS += $$files(*.h)

CONFIG += no_main_wrapper
QMAKE_IOS_TARGETED_DEVICE_FAMILY = 2 # iPad

LIBS += -framework UIKit

nibs.files = $$PWD/MasterViewController.xib
QMAKE_BUNDLE_DATA += nibs

testcases = $$fromfile($$PWD/../test-cases/test-cases.pro, SUBDIRS)
for(testcase, testcases): \
    LIBS += -L../test-cases/$$testcase -l$$testcase
