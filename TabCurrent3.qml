import QtQuick 2.8
import QtQuick.Window 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 2.0 as Con2
import QtQuick.LocalStorage 2.0
import QtQuick.Dialogs 1.1

Tab{
    anchors.fill: parent

    signal saveSignal

    Component.onCompleted: {
        var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
        try{
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS Ta3(
                              tabNum INTEGER,
                              checked Boolean,
                              content TEXT,
                              type TEXT
                              )')
            })
        }
        catch(err){
            console.log("error create table in database Ta3"+err)
        }
    }

    function saveM(){
        console.log("__tab3__func__saveM__")
        saveSignal()
    }

    Item {
        id: showPart_
        anchors.fill: parent
        property int tabFlag: 0

        Component.onCompleted: {
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    var results = tx.executeSql('SELECT * FROM Ta3 WHERE tabNum = ?',[0])
                    for(var i=0;i<results.rows.length;i++){
                        insideModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta3 WHERE tabNum = ?',[1])
                    for(i=0;i<results.rows.length;i++){
                        frontModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta3 WHERE tabNum = ?',[2])
                    for(i=0;i<results.rows.length;i++){
                        midModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta3 WHERE tabNum = ?',[3])
                    for(i=0;i<results.rows.length;i++){
                        tailModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type
                                            })
                    }


                })
            }
            catch(err){
                console.log("err init model from Ta3"+err)
            }
        }

        Connections{
            target: parent
            onSaveSignal:showPart_.saveData()
        }

        function saveData(){
            console.log("__tab3__func__saveData__")
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    tx.executeSql('DELETE FROM Ta3')
                    for(var i=0;i<insideModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta3 VALUES(?,?,?,?)',
                                      [insideModel_.get(i).tabNum,
                                      insideModel_.get(i).checked,
                                      insideModel_.get(i).content,
                                      insideModel_.get(i).type])
                    }

                    for(i=0;i<frontModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta3 VALUES(?,?,?,?)',
                                      [frontModel_.get(i).tabNum,
                                      frontModel_.get(i).checked,
                                      frontModel_.get(i).content,
                                      frontModel_.get(i).type])
                    }

                    for(i=0;i<midModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta3 VALUES(?,?,?,?)',
                                      [midModel_.get(i).tabNum,
                                      midModel_.get(i).checked,
                                      midModel_.get(i).content,
                                      midModel_.get(i).type])
                    }

                    for(i=0;i<tailModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta3 VALUES(?,?,?,?)',
                                      [tailModel_.get(i).tabNum,
                                      tailModel_.get(i).checked,
                                      tailModel_.get(i).content,
                                      tailModel_.get(i).type])
                    }
                })
            }
            catch(err){
                console.log("error save data to Ta3"+err)
            }
        }

        PopTemplate{
            id: pop_contentAdd_
            x: (parent.width - width)/2
            y: (parent.height - height)/2
            width: 600
            height: 450

            ListModel{id: pop_model_}

            Rectangle{
                id: popTopPart_
                width: parent.width
                height: 40
                color: "black"
                Text {
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 30
                    text: qsTr("LED显示项")
                }
            }

            Item {
                x: 1
                y: 45
                width: parent.width - 2
                height: 335

                Rectangle{
                    width: parent.width
                    height: 30

                    Rectangle{
                        width: 40
                        height: 30
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("类型")
                        }
                    }
                    ComboBox{
                        id: comboBox_type_
                        x: 50
                        width: 200
                        height: 30
                        model: ["开机显示","首站出站","普通进站","普通出站","末站进站",
                            "KEY0","KEY1","KEY2","KEY3","KEY4","KEY5","KEY6","KEY7","KEY8","KEY9",
                            "转弯显示","上坡显示","下坡显示","上桥显示","下桥显示"]
                    }
                }//类型

                Rectangle{
                    y:35
                    width: parent.width
                    height: 100

                    Rectangle{
                        width: 80
                        height: 30
                        Text {
                            font.bold: true
                            anchors.centerIn: parent
                            text: qsTr("请选择标签")
                        }
                    }
                    Rectangle{
                        y: 35
                        width: parent.width
                        height: 65

                        Grid{
                            anchors.centerIn: parent
                            columns: 6
                            spacing: 8

                            Button{
                                implicitWidth: 80
                                implicitHeight: 30
                                text: qsTr("普通文本")

                                onClicked: {
                                    console.log("普通文本")
                                    pop_model_.append({"pop_content":"普通文本"})
                                }
                            }
                            Button{
                                implicitWidth: 80
                                implicitHeight: 30
                                text: qsTr("[本站点]")

                                onClicked: {
                                    console.log("[本站点]")
                                    pop_model_.append({"pop_content":"[本站点]"})
                                }
                            }
                            Button{
                                implicitWidth: 80
                                implicitHeight: 30
                                text: qsTr("[下一站]")

                                onClicked: {
                                    console.log("[下一站]")
                                    pop_model_.append({"pop_content":"[下一站]"})
                                }
                            }
                            Button{
                                implicitWidth: 80
                                implicitHeight: 30
                                text: qsTr("[起始站]")

                                onClicked: {
                                    console.log("[起始站]")
                                    pop_model_.append({"pop_content":"[起始站]"})
                                }
                            }
                            Button{
                                implicitWidth: 80
                                implicitHeight: 30
                                text: qsTr("[终点站]")

                                onClicked: {
                                    console.log("[终点站]")
                                    pop_model_.append({"pop_content":"[终点站]"})
                                }
                            }
                            Button{
                                implicitWidth: 80
                                implicitHeight: 30
                                text: qsTr("[线路名]")

                                onClicked: {
                                    console.log("[线路名]")
                                    pop_model_.append({"pop_content":"[线路名]"})
                                }
                            }

                            Button{
                                implicitWidth: 80
                                implicitHeight: 30
                                text: qsTr("→")

                                onClicked: {
                                    console.log("→")
                                    pop_model_.append({"pop_content":"→"})
                                }
                            }
                        }
                    }


                }//标签

                Item {
                    y: 140
                    width: parent.width
                    height: 220

                    TableView{
                        id: pop_tableView_
                        anchors.fill: parent
                        model: pop_model_

                        TableViewColumn{ id: pop_contentColumn_; role: "pop_content"; title: "内容"; width: 200}
                        TableViewColumn{ id: pop_placeColumn_; role: "pop_place"; title: "显示"; width: 100}
                        TableViewColumn{ id: pop_delColumn_; role: "pop_del"; width: 80}

                        itemDelegate: Item {
                            TextInput{
                                id: content_input_
                                anchors.fill: parent
                                text: styleData.value
                                visible: pop_tableView_.getColumn(styleData.column)===pop_contentColumn_?true:false
                                onTextChanged: {
                                    pop_model_.set(styleData.row,{"pop_content":content_input_.text})
                                }
                            }
                            ComboBox{
                                anchors.fill: parent
                                visible: pop_tableView_.getColumn(styleData.column)===pop_placeColumn_?true:false
                                model: ["默认","居中","滚动"]
                                onCurrentTextChanged: {
                                    pop_model_.set(styleData.row,{"pop_place":currentText})
                                }
                            }
                            Button{
                                anchors.centerIn: parent
                                implicitWidth: 60
                                implicitHeight: 15
                                visible: pop_tableView_.getColumn(styleData.column)===pop_delColumn_?true:false
                                text: qsTr("删除")

                                onClicked: {
//                                    console.log(pop_model_.get(styleData.row).pop_content)
//                                    console.log(pop_model_.get(styleData.row).pop_place)
                                    pop_model_.remove(styleData.row)
                                }
                            }
                        }
                    }

                }
            }//item

            Rectangle{
                x: 1
                y: 410
                width: parent.width - 2
                height: 39

                Button{
                    x: 400
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("确定")

                    onClicked: {
                        var contentText = ""
                        if(showPart_.tabFlag===0){
                            for(var i=0;i<pop_model_.count;i++){
                                if(pop_model_.get(i).pop_place==="默认"){
                                    contentText += pop_model_.get(i).pop_content
                                }else if(pop_model_.get(i).pop_place==="居中"){
                                    contentText += "{"+pop_model_.get(i).pop_content+"}"
                                }else if(pop_model_.get(i).pop_place==="滚动"){
                                    contentText += "<"+pop_model_.get(i).pop_content+">"
                                }
                            }
//                            console.log(contentText)

                            insideModel_.append({"checked":false,"type":comboBox_type_.currentText,"content":contentText,"tabNum":showPart_.tabFlag})
                        }else if(showPart_.tabFlag===1){
                            for(i=0;i<pop_model_.count;i++){
                                if(pop_model_.get(i).pop_place==="默认"){
                                    contentText += pop_model_.get(i).pop_content
                                }else if(pop_model_.get(i).pop_place==="居中"){
                                    contentText += "{"+pop_model_.get(i).pop_content+"}"
                                }else if(pop_model_.get(i).pop_place==="滚动"){
                                    contentText += "<"+pop_model_.get(i).pop_content+">"
                                }
                            }
                            frontModel_.append({"checked":false,"type":comboBox_type_.currentText,"content":contentText,"tabNum":showPart_.tabFlag})
                        }else if(showPart_.tabFlag===2){
                            for(i=0;i<pop_model_.count;i++){
                                if(pop_model_.get(i).pop_place==="默认"){
                                    contentText += pop_model_.get(i).pop_content
                                }else if(pop_model_.get(i).pop_place==="居中"){
                                    contentText += "{"+pop_model_.get(i).pop_content+"}"
                                }else if(pop_model_.get(i).pop_place==="滚动"){
                                    contentText += "<"+pop_model_.get(i).pop_content+">"
                                }
                            }
                            midModel_.append({"checked":false,"type":comboBox_type_.currentText,"content":contentText,"tabNum":showPart_.tabFlag})
                        }else if(showPart_.tabFlag===3){
                            for(i=0;i<pop_model_.count;i++){
                                if(pop_model_.get(i).pop_place==="默认"){
                                    contentText += pop_model_.get(i).pop_content
                                }else if(pop_model_.get(i).pop_place==="居中"){
                                    contentText += "{"+pop_model_.get(i).pop_content+"}"
                                }else if(pop_model_.get(i).pop_place==="滚动"){
                                    contentText += "<"+pop_model_.get(i).pop_content+">"
                                }
                            }
                            tailModel_.append({"checked":false,"type":comboBox_type_.currentText,"content":contentText,"tabNum":showPart_.tabFlag})
                        }
                        pop_contentAdd_.close()
                    }
                }
                Button{
                    x: 500
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("取消")

                    onClicked: {
                        pop_contentAdd_.close()
                    }
                }
            }

            MouseArea{
                anchors.fill: popTopPart_
                acceptedButtons: Qt.LeftButton
                property point clickPos: "0,0"
                onPressed: {
                    clickPos = Qt.point(mouse.x,mouse.y)
                }
                onPositionChanged: {
                    var delta = Qt.point(mouse.x-clickPos.x,mouse.y-clickPos.y)
                    pop_contentAdd_.x = pop_contentAdd_.x+delta.x
                    pop_contentAdd_.y = pop_contentAdd_.y+delta.y
                }
            }

            onOpened: {
                pop_model_.clear()
            }
            onClosed: {
                pop_model_.clear()
            }
        }

        //model 车内 前排 腰牌 尾牌
        ListModel{id: insideModel_}
        ListModel{id: frontModel_}
        ListModel{id: midModel_}
        ListModel{id: tailModel_}

        Rectangle{
            width: parent.width
            height: 40

            Con2.TabBar{
                width: 500
                spacing: 10

                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("车内")

                    onClicked: {
                        showPart_.tabFlag = 0
                        tableView_.model = insideModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("前排")

                    onClicked: {
                        showPart_.tabFlag = 1
                        tableView_.model = frontModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("腰牌")

                    onClicked: {
                        showPart_.tabFlag = 2
                        tableView_.model = midModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("尾牌")

                    onClicked: {
                        showPart_.tabFlag = 3
                        tableView_.model = tailModel_
                    }
                }
            }
        }//车内 前排 腰牌 尾牌 按钮

        Rectangle{
            y: 40
            width: parent.width
            height: 40

            Rectangle{
                width: 40
                height: 30
                Text {
                    anchors.centerIn: parent
                    text: qsTr("LED协议")
                }
            }
            ComboBox{
                id: comboBox_Agreement_
                x: 50
                width: 100
                height: 30
                model: ["海康协议","部标协议"]

                onCurrentTextChanged: {
//                    get_cpp_.agreementChanged(currentText)
                    GetM.setAgreement(currentText)
                }
            }
            Rectangle{
                x: 180
                width: 40
                height: 30
                Text {
                    anchors.centerIn: parent
                    text: qsTr("LED串口")
                }
            }
            ComboBox{
                id: comboBox_SerialPort_
                x: 230
                width: 100
                height: 30
                model: ["232-1","232-2","232-3","485-1","485-2"]

                onCurrentTextChanged: {
//                    get_cpp_.serialPortChanged(currentText)
                    GetM.setSerialPort(currentText)
                }
            }
        }//LED协议 LED串口

        Rectangle{
            y: 80
            width: parent.width
            height: 40

            RowLayout{
                width: 200
                height: 30
                spacing: 10

                Button{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("添加")

                    onClicked: {
                        pop_contentAdd_.open()
                    }
                }
                Button{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("删除")

                    onClicked: {
                        if(showPart_.tabFlag===0){
                            for(var i=0;i<insideModel_.count;i++){
                                if(insideModel_.get(i).checked){
                                    insideModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag===1){
                            for(i=0;i<frontModel_.count;i++){
                                if(frontModel_.get(i).checked){
                                    frontModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag===2){
                            for(i=0;i<midModel_.count;i++){
                                if(midModel_.get(i).checked){
                                    midModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag===3){
                            for(i=0;i<tailModel_.count;i++){
                                if(tailModel_.get(i).checked){
                                    tailModel_.remove(i)
                                    i--
                                }
                            }
                        }
                    }
                }
            }
        }//添加/删除 按钮

        Item {
            y: 120
            width: parent.width
            height: parent.height - 120

            TableView{
                id: tableView_
                anchors.fill: parent
                model: insideModel_

                TableViewColumn{ id: checkedColumn_; role: "checked"; title: "选择"; width: 80}
                TableViewColumn{ id: typeColumn_; role: "type" ; title: "类型"; width: 80}
                TableViewColumn{ id: contentColumn_; role: "content"; title: "内容"; width: 200}
//                TableViewColumn{ id: numColumn_; role: "tabNum"; title: "num"; width: 80}

                itemDelegate: Item {
                    CheckBox{
                        anchors.centerIn: parent
                        checked: styleData.value
                        visible: tableView_.getColumn(styleData.column)===checkedColumn_?true:false
                    }
                    Text {
                        anchors.left: parent.left
                        text: styleData.value
                        visible: tableView_.getColumn(styleData.column)===typeColumn_?true:false
                    }
                    Text {
                        anchors.left: parent.left
                        text: styleData.value
                        visible: tableView_.getColumn(styleData.column)===contentColumn_?true:false
                        elide: Text.ElideMiddle
                    }
//                    Text {
//                        anchors.left: parent.left
//                        text: styleData.value
//                        visible: tableView_.getColumn(styleData.column)===numColumn_?true:false
//                    }
                }

                onClicked: {
                    if(showPart_.tabFlag===0){
                        insideModel_.set(currentRow,{"checked":!insideModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag===1){
                        frontModel_.set(currentRow,{"checked":!frontModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag===2){
                        midModel_.set(currentRow,{"checked":!midModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag===3){
                        tailModel_.set(currentRow,{"checked":!tailModel_.get(currentRow).checked})
                    }
                }
                onDoubleClicked: {
//                    pop_contentAdd_.open()
                }
            }
        }//tableView_

    }
}
