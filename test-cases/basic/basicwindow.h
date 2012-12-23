#ifndef BASICWINDOW_H
#define BASICWINDOW_H

#include <QtGui/QWindow>
#include <QtGui/QBackingStore>
#include <QtGui/QPainter>
#include <QtGui/QResizeEvent>

class BasicWindow : public QWindow
{
public:
    BasicWindow();

    void exposeEvent(QExposeEvent *);
    void resizeEvent(QResizeEvent *ev);
    void mousePressEvent(QMouseEvent *ev);

    void draw();
private:
    QBackingStore *m_backingStore;
};

#endif