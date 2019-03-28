import QtQuick 2.8
import QtQuick.Window 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.LocalStorage 2.0
import QtQuick.Dialogs 1.1

Item {
    function saveMessage(){
        tab0_.saveM()
        tab1_.saveM()
        tab2_.saveM()
        tab3_.saveM()
    }

    Rectangle{
        width: 100
        height: parent.height

        Component.onCompleted: {
            tabView_.currentIndex = 1
            tabView_.currentIndex = 2
            tabView_.currentIndex = 3
            tabView_.currentIndex = 0
        }

        ColumnLayout{
            spacing: 10
            Button{
                implicitWidth: 80
                implicitHeight: 80
                text: qsTr("通用播报")

                onClicked: {
                    tabView_.currentIndex = 0
                }
            }
            Button{
                implicitWidth: 80
                implicitHeight: 80
                text: qsTr("安全提示")

                onClicked: {
                    tabView_.currentIndex = 1
                }
            }
            Button{
                implicitWidth: 80
                implicitHeight: 80
                text: qsTr("按键提示")

                onClicked: {
                    tabView_.currentIndex = 2
                }
            }
            Button{
                implicitWidth: 80
                implicitHeight: 80
                text: qsTr("LED显示")

                onClicked: {
                    tabView_.currentIndex = 3
                }
            }
        }
    }

    Item{
        x: 100
        width: parent.width - 100
        height: parent.height

        TabView{
            id: tabView_
            anchors.fill: parent
            tabsVisible: false

            TabCurrent0{
                id: tab0_
            }

            TabCurrent1{
                id: tab1_
            }

            TabCurrent2{
                id: tab2_
            }

            TabCurrent3{
                id: tab3_
            }

        }//tabView_
    }
}
