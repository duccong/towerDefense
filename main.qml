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
//    property var dataTargetAttack : []
    //    TODO: Test
    //    Begin Test
    ListModel {
        id: lsTargetModel
//        ListElement { type: "1"; life :10; iPos: 0 }
//        ListElement { name: "2"; life :9; iPos: 15 }
    }
    //    End Test


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
                //                target.stateTarget = "IDLE"
                //                target.life = 10;
                path = []
            }
            onReleased: {
                //                if (patched){
                endPoint = Qt.point(mouseArea.mouseX,mouseArea.mouseY)
                console.log("END-POINT:" + endPoint)
                drawScreen.addToPainterPath(endPoint,"endPoint")
                toPoint = path[1] !== undefined ? path[1] : Qt.point(0,0)

                //                target.stateTarget = "RUNNING"
                //                timeRun.start()
                //                targetAttack.push(target)
                //                timeRun.index = 0

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


    Item {
        id: targetOnBoard
        anchors.fill: board
        Repeater {
            id: lsTarget
            model: lsTargetModel
            delegate: Target {
                id: targetInlist
                timeRunning: timeRunning
                size: size
                startPoint: _root.startPoint
                toPoint: _root.startPoint
                life: model.life
                posInPath: model.iPos
                name: model.type
                speed: model.speed === "" ? 1 : model.speed
                stateTarget:"IDLE"
                onStateChanged: {
                    if (state == "DEAD"){
                        // destroy target

//                        console.log("targetAttch: " + _root.targetAttack)
//                        targetAttack.splice(index,1);
                        console.log("onRemove: " + index)
                        showTargetAttack();
//                        console.log("onRemove: lsTargetModel: " + lsTargetModel.count)
                        lsTargetModel.remove(index);
                        showTargetAttack();


                    }
                }

                Component.onCompleted: {
                    console.log("onCompleted")
                    targetAttack.push(targetInlist)
//                    for (var i = 0 ; i <  targetAttack.length ; i++) {
//                        console.log("target: " + i + " speed: " +speed)
//                    }
                }
            }
        }

    }

     function showTargetAttack() {
         console.log("lsTargetModel: " +lsTargetModel.count)
        for (var i1 = 0 ; i1 < lsTargetModel.count ; i1++) {
            console.log("target: " + i1 + " speed: " +lsTargetModel.get(i1).speed)
        }
         console.log("showTargetAttack:" + targetAttack.length)
        for (var i = 0 ; i < targetAttack.length ; i++) {
            console.log("target: " + i + " speed: " +targetAttack[i].speed)
        }
    }


    Timer {
        //
        id: timeRun
        interval: 50 ; running: lsTargetModel.count > 0; repeat: true
        onTriggered: {
//            console.log("Path.length: " + path.length)
//            console.log("lsTargetModel.length: " + lsTargetModel.count)
            for (var i = 0 ; i < targetAttack.length ; i ++){

                var onTarget = targetAttack[i];
                //                onTarget.posInPath ++;
                var index = onTarget.posInPath;
                if (index === undefined) {
                    onTarget.posInPath = 0;
                    onTarget.toPoint = startPoint
                    continue
                }
//                console.log("target: " + i)
//                console.log("posInPath:" + index )
                if (index < path.length-1){
                    index = (index + onTarget.speed) > (path.length -1) ? path.length-1 : (index + onTarget.speed)
                    onTarget.toPoint = path[index]
                    //                    console.log("posInPath: " + index)
                    //                    console.log("target: " + i)
                    //                console.log("toPoint: x: " + toPoint.x + " - y: "+toPoint.y)
                    onTarget.posInPath = index;
                    onTarget.stateTarget = "RUNNING"
                    onTarget.visible = true
                } else {
                    //                    onTarget.posInPath = 0;
                    if ((onTarget.toPoint.x < startPoint.x +5) && (toPoint.x > startPoint.x -5)
                            && (onTarget.toPoint.y < startPoint.y +5) && (onTarget.toPoint.y > startPoint.y-5)){
                        // repeat loop
                        onTarget.posInPath =0;
                    } else {
                        // stop
//                                                timeRun.stop()
                    }
                }
            }

        }
    }

    Rectangle {
        width: 50
        height: 50
        anchors.top: board.bottom
        anchors.right: parent.right
        color: "RED"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("onClicked to Add target")
                if (path.length > 0) {
                    var speed = Math.round(Math.random()*10%4)+1;
//                    var speed = 1;
                   lsTargetModel.append({"type": lsTargetModel.count, "life" : speed, "iPos":0,"speed" : speed})
                } else {
                    console.log("Path for Target running not ready")
                }


//                timeRun.restart();
            }
        }
    }

}
