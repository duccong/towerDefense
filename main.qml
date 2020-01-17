import QtQuick 2.9
import QtQuick.Window 2.2
import DrawScreen 1.0
import QtPositioning 5.0
import "logic.js" as MathFunctions
Window {
    id: _root
    visible: true
    width: 600
    height: 650
    title: qsTr("Hello World")
    property var startPoint : undefined
    property var endPoint : undefined
    property var path : []
    property var toPoint : undefined
    property int timeRunning: 30

    property var tower : []
    property var targetAttack : []

    DrawScreen {
        id: drawScreen
        width: 600
        height: 600
        color: "RED"
        widthPen: 5
        MouseArea {
            id: mouseArea

            property bool patched : false
            anchors.fill: parent
            //            hoverEnabled: true

            onPressed: {
                //                if (patched){
                patched = true;
                startPoint = Qt.point(mouseArea.mouseX,mouseArea.mouseY)
                console.log("START-POINT:" + startPoint)
                drawScreen.addToPainterPath(startPoint,"startPoint")
                target.stateTarget = "IDLE"
                target.life = 10;
                path = []
            }
            onReleased: {
                //                if (patched){
                endPoint = Qt.point(mouseArea.mouseX,mouseArea.mouseY)
                console.log("END-POINT:" + endPoint)
                drawScreen.addToPainterPath(endPoint,"endPoint")
                toPoint = path[1] !== undefined ? path[1] : Qt.point(0,0)

                target.stateTarget = "RUNNING"
                timeRun.start()

            }
            onPositionChanged: {
//                console.log("x:" + mouseArea.mouseX + " - y:" + mouseArea.mouseY)
                drawScreen.addToPainterPath(Qt.point(mouseArea.mouseX,mouseArea.mouseY),"to")
                path.push(Qt.point(mouseArea.mouseX,mouseArea.mouseY))
            }
        }
    }

    Board{
        property int sizeCell: 30
        objectName: "board"
        id: board
        width: 600
        height: 600
    }

    GridView {
        id: _gridTower
        anchors.top: board.bottom
        anchors.left: parent.left
        model: 3
        width: 90
        height: 30
        cellHeight: 30
        cellWidth: 30
        interactive: false
        delegate: Tower {
            id: _item
            width: 30
            height: 30
            iValues: modelData
            targetAttack: _root.targetAttack
            Component.onCompleted: {
                tower[index] = _gridTower.children[0].children[index];
            }
        }

    }

    Target {
        id: target
        objectName: "target"
        timeRunning: timeRunning
        size: size
        startPoint: _root.startPoint
        toPoint: _root.toPoint
        visible: false
        Component.onCompleted: {
            targetAttack[0] = target
        }
    }

    Timer {
        property int index: 0
        id: timeRun
        interval: timeRunning ; running: false; repeat: true
        onTriggered: {
            //                console.log("Path.length: " + path.length)
            if (target.life < 9) {
                console.log("toPoint: x: " + toPoint.x + " - y: "+toPoint.y)
                target.stateTarget = "IDLE"
                timeRun.stop()
                return
            }

            if (index < path.length){
                toPoint = path[index]
//                console.log("toPoint: x: " + toPoint.x + " - y: "+toPoint.y)
                index++
                target.stateTarget = "RUNNING"
                target.visible = true
            } else {
                index = 0;
                if ((toPoint.x < startPoint.x +5) && (toPoint.x > startPoint.x -5)
                        && (toPoint.y < startPoint.y +5) && (toPoint.y > startPoint.y-5)){
                    // repeat loop
                } else {
                    // stop
                    timeRun.stop()
                }
            }

        }
    }

}
