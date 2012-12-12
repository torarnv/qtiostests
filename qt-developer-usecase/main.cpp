#include <QtGui/QGuiApplication>
#include <QtGui/QWindow>
#include <QtGui/QBackingStore>
#include <QtGui/QPainter>
#include <QtGui/QResizeEvent>

class Window : public QWindow
{
public:
    Window()
        : QWindow()
        , m_backingStore(new QBackingStore(this))
    {
    }

    void exposeEvent(QExposeEvent *)
    {
        if (isExposed())
            draw();
    }

    void resizeEvent(QResizeEvent *ev)
    {
        m_backingStore->resize(ev->size());

        if (isExposed())
            draw();
    }

    void draw()
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

    void mousePressEvent(QMouseEvent *ev)
    {
        ev->ignore();
    }

private:
    QBackingStore *m_backingStore;
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Window window;
    window.show();

    return app.exec();
}
