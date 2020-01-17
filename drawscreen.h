#ifndef DRAWSCREEN_H
#define DRAWSCREEN_H
#include <QQuickPaintedItem>
#include <QPainter>
#include <QPainterPath>
#include <QPolygonF>

class DrawScreen : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(int widthPen READ widthPen WRITE setWidthPen NOTIFY widthPenChanged)
//    Q_PROPERTY(QList tower READ tower WRITE setTower NOTIFY towerChanged)

public:
    DrawScreen();

    void paint(QPainter *painter) override;

public:
    QColor color() const;
    int widthPen() const;
    void setColor(const QColor &color);
    void setWidthPen(const int &width);

Q_INVOKABLE void addToPainterPath(QPoint point,QString cmd);
signals:
    void colorChanged();
    void widthPenChanged();
private:
    QColor mColor;
    int mWidthPen;
    QPainterPath mPainterPath;

};

#endif // DRAWSCREEN_H
