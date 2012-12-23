TEMPLATE = subdirs
CONFIG += ordered

SUBDIRS += test-cases

testgallery.file = test-gallery/test-gallery.pri
testgallery.makefile = Makefile
SUBDIRS += testgallery
