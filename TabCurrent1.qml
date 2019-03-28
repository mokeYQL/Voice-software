import QtQuick 2.8
import QtQuick.Window 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls 2.0 as Con2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.LocalStorage 2.0
import QtQuick.Dialogs 1.1

Tab{
    anchors.fill: parent

    signal saveSignal

    Component.onCompleted: {
        var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
        try{
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS Ta1(
                              tabNum INTEGER,
                              checked Boolean,
                              content TEXT,
                              type TEXT,
                              speaker TEXT
                              )')
            })
        }
        catch(err){
            console.log("error create table in database Ta1"+err)
        }
    }

    function saveM(){
        console.log("__tab1__func__saveM__")
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
                    var results = tx.executeSql('SELECT * FROM Ta1 WHERE tabNum = ?',[0])
                    for(var i=0;i<results.rows.length;i++){
                        turnModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta1 WHERE tabNum = ?',[1])
                    for(i=0;i<results.rows.length;i++){
                        uphillModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta1 WHERE tabNum = ?',[2])
                    for(i=0;i<results.rows.length;i++){
                        downhillModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta1 WHERE tabNum = ?',[3])
                    for(i=0;i<results.rows.length;i++){
                        speedModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta1 WHERE tabNum = ?',[4])
                    for(i=0;i<results.rows.length;i++){
                        upbridgeModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta1 WHERE tabNum = ?',[5])
                    for(i=0;i<results.rows.length;i++){
                        downbridgeModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta1 WHERE tabNum = ?',[6])
                    for(i=0;i<results.rows.length;i++){
                        croseModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                })
            }
            catch(err){
                console.log("error init model from Ta1"+err)
            }
        }

        Connections{
            target: parent
            onSaveSignal:saveData()
        }

        function saveData(){
            console.log("__tab1__func__saveData__")
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    tx.executeSql('DELETE FROM Ta1')
                    for(var i=0;i<turnModel_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta1 VALUES(?,?,?,?,?)',
                                      [turnModel_.get(i).tabNum,
                                      turnModel_.get(i).checked,
                                      turnModel_.get(i).content,
                                      turnModel_.get(i).type,
                                      turnModel_.get(i).speaker])
                    }
                    for(i=0;i<uphillModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta1 VALUES(?,?,?,?,?)',
                                      [uphillModel_.get(i).tabNum,
                                      uphillModel_.get(i).checked,
                                      uphillModel_.get(i).content,
                                      uphillModel_.get(i).type,
                                      uphillModel_.get(i).speaker])
                    }
                    for(i=0;i<downhillModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta1 VALUES(?,?,?,?,?)',
                                      [downhillModel_.get(i).tabNum,
                                      downhillModel_.get(i).checked,
                                      downhillModel_.get(i).content,
                                      downhillModel_.get(i).type,
                                      downhillModel_.get(i).speaker])
                    }
                    for(i=0;i<speedModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta1 VALUES(?,?,?,?,?)',
                                      [speedModel_.get(i).tabNum,
                                      speedModel_.get(i).checked,
                                      speedModel_.get(i).content,
                                      speedModel_.get(i).type,
                                      speedModel_.get(i).speaker])
                    }
                    for(i=0;i<upbridgeModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta1 VALUES(?,?,?,?,?)',
                                      [upbridgeModel_.get(i).tabNum,
                                      upbridgeModel_.get(i).checked,
                                      upbridgeModel_.get(i).content,
                                      upbridgeModel_.get(i).type,
                                      upbridgeModel_.get(i).speaker])
                    }
                    for(i=0;i<downbridgeModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta1 VALUES(?,?,?,?,?)',
                                      [downbridgeModel_.get(i).tabNum,
                                      downbridgeModel_.get(i).checked,
                                      downbridgeModel_.get(i).content,
                                      downbridgeModel_.get(i).type,
                                      downbridgeModel_.get(i).speaker])
                    }
                    for(i=0;i<croseModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta1 VALUES(?,?,?,?,?)',
                                      [croseModel_.get(i).tabNum,
                                      croseModel_.get(i).checked,
                                      croseModel_.get(i).content,
                                      croseModel_.get(i).type,
                                      croseModel_.get(i).speaker])
                    }
                })
            }
            catch(err){
                console.log("err save data to database Ta1"+err)
            }
        }

        //model对应 转弯 上坡 下坡 超速 上桥 下桥 斑马线
        ListModel{id: turnModel_}
        ListModel{id: uphillModel_}
        ListModel{id: downhillModel_}
        ListModel{id: speedModel_}
        ListModel{id: upbridgeModel_}
        ListModel{id: downbridgeModel_}
        ListModel{id: croseModel_}

        PopTemplate{
            id: pop_contentAdd_
            x: (parent.width - width)/2
            y: (parent.height - height)/2
            property string modelContent: ""
            property int modifyFlag: 0
            property int modiftRow: -1


            Rectangle{
                id: popTopPart_
                width: parent.width
                height: 50
                color: "black"
                Text {
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 30
                    text: qsTr("添加安全信息提示")
                }
            }

            Rectangle{
                x: 1
                y: 50
                width: parent.width - 2
                height: 200

                Label{
                    x: 140
                    y: 30
                    width: 80
                    height: 30
                    text: qsTr("类型")
                }
                ComboBox{
                    id: comboBox_type_
                    x: 220
                    y: 20
                    width: 200
                    height: 30
                    model: ["文字","MP3"]

                    onCurrentTextChanged: {
                        if(currentText==="文字"){
                            label_content_.text = "文字内容"
                            pop_contentAdd_.modelContent = ""
                            textContent_.visible = true
                            textContent_.enabled = true
                            label_MP3content_.visible = false
                            label_MP3content_.enabled = false
                            button_MP3content_.visible = false
                            button_MP3content_.enabled = false
                        }else if(currentText==="MP3"){
                            label_content_.text = "MP3路径"
                            pop_contentAdd_.modelContent = ""
                            textContent_.visible = false
                            textContent_.enabled = false
                            label_MP3content_.visible = true
                            label_MP3content_.enabled = true
                            button_MP3content_.visible = true
                            button_MP3content_.enabled = true
                        }
                    }
                }

                Label{
                    id: label_content_
                    x: 140
                    y: 80
                    width: 80
                    height: 30
                }
                Rectangle{
                    id: textContent_
                    x: 220
                    y: 72
                    width: 200
                    height: 25
                    border.color: "black"
                    TextInput{
                        id: textInput_content_
                        anchors.fill: parent
                        anchors.margins: 5
                        focus: true
                        clip: true
                        font.pixelSize: 15
                        selectByMouse: true
                    }
                }
                Label{
                    id: label_MP3content_
                    x: 220
                    y: 78
                    width: 200
                    height: 30
                    clip: true
                    font.pixelSize: 15
                    elide: Text.ElideLeft
                }
                Button{
                    id: button_MP3content_
                    x: 425
                    y: 70
                    implicitWidth: 60
                    implicitHeight: 30
                    text: qsTr("浏览")

                    onClicked: {
                        fileDialog_.open()
                    }
                }

                FileDialog{
                    id: fileDialog_
                    title: qsTr("选择MP3文件")
                    nameFilters: ["mp3 files(*.mp3)","mp3文件"]
                    folder: ".."
                    onAccepted: {
                        label_MP3content_.text = fileDialog_.fileUrl
                        pop_contentAdd_.modelContent = fileDialog_.fileUrl
                    }
                    onRejected: {
                        console.log("Canceled")
                    }
                }


                Label{
                    x: 140
                    y: 130
                    width: 80
                    height: 30
                    text: qsTr("播报设备")
                }

                ComboBox{
                    id: comboBox_speaker_

                    x: 220
                    y: 120
                    width: 200
                    height: 30
                    model: ["车内喇叭","车外喇叭","手麦"]
                }
            }

            Rectangle{
                x: 1
                y:250
                width: parent.width - 2
                height: 49
                Button{
                    x: 120
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("确定")

                    onClicked: {
                        if(comboBox_type_.currentText === "文字"){
                            pop_contentAdd_.modelContent = textInput_content_.text
                        }

                        if(pop_contentAdd_.modelContent === ""){
                            console.log("内容为空")
                        }
                        else{
                            if(pop_contentAdd_.modifyFlag===0){
                                if(showPart_.tabFlag===0){
                                    turnModel_.append({
                                                            "checked":false,
                                                            "content":pop_contentAdd_.modelContent,
                                                            "type":comboBox_type_.currentText,
                                                            "speaker":comboBox_speaker_.currentText,
                                                            "tabNum":showPart_.tabFlag})
                                }else if(showPart_.tabFlag===1){
                                    uphillModel_.append({
                                                           "checked":false,
                                                           "content":pop_contentAdd_.modelContent,
                                                           "type":comboBox_type_.currentText,
                                                           "speaker":comboBox_speaker_.currentText,
                                                           "tabNum":showPart_.tabFlag})
                                }else if(showPart_.tabFlag===2){
                                    downhillModel_.append({
                                                            "checked":false,
                                                            "content":pop_contentAdd_.modelContent,
                                                            "type":comboBox_type_.currentText,
                                                            "speaker":comboBox_speaker_.currentText,
                                                            "tabNum":showPart_.tabFlag})
                                }else if(showPart_.tabFlag===3){
                                    speedModel_.append({
                                                           "checked":false,
                                                           "content":pop_contentAdd_.modelContent,
                                                           "type":comboBox_type_.currentText,
                                                           "speaker":comboBox_speaker_.currentText,
                                                            "tabNum":showPart_.tabFlag})
                                }else if(showPart_.tabFlag===4){
                                    upbridgeModel_.append({
                                                           "checked":false,
                                                           "content":pop_contentAdd_.modelContent,
                                                           "type":comboBox_type_.currentText,
                                                           "speaker":comboBox_speaker_.currentText,
                                                           "tabNum":showPart_.tabFlag})
                                }else if(showPart_.tabFlag===5){
                                    downbridgeModel_.append({
                                                           "checked":false,
                                                           "content":pop_contentAdd_.modelContent,
                                                           "type":comboBox_type_.currentText,
                                                           "speaker":comboBox_speaker_.currentText,
                                                           "tabNum":showPart_.tabFlag})
                                }
                                else if(showPart_.tabFlag===6){
                                    croseModel_.append({
                                                      "checked":false,
                                                      "content":pop_contentAdd_.modelContent,
                                                      "type":comboBox_type_.currentText,
                                                      "speaker":comboBox_speaker_.currentText,
                                                      "tabNum":showPart_.tabFlag})
                                }
                               pop_contentAdd_.close()
                            }else if(pop_contentAdd_.modifyFlag===1){
                                if(showPart_.tabFlag===0){
                                    turnModel_.set(pop_contentAdd_.modiftRow,{
                                                         "checked":false,
                                                         "content":pop_contentAdd_.modelContent,
                                                         "type":comboBox_type_.currentText,
                                                         "speaker":comboBox_speaker_.currentText})
                                }else if(showPart_.tabFlag===1){
                                    uphillModel_.set(pop_contentAdd_.modiftRow,{
                                                        "checked":false,
                                                        "content":pop_contentAdd_.modelContent,
                                                        "type":comboBox_type_.currentText,
                                                        "speaker":comboBox_speaker_.currentText})
                                }else if(showPart_.tabFlag===2){
                                    downhillModel_.set(pop_contentAdd_.modiftRow,{
                                                        "checked":false,
                                                        "content":pop_contentAdd_.modelContent,
                                                        "type":comboBox_type_.currentText,
                                                        "speaker":comboBox_speaker_.currentText})
                                }else if(showPart_.tabFlag===3){
                                    speedModel_.set(pop_contentAdd_.modiftRow,{
                                                        "checked":false,
                                                        "content":pop_contentAdd_.modelContent,
                                                        "type":comboBox_type_.currentText,
                                                        "speaker":comboBox_speaker_.currentText})
                                }else if(showPart_.tabFlag===4){
                                    upbridgeModel_.set(pop_contentAdd_.modiftRow,{
                                                        "checked":false,
                                                        "content":pop_contentAdd_.modelContent,
                                                        "type":comboBox_type_.currentText,
                                                        "speaker":comboBox_speaker_.currentText})
                                }else if(showPart_.tabFlag===5){
                                    downbridgeModel_.set(pop_contentAdd_.modiftRow,{
                                                        "checked":false,
                                                        "content":pop_contentAdd_.modelContent,
                                                        "type":comboBox_type_.currentText,
                                                        "speaker":comboBox_speaker_.currentText})
                                }else if(showPart_.tabFlag===6){
                                    croseModel_.set(pop_contentAdd_.modiftRow,{
                                                        "checked":false,
                                                        "content":pop_contentAdd_.modelContent,
                                                        "type":comboBox_type_.currentText,
                                                        "speaker":comboBox_speaker_.currentText})
                                }
                                pop_contentAdd_.modiftRow = -1
                                pop_contentAdd_.modifyFlag = 0
                                pop_contentAdd_.close()
                            }//pop_contentAdd_.modifyFlag===1
                        }//pop_contentAdd_.modelContent != ""
                    }
                }
                Button{
                    x: 300
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
                textInput_content_.text = ""
                label_MP3content_.text = ""
            }

        }//pop_contentAdd_



        Rectangle{
            width: parent.width
            height: 40

            Con2.TabBar{
                spacing: 10
                width: 800
                height: 30

                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("转弯")

                    onClicked: {
                        showPart_.tabFlag = 0
                        tableView_.model = turnModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("上坡")

                    onClicked: {
                        showPart_.tabFlag = 1
                        tableView_.model = uphillModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("下坡")

                    onClicked: {
                        showPart_.tabFlag = 2
                        tableView_.model = downhillModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("超速")

                    onClicked: {
                        showPart_.tabFlag = 3
                        tableView_.model = speedModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("上桥")

                    onClicked: {
                        showPart_.tabFlag = 4
                        tableView_.model = upbridgeModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("下桥")

                    onClicked: {
                        showPart_.tabFlag = 5
                        tableView_.model = downbridgeModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("斑马线")

                    onClicked: {
                        showPart_.tabFlag = 6
                        tableView_.model = croseModel_
                    }
                }
            }
        }//标签按钮 转弯 上坡 下坡 超速 上桥 下桥 斑马线

        Rectangle{
            x: 0
            y: 40
            width: parent.width
            height: 40

            RowLayout{
                width: 210
                height: parent.height
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
                        if(showPart_.tabFlag === 0){
                            for(var i=0;i<turnModel_.count;i++){
                                if(turnModel_.get(i).checked){
                                    turnModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag === 1){
                            for(i=0;i<uphillModel_.count;i++){
                                if(uphillModel_.get(i).checked){
                                    uphillModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag === 2){
                            for(i=0;i<downhillModel_.count;i++){
                                if(downhillModel_.get(i).checked){
                                    downhillModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag === 3){
                            for(i=0;i<speedModel_.count;i++){
                                if(speedModel_.get(i).checked){
                                    speedModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag === 4){
                            for(i=0;i<upbridgeModel_.count;i++){
                                if(upbridgeModel_.get(i).checked){
                                    upbridgeModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag === 5){
                            for(i=0;i<downbridgeModel_.count;i++){
                                if(downbridgeModel_.get(i).checked){
                                    downbridgeModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag === 6){
                            for(i=0;i<croseModel_.count;i++){
                                if(croseModel_.get(i).checked){
                                    croseModel_.remove(i)
                                    i--
                                }
                            }
                        }
                    }
                }
            }
        }//添加/删除按钮

        Item {
            y:80
            width: parent.width
            height: parent.height - 80

            TableView{
                id: tableView_
                anchors.fill: parent
                model: turnModel_

                TableViewColumn{ id: checkedColumn_; role: "checked"; title: "选择"; width: 80}
                TableViewColumn{ id: contentColumn_; role: "content"; title: "内容"; width: 500}
                TableViewColumn{ id: typeColumn_; role: "type"; title: "类型"; width: 100}
                TableViewColumn{ id: speakerColumn_; role: "speaker"; title: "喇叭"; width: 100}
//                TableViewColumn{ id: numColumn_; role: "tabNum"; title: "num"; width: 80}

                itemDelegate: Item {
                    implicitWidth: 50
                    CheckBox{
                        anchors.centerIn: parent
                        visible: tableView_.getColumn(styleData.column)===checkedColumn_?true:false
                        checked: styleData.value
                    }
                    Text {
                        anchors.left: parent.left
                        visible: tableView_.getColumn(styleData.column)===contentColumn_?true:false
                        text: styleData.value
                        elide: Text.ElideMiddle
                    }
                    Text {
                        anchors.left: parent.left
                        visible: tableView_.getColumn(styleData.column)===typeColumn_?true:false
                        text: styleData.value
                    }
                    Text {
                        anchors.left: parent.left
                        visible: tableView_.getColumn(styleData.column)===speakerColumn_?true:false
                        text: styleData.value
                    }
//                    Text {
//                        anchors.left: parent.left
//                        visible: tableView_.getColumn(styleData.column)===numColumn_?true:false
//                        text: styleData.value
//                    }
                }
                onClicked: {
                    if(showPart_.tabFlag === 0){
                        turnModel_.set(currentRow,{"checked":!turnModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag === 1){
                        uphillModel_.set(currentRow,{"checked":!uphillModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag === 2){
                        downhillModel_.set(currentRow,{"checked":!downhillModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag === 3){
                        speedModel_.set(currentRow,{"checked":!speedModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag === 4){
                        upbridgeModel_.set(currentRow,{"checked":!upbridgeModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag === 5){
                        downbridgeModel_.set(currentRow,{"checked":!downbridgeModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag === 6){
                        croseModel_.set(currentRow,{"checked":!croseModel_.get(currentRow).checked})
                    }
                }

                onDoubleClicked: {
                    pop_contentAdd_.modifyFlag = 1
                    pop_contentAdd_.modiftRow = currentRow
                    pop_contentAdd_.open()
                }
            }
        }//tableView_

    }
}
