qt_source_tree = $$(QT_SOURCE_TREE)
example_dir = $${qt_source_tree}/qtbase/examples/widgets/widgets/wiggly

VPATH += $$example_dir
include($$example_dir/wiggly.pro)

TEMPLATE = lib
CONFIG += static
SOURCES -= main.cpp

for(header, HEADERS) {
    system(ln -sf $$example_dir/$$header)
}