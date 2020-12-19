#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "drawscreen.h"
#include <OpenGL/hellotriangle.h>
#include <QTimer>

HelloTriangle *_helloTriangle2;

void testFunction()
{
    qDebug() << "Test function";

    _helloTriangle2->hide();
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<DrawScreen>("DrawScreen", 1, 0, "DrawScreen");
    qmlRegisterType<HelloTriangle>("OpenGL", 1, 0, "HelloTriangle");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

//    QObject *rootObject = engine.rootObjects().first();
//    foreach (QObject *item, engine.rootObjects()) {
//        qDebug("\n- Name: %s",item->objectName().toStdString().data());
//    }
//    QObject *qmlObject = rootObject->findChild<QObject*>("mainqml");

//    HelloTriangle *helloTriangle = new HelloTriangle;
//    helloTriangle->resize(230,340);
//    helloTriangle->setParent(qobject_cast<QQuickWindow *>(rootObject));
//    helloTriangle->setX(200);
//    helloTriangle->show();

    /*HelloTriangle **/
//    _helloTriangle2 = new HelloTriangle;
//    _helloTriangle2->resize(230,340);
//    _helloTriangle2->setParent(qobject_cast<QQuickWindow *>(rootObject));
//    _helloTriangle2->setX(100);
//    _helloTriangle2->show();
//    _helloTriangle2->hide();

//    QTimer timer;
//    QObject::connect(&timer, &QTimer::timeout, testFunction);
//    timer.setSingleShot(true);
//    timer.start(5000);

    return app.exec();
}
