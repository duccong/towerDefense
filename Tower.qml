import QtQuick 2.0
import "logic.js" as MathFunctions
Item {
    property int iValues: 0
    property bool isAtt: false
    //    property bool attacking: false
    property var targetAttack: []
    id: _rootItem
    width: 10
    height: 10
    property int row: posOnBoard === undefined ? -1 : posOnBoard/20
    property int col: posOnBoard === undefined ? -1 : posOnBoard%20
    property var posOnBoard: undefined
    property var targetPos: undefined
    onIsAttChanged: {
        mouseArea.state = isAtt ? "ATTACK" : "READY"
        timerReload.stop()
    }

    onPosOnBoardChanged: {
        if (posOnBoard!== undefined && posOnBoard>0) {
            isAtt = false
        }
        //        timerReload.stop()
    }


    MouseArea {
        id: mouseArea
        width: 30
        height: 30
        //        anchors.fill: parent
        drag.target: _itemRect
        state: isAtt ? "ATTACK" : "READY"

        onStateChanged: {
//            console.log("onStateChanged" + state)
        }

        onReleased: {
            if (_itemRect.Drag.target !== null) {
                console.log("Droped");
                parent = _itemRect.Drag.target
                posOnBoard = parent.pos
                console.log("posOnBoard: " + posOnBoard)
            } else {
                console.log("Can'drop");
                parent = _rootItem
                posOnBoard = undefined;
            }

            //
        }
        Rectangle {
            id: _rectRange
            width: 200
            height: 200
            anchors.verticalCenter: _itemRect.verticalCenter
            anchors.horizontalCenter: _itemRect.horizontalCenter
            color: isAtt ? "RED" : "LIGHTGREEN"
            opacity: 0.3
            border.width: 1
            border.color: "BLACK"
            radius: 100
            visible: mouseArea.drag.active || mouseArea.parent !== _rootItem
        }

        Rectangle {
            id: _itemRect
            //            anchors.fill: parent
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "LIGHTBLUE"
            border.width: 1
            border.color: "BLACK"

            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: 15
            Drag.hotSpot.y: 15
            Drag.keys: ["A"]
            Text {
                id: _text
                text: iValues
                anchors.centerIn: parent
                font.pixelSize: 15
            }

            states: State {
                when: mouseArea.drag.active
                //                ParentChange { target: tile; parent: root }
                AnchorChanges { target: _itemRect; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
            }
        }

        Rectangle {
            id: bullet
            width: 10
            height: 10
            color: isAtt ? "red" : "green"
        }

        states: [
            State {
                name: "READY"
                PropertyChanges {
                    target: bullet
                    x:7
                    y:7
                }
            },
            State {
                name: "ATTACK"
                PropertyChanges {
                    target: bullet
                    x: targetPos !== undefined ? targetPos.x : 7
                    y: targetPos !== undefined ? targetPos.y : 7
                }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "ATTACK"
                SequentialAnimation {
                    NumberAnimation {
                        properties: "x,y";
                        duration: 100
                    }
                    ScriptAction {
                        script: {
                            mouseArea.state = "READY"
                            timerReload.start()
//                            console.log("targetAttack[0]:"+targetAttack[0] )
//                            console.log("objName:"+targetAttack[0].objectName )
                            if (targetAttack[0]!== undefined){
                                if (targetAttack[0] === null ){
                                    console.log("targetAttack[0]: NULL" )
                                } else {
                                    console.log("targetAttack[0]: NOT NULL" )
                                }

//                                console.log("targetAttack[0]:"+targetAttack[0] )
                                console.log("targetAttackLength:"+targetAttack.length )
                                console.log("objName:"+targetAttack[0].life )
                                if (targetAttack[0].life === 1) {
                                    targetAttack[0].onHited(1);
                                    // destroy target
                                    targetAttack.pop();
                                } else {
                                    targetAttack[0].onHited(1);
                                }


                            }
                        }
                    }
                }


            },
            Transition {
                from: "ATTACK"
                to: "READY"
                SequentialAnimation {
                    NumberAnimation {
                        properties: "x,y";
                        duration: 0
                    }
                }
            }
        ]
        Timer {
            property int index: 0
            id: timerReload
            interval: 1000 ; running: false; repeat: isAtt
            onTriggered: {
                console.log("timerReload - DONE")
                mouseArea.state = "ATTACK"
            }
        }
    }
    Timer {
        property int index: 0
        id: mainTime
        interval: 50 ; running: posOnBoard !== undefined; repeat: true
        onTriggered: {
//            if (!isAtt){
//                return
//            }

            if (targetAttack.length > 0){
                var towerX = _rootItem.col * 30 + 30/2 // board.sizeCell = 30
                var towerY = _rootItem.row * 30 + 30/2
                var _recX = targetAttack[0].x + 30/2 // target.size/2
                var _recY = targetAttack[0].y + 30/2

                var distance = MathFunctions.calDistance(towerX,towerY,_recX,_recY);

                if (distance <100 ){
                    _rootItem.targetPos = Qt.point(targetAttack[0].x - towerX + 30. , targetAttack[0].y -towerY + 30)
                    _rootItem.isAtt = true
                } else {
                    _rootItem.isAtt = false
                }
            } else {
                _rootItem.isAtt = false
                mouseArea.state = "READY"
            }
        }
    }
}
