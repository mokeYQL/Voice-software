import QtQuick 2.8
import QtQuick.Window 2.3
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.0

Popup{
    width: 150
    height: 100
    padding: 0
    closePolicy: Popup.CloseOnEscape|Popup.CloseOnPressOutside

    Label{
        anchors.centerIn: parent
        text: qsTr("ID重复")
    }
}
