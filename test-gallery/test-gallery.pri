# Binding layer between make and Xcode

TEMPLATE = aux

generate_xcode_project.commands = $(QMAKE) $$PWD/test-gallery.pro
QMAKE_EXTRA_TARGETS += generate_xcode_project

qmake.depends += generate_xcode_project
QMAKE_EXTRA_TARGETS += qmake

qmake_all.depends += generate_xcode_project
QMAKE_EXTRA_TARGETS += qmake_all

xcodebuild.commands = xcodebuild
xcodebuild.depends = qmake_all
QMAKE_EXTRA_TARGETS += xcodebuild

first.depends += xcodebuild
QMAKE_EXTRA_TARGETS += first