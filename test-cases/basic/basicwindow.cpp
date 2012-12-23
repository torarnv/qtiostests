#include "basicwindow.h"

BasicWindow::BasicWindow()
    : QWindow()
    , m_backingStore(new QBackingStore(this))
{
}

void BasicWindow::exposeEvent(QExposeEvent *)
{
    if (isExposed())
        draw();
}

void BasicWindow::resizeEvent(QResizeEvent *ev)
{
    m_backingStore->resize(ev->size());

    if (isExposed())
        draw();
}

void BasicWindow::draw()
{
    m_backingStore->beginPaint(QRect(QPoint(0, 0), size()));
    QPaintDevice *device = m_backingStore->paintDevice();
    {
        QPainter painter(device);
        painter.fillRect(0, 0, width(), height(), Qt::yellow);
        painter.setPen(QPen(Qt::green, 3));
        painter.drawLine(0, 0, width(), height());
    }
    m_backingStore->endPaint();
    m_backingStore->flush(QRect(QPoint(0, 0), size()));
}

void BasicWindow::mousePressEvent(QMouseEvent *ev)
{
    ev->ignore();
}
