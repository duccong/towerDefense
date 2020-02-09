import QtQuick 2.0
//test
Item {
 /*   Rectangle {
        width: 75; height: 75
        id: button
        state: "RELEASED"

        MouseArea {
            anchors.fill: parent
            onPressed: button.state = "PRESSED"
            onReleased: button.state = "RELEASED"
        }

        states: [
            State {
                name: "PRESSED"
                PropertyChanges { target: button; color: "lightblue"}
            },
            State {
                name: "RELEASED"
                PropertyChanges { target: button; color: "lightsteelblue"}
            }
        ]

        transitions: [
            Transition {
                from: "PRESSED"
                to: "RELEASED"
                ColorAnimation { target: button; duration: 100}
            },
            Transition {
                from: "RELEASED"
                to: "PRESSED"
                ColorAnimation { target: button; duration: 100}
            }
        ]

        Timer {
            property int index: 0
            id: timeRun
            interval: timeRunning ; running: false; repeat: true
            onTriggered: {
                //                console.log("Path.length: " + path.length)
                if (index < path.length){
                    toPoint = path[index]
                    console.log("toPoint: x: " + toPoint.x + " - y: "+toPoint.y)
                    index++
                    _rec.state = "RUNNING"
                } else {
                    index = 0;
                    if ((toPoint.x < startPoint.x +5) && (toPoint.x > startPoint.x -5)
                            && (toPoint.y < startPoint.y +5) && (toPoint.y > startPoint.y-5)){
                        // repeat loop
                    } else {
                        // stop
//                        timeRun.stop()
                    }
                }

            }
        }
    }*/
}
