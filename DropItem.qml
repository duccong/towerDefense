import QtQuick 2.0

DropArea {
    property var pos: index
    width: 30
    height: 30
    id: dragTarget
    objectName: "DropItem"
    keys:["A"]
    Rectangle {
        id: _rect
        width: 30
        height: 30
        border.width: 1
        border.color: "BLACK"
        opacity: 0.1
        color: "LIGHTGREEN"
        states: [
            State {
                when: dragTarget.containsDrag
                PropertyChanges {
                    target: _rect
                    color:"GRAY"
                }
            }
        ]
    }
}
