import QtQuick 2.0



Rectangle {
    id: _rec
    property int size: 30
    property var startPoint: undefined
    property int timeRunning: 30
    property int life: 10
    property var toPoint: undefined
    property string stateTarget: "IDLE"
    //    x: _rec.x
    //    y: _rec.y
    onToPointChanged: {
//        console.log("Target::onToPointChanged" + toPoint.x + ","+toPoint.y)
    }
    onStateTargetChanged: {
        console.log("Target::onStateTargetChanged" + stateTarget)
    }

//    property int size: 40

    x: startPoint == undefined ? 0-size/2 : startPoint.x-size/2
    y: startPoint == undefined ? 0-size/2 : startPoint.y-size/2
    width: 30
    height: 30
    border.width: 2
    border.color: "BLACK"
    radius: size/2
    color: "GREEN"
    state: stateTarget
    states: [
        State {
            name: "IDLE"
            PropertyChanges {
                target: _rec;
                color: "RED"
                visible: false
                //                    x: startPoint == undefined ? 0 : startPoint.x
                //                    y: startPoint == undefined ? 0 : startPoint.y
            }
        },
        State {
            name: "RUNNING"
            PropertyChanges {
                target: _rec;
                color: "GREEN" ;
                x: toPoint == undefined ? 0-size/2 : toPoint.x-size/2 ;
                y: toPoint == undefined ? 0-size/2 : toPoint.y-size/2 ;
                visible: true
            }

        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "RUNNING"
            SequentialAnimation {
                ParallelAnimation {
                    ColorAnimation { target: _rec; duration: timeRunning}
                    NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: timeRunning}

                }
            }


        }
    ]

    Text {
        id: _text
        text: life
        width: 30
        height: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize:20
        color: "WHITE"
    }

    function onHited(i){
        console.log("onHited")
        life--;
        if (life < 1) {
            console.log("onDestroyed")
//            _rec.visible = false
//            console.log("nowState:"+_rec.stateTarget)
            _rec.stateTarget = "IDLE";
//            console.log("ToState:"+_rec.stateTarget)

//            _rec.destroy();
        }
    }

}



