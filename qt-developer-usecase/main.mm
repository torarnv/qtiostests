#include <QtGui/QGuiApplication>
#include <QtGui/QWindow>
#include <QtGui/QBackingStore>
#include <QtGui/QPainter>
#include <QtGui/QResizeEvent>

#include <QtGui/5.0.1/QtGui/qpa/qplatformnativeinterface.h>

#import <UIKit/UIKit.h>

class Window : public QWindow
{
public:
    Window()
        : QWindow()
        , m_backingStore(new QBackingStore(this))
    {
    }

    ~Window()
    {
        delete m_backingStore;
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

        QPainter devicePainter(device);
        
        QPixmap pixmap(500, 1300);
        pixmap.fill(Qt::transparent);
        pixmap.setDevicePixelRatio(devicePixelRatio());
        QPainter pixmapPainter(&pixmap);
        
        QPainter* painters[] = { &devicePainter, &pixmapPainter };
        for (int i = 0; i < 2; ++i) {
            QPainter *p = painters[i];
            
            p->setRenderHint(QPainter::Antialiasing, true);
            p->fillRect(0, 0, width(), height(), Qt::white);
            p->setPen(QPen(Qt::black, 3));
            p->drawRoundedRect(50, 50, 100, 100, 50, 50);

            p->setFont(QFont("Courier", 14));
            p->drawText(QPoint(50, 200), QLatin1String("Foo"));

            p->setFont(QFont("Courier", 48));
            p->drawText(QPoint(50, 300), QLatin1String("Foo"));
            
            p->save();
            p->scale(1.3, 1.3);
            p->rotate(5);
            p->drawText(QPoint(100, 400), QLatin1String("Foo"));
            p->restore();
        }
        
        pixmapPainter.end();
        devicePainter.drawPixmap(QPoint(300, 0), pixmap);
        
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
    
    QPlatformNativeInterface *native = QGuiApplication::platformNativeInterface();
    UIView *uiView = reinterpret_cast<UIView*>(native->nativeResourceForWindow("uiview", &window));
    
    NSString *labelText = @"Foo";

    CGRect labelFrame = CGRectMake(250, 550, 280, 50);
    UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
    myLabel.font = [UIFont fontWithName:@"Courier" size:14.0];
    [myLabel setText:labelText];
    [uiView addSubview: myLabel];

    CGRect labelFrame2 = CGRectMake(250, 650, 280, 100);
    UILabel *myLabel2 = [[UILabel alloc] initWithFrame:labelFrame2];
    myLabel2.font = [UIFont fontWithName:@"Courier" size:48.0];
    [myLabel2 setText:labelText];
    [uiView addSubview: myLabel2];
    
    return app.exec();
}