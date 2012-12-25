TEMPLATE = subdirs
SUBDIRS += basic

qt_source_tree = $$(QT_SOURCE_TREE)
isEmpty(qt_source_tree) {
    message(export QT_SOURCE_TREE to include Qt examples)
} else {
    SUBDIRS += wiggly
}