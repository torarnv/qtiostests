# Binding layer between make and Xcode

TEMPLATE = aux

qmake_all.commands = $(QMAKE) $$PWD/test-gallery.pro
QMAKE_EXTRA_TARGETS += qmake_all

xcodebuild.commands = xcodebuild
xcodebuild.depends = qmake_all
QMAKE_EXTRA_TARGETS += xcodebuild

first.depends += xcodebuild
QMAKE_EXTRA_TARGETS += first