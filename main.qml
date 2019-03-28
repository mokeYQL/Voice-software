import QtQuick 2.8
import QtQuick.Window 2.3
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.0

Window {
    id: root_
    visible: true
    width: 1000
    height: 500
//    title: qsTr("Hello World")

    Item {
        id: topPart_
        x:200
        y:0
        width: parent.width - 200
        height: 50

        Rectangle{
            width: 500
            TabBar{
                id: tabBar_
                anchors.fill: parent
                currentIndex: showSwipView_.currentIndex
                property int indexFlag: 0
                TabButton{
                    id: lineButton_
                    text: qsTr("线路管理")

                    onClicked: {
                        showSwipView_.currentIndex = 0
                    }
                }
                TabButton{
                    id: stationButton_
                    text: qsTr("场站管理")

                    onClicked: {
                        showSwipView_.currentIndex = 1
                    }
                }
                TabButton{
                    id: broadcastButton_
                    text: qsTr("播报管理")

                    onClicked: {
                        showSwipView_.currentIndex = 2
                        tabBar_.indexFlag = 2
                    }
                }
                TabButton{
                    id: voiceButton_
                    text: qsTr("MP3管理")

                    onClicked: {
                        showSwipView_.currentIndex = 3
                    }
                }
                TabButton{
                    id: perSetButton_
                    width: 100
                    text: qsTr("预置")

                    onClicked: {
                        showSwipView_.currentIndex = 4
                    }
                }
                onCurrentIndexChanged: {
                    if(tabBar_.indexFlag === 2){
                        broadPage_.saveMessage()
                        tabBar_.indexFlag = 0
                    }
                }
            }
        }

        Button{
            id: appQuit_
            x: 770
            width: 30
            height: 30

            onClicked: {
                linePage_.setStation()
                broadPage_.saveMessage()
//                Qt.quit()
            }
        }

    }// topPart_

    SwipeView{
        id: showSwipView_
        x: 0
        y: 50
        width: parent.width
        height: 450
        currentIndex: tabBar_.currentIndex

        LinePage{
            id: linePage_
        }

        StationPage{
            id: stationPage_
        }

        BroadPage{
            id: broadPage_
        }

        MP3Page{
            id: mp3Page_
        }
        PerPage{
            id: perPage_
        }

    }

}
