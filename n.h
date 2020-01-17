#ifndef MAINWINDOWN_H
#define MAINWINDOWN_H
#include <QQuickPaintedItem>


class MainWindown : public QQuickPaintedItem
{
    Q_OBJECT
public:
    MainWindown();
     void paint(QPainter *painter) override;
};

#endif // MAINWINDOWN_H
