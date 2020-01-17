import QtQuick 2.0

Item {
    id: _rootItem
    property int model: 400
//    property int cellSize: 30
    width: 50
    height: 50
    GridView {
        id: _grid
        anchors.fill: parent
        model: _rootItem.model
        cellHeight: 30
        cellWidth: 30
        interactive: false
        delegate: DropItem {
            width: 30
            height: 30
        }
    }
}
