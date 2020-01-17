#include "drawscreen.h"

DrawScreen::DrawScreen()
{

}

void DrawScreen::paint(QPainter *painter)
{
//    painter->fillRect(0, 0, width(), height(), mColor);
    painter->setPen(QPen(mColor,mWidthPen, Qt::SolidLine, Qt::RoundCap, Qt::RoundJoin));

    if (mPainterPath.length()>0){
        painter->drawPath(mPainterPath);
    }

}

QColor DrawScreen::color() const
{
    return mColor;
}

int DrawScreen::widthPen() const
{
    return mWidthPen;
}
void DrawScreen::setColor(const QColor &color) {
    if (color == mColor)
        return;

    mColor = color;
//    update();
    emit colorChanged();
}

void DrawScreen::setWidthPen(const int &width)
{
    if (mWidthPen == width){
        return;
    }
    mWidthPen = width;
    emit widthPenChanged();
}

void DrawScreen::addToPainterPath(QPoint point,QString cmd)
{
    if (cmd == "startPoint"){
        mPainterPath = QPainterPath();
        mPainterPath.moveTo(point);

    } else if (cmd == "to"){
        mPainterPath.lineTo(point);
    } else if (cmd == "endPoint"){
        mPainterPath.lineTo(point);
//        mPainterPath.moveTo(point);
    }
    update();
//    mPainterPath
}
