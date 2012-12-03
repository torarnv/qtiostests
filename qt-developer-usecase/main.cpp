#include <QtGui/QGuiApplication>
#include <QtGui/QWindow>
#include <QtGui/QBackingStore>
#include <QtGui/QPainter>

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
        m_backingStore->beginPaint(QRect(QPoint(0, 0), size()));
        QPaintDevice *device = m_backingStore->paintDevice();

        {
            QPainter painter(device);
            painter.fillRect(0, 0, width(), height(), Qt::yellow);
        }

        m_backingStore->endPaint();
        m_backingStore->flush(QRect(QPoint(0, 0), size()));
    }

private:
    QBackingStore *m_backingStore;
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Window window;
    window.showFullScreen();

    return app.exec();
}
