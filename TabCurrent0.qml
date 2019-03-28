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
                tx.executeSql('CREATE TABLE IF NOT EXISTS Ta0(
                              tabNum INTEGER,
                              checked Boolean,
                              content TEXT,
                              type TEXT,
                              speaker TEXT,
                              style INTEGER,
                              mylanguage TEXT
                              )')
                tx.executeSql('CREATE TABLE IF NOT EXISTS Ta0Style(style TEXT)')
            })
        }
        catch(err){
            console.log("error create table in database Ta0"+err)
        }
    }

    function saveM(){
        console.log("__tab0__func__saveM__")
        saveSignal()
    }

    Item {
        id: showPart_
        anchors.fill: parent
        property int tabFlag: 0
        property int indexFlag: 0

        Component.onCompleted: {
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    var results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[0,0])
                    for(var i=0;i<results.rows.length;i++){
                        firOutModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type,
                                                "style":results.rows.item(i).style,
                                                "mylanguage":results.rows.item(i).mylanguage
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[1,0])
                    for(i=0;i<results.rows.length;i++){
                        genInModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type,
                                                "style":results.rows.item(i).style,
                                                "mylanguage":results.rows.item(i).mylanguage
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[2,0])
                    for(i=0;i<results.rows.length;i++){
                        genOutModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type,
                                                "style":results.rows.item(i).style,
                                                "mylanguage":results.rows.item(i).mylanguage
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[3,0])
                    for(i=0;i<results.rows.length;i++){
                        terInModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type,
                                                "style":results.rows.item(i).style,
                                                "mylanguage":results.rows.item(i).mylanguage
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta0Style')
                    for(i=0;i<results.rows.length;i++){
                        styleModel_.append({"text":results.rows.item(i).style})
                    }
                })
            }
            catch(err){
                console.log('error init model from Ta0'+err)
            }
        }

        Connections{
            target: parent
            onSaveSignal:showPart_.saveData()
        }

        //APP退出时 保存当前报站风格内容
        function saveData(){
            console.log("__tab0__func__saveData__")
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    tx.executeSql('DELETE FROM Ta0 WHERE tabNum = ? AND style = ?',[showPart_.tabFlag,t0_broadStyle_.currentIndex])
                    for(var i=0;i<firOutModel_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta0 VALUES(?,?,?,?,?,?,?)',
                                      [firOutModel_.get(i).tabNum,
                                      firOutModel_.get(i).checked,
                                      firOutModel_.get(i).content,
                                      firOutModel_.get(i).type,
                                      firOutModel_.get(i).speaker,
                                      firOutModel_.get(i).style,
                                      firOutModel_.get(i).mylanguage])
                    }
                    for(i=0;i<genInModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta0 VALUES(?,?,?,?,?,?,?)',
                                      [genInModel_.get(i).tabNum,
                                      genInModel_.get(i).checked,
                                      genInModel_.get(i).content,
                                      genInModel_.get(i).type,
                                      genInModel_.get(i).speaker,
                                      genInModel_.get(i).style,
                                      genInModel_.get(i).mylanguage])
                    }
                    for(i=0;i<genOutModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta0 VALUES(?,?,?,?,?,?)',
                                      [genOutModel_.get(i).tabNum,
                                      genOutModel_.get(i).checked,
                                      genOutModel_.get(i).content,
                                      genOutModel_.get(i).type,
                                      genOutModel_.get(i).speaker,
                                      genOutModel_.get(i).style,
                                      genOutModel_.get(i).mylanguage])
                    }
                    for(i=0;i<terInModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta0 VALUES(?,?,?,?,?,?)',
                                      [terInModel_.get(i).tabNum,
                                      terInModel_.get(i).checked,
                                      terInModel_.get(i).content,
                                      terInModel_.get(i).type,
                                      terInModel_.get(i).speaker,
                                      terInModel_.get(i).style,
                                      terInModel_.get(i).mylanguage])
                    }
                })
            }
            catch(err){
                console.log("err save data to database Ta0"+err)
            }
        }

        //报站风格改变时 导入该报站风格内容
        function sTChanged(){
            console.log("__func__styleChanged__")
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    var results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[0,t0_broadStyle_.currentIndex])
                    for(var i=0;i<results.rows.length;i++){
                        firOutModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type,
                                                "style":results.rows.item(i).style,
                                                "mylanguage":results.rows.item(i).mylanguage
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[1,t0_broadStyle_.currentIndex])
                    for(i=0;i<results.rows.length;i++){
                        genInModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type,
                                                "style":results.rows.item(i).style,
                                                "mylanguage":results.rows.item(i).mylanguage
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[2,t0_broadStyle_.currentIndex])
                    for(i=0;i<results.rows.length;i++){
                        genOutModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type,
                                                "style":results.rows.item(i).style,
                                                "mylanguage":results.rows.item(i).mylanguage
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[3,t0_broadStyle_.currentIndex])
                    for(i=0;i<results.rows.length;i++){
                        terInModel_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type,
                                                "style":results.rows.item(i).style,
                                                "mylanguage":results.rows.item(i).mylanguage
                                            })
                    }
                })
            }
            catch(err){
                console.log('error init model from Ta0'+err)
            }
        }

        //报站风格改变时 保存上一次修改内容
        function sTsave(){
            console.log("__tab0__func__sTsave__")
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    tx.executeSql('DELETE FROM Ta0 WHERE style = ?',[showPart_.indexFlag])
                    for(var i=0;i<firOutModel_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta0 VALUES(?,?,?,?,?,?,?)',
                                      [firOutModel_.get(i).tabNum,
                                      firOutModel_.get(i).checked,
                                      firOutModel_.get(i).content,
                                      firOutModel_.get(i).type,
                                      firOutModel_.get(i).speaker,
                                      firOutModel_.get(i).style,
                                      firOutModel_.get(i).mylanguage])
                    }
                    for(i=0;i<genInModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta0 VALUES(?,?,?,?,?,?,?)',
                                      [genInModel_.get(i).tabNum,
                                      genInModel_.get(i).checked,
                                      genInModel_.get(i).content,
                                      genInModel_.get(i).type,
                                      genInModel_.get(i).speaker,
                                      genInModel_.get(i).style,
                                      genInModel_.get(i).mylanguage])
                    }
                    for(i=0;i<genOutModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta0 VALUES(?,?,?,?,?,?,?)',
                                      [genOutModel_.get(i).tabNum,
                                      genOutModel_.get(i).checked,
                                      genOutModel_.get(i).content,
                                      genOutModel_.get(i).type,
                                      genOutModel_.get(i).speaker,
                                      genOutModel_.get(i).style,
                                      genOutModel_.get(i).mylanguage])
                    }
                    for(i=0;i<terInModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta0 VALUES(?,?,?,?,?,?,?)',
                                      [terInModel_.get(i).tabNum,
                                      terInModel_.get(i).checked,
                                      terInModel_.get(i).content,
                                      terInModel_.get(i).type,
                                      terInModel_.get(i).speaker,
                                      terInModel_.get(i).style,
                                      terInModel_.get(i).mylanguage])
                    }
                })
            }
            catch(err){
                console.log("err save data to database Ta0"+err)
            }
        }

        //报站风格添加时 直接存入数据库 线路管理中读取
        function saveStyle(){
            console.log("__tab0__func__saveData__")
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    tx.executeSql('DELETE FROM Ta0Style')
                    for(var i=0;i<styleModel_.count;i++){
                        tx.executeSql('INSERT INTO Ta0Style VALUES(?)',
                                      [styleModel_.get(i).text])
                    }
                })
            }
            catch(err){
                console.log("err save data to database Ta0"+err)
            }
        }

        //model对应 首站出站 普通站进站 普通站出站 末站进站
        ListModel{id: firOutModel_}
        ListModel{id: genInModel_}
        ListModel{id: genOutModel_}
        ListModel{id: terInModel_}
        ListModel{id: styleModel_}

        PopTemplate{
            id: pop_contentAdd_
            x: (parent.width - width)/2
            y: (parent.height - height)/2
            property string modelContent: ""
            property int modifyFlag: 0
            property int modiftRow: -1
            property int insertFlag: 0
            property int insertRow: -1

            Rectangle{
                id: popTopPart_
                width: parent.width
                height: 50
                color: "black"
                Text {
                    id: popTopText_
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 30
                }
            }

            Rectangle{
                x: 1
                y: 50
                width: parent.width - 2
                height: 200

                Label{
                    x: 140
                    y: 20
                    width: 80
                    height: 30
                    text: qsTr("类型")
                }
                ComboBox{
                    id: comboBox_type_
                    x: 220
                    y: 10
                    width: 200
                    height: 30
                    model: ["文字","标记","MP3"]

                    onCurrentTextChanged: {
                        if(currentText==="文字"){
                            label_content_.text = "文字内容"
                            pop_contentAdd_.modelContent = ""
                            textContent_.visible = true
                            textContent_.enabled = true
                            comboBox_content_.visible = false
                            comboBox_content_.enabled = false
                            label_MP3content_.visible = false
                            label_MP3content_.enabled = false
                            button_MP3content_.visible = false
                            button_MP3content_.enabled = false
                        }else if(currentText==="标记"){
                            label_content_.text = "标记内容"
                            pop_contentAdd_.modelContent = comboBox_content_.currentText
                            textContent_.visible = false
                            textContent_.enabled = false
                            comboBox_content_.visible = true
                            comboBox_content_.enabled = true
                            label_MP3content_.visible = false
                            label_MP3content_.enabled = false
                            button_MP3content_.visible = false
                            button_MP3content_.enabled = false
                        }else if(currentText==="MP3"){
                            label_content_.text = "MP3路径"
                            pop_contentAdd_.modelContent = ""
                            textContent_.visible = false
                            textContent_.enabled = false
                            comboBox_content_.visible = false
                            comboBox_content_.enabled = false
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
                    y: 70
                    width: 80
                    height: 30
                }
                Rectangle{
                    id: textContent_
                    x: 220
                    y: 62
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
                ComboBox{
                    id: comboBox_content_
                    x: 220
                    y: 60
                    width: 200
                    height: 30
                    model: ["[本站点]","[下一站]","[起点站]","[终点站]","[路线名]",
                        "[THIS STATION]","[NEXT STATION]","[ORIGIN]","[TERMINAL]","LINENAME"]

                    onCurrentTextChanged: {
                        pop_contentAdd_.modelContent = currentText
                    }
                }
                Label{
                    id: label_MP3content_
                    x: 220
                    y: 68
                    width: 200
                    height: 30
                    clip: true
                    font.pixelSize: 15
                    elide: Text.ElideLeft
                }
                Button{
                    id: button_MP3content_
                    x: 425
                    y: 60
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
                    y: 120
                    width: 80
                    height: 30
                    text: qsTr("播报设备")
                }

                ComboBox{
                    id: comboBox_speaker_

                    x: 220
                    y: 110
                    width: 200
                    height: 30
                    model: ["车内喇叭","车外喇叭","手麦"]
                }

                Label{
                    x: 140
                    y: 170
                    width: 80
                    height: 30
                    text: qsTr("语种")
                }
                ComboBox{
                    id: comboBox_language_
                    x: 220
                    y: 160
                    width: 200
                    height: 30
                    model: ["默认","第一语种","第二语种"]
                }
            }

            Rectangle{
                x: 1
                y:250
                width: parent.width - 2
                height: 49
                Button{
                    x: 120
                    y: 10
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("确定")
                    enabled: t0_broadStyle_.currentText===("")?false:true

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
                                    firOutModel_.append({
                                                            "checked":false,
                                                            "content":pop_contentAdd_.modelContent,
                                                            "type":comboBox_type_.currentText,
                                                            "speaker":comboBox_speaker_.currentText,
                                                            "tabNum":showPart_.tabFlag,
                                                            "style":t0_broadStyle_.currentIndex,
                                                            "mylanguage":comboBox_language_.currentText})
                                    console.log(comboBox_language_.currentText)
                                }else if(showPart_.tabFlag===1){
                                    genInModel_.append({
                                                           "checked":false,
                                                           "content":pop_contentAdd_.modelContent,
                                                           "type":comboBox_type_.currentText,
                                                           "speaker":comboBox_speaker_.currentText,
                                                           "tabNum":showPart_.tabFlag,
                                                           "style":t0_broadStyle_.currentIndex,
                                                           "mylanguage":comboBox_language_.currentText})
                                }else if(showPart_.tabFlag===2){
                                    genOutModel_.append({
                                                            "checked":false,
                                                            "content":pop_contentAdd_.modelContent,
                                                            "type":comboBox_type_.currentText,
                                                            "speaker":comboBox_speaker_.currentText,
                                                            "tabNum":showPart_.tabFlag,
                                                            "style":t0_broadStyle_.currentIndex,
                                                            "mylanguage":comboBox_language_.currentText})
                                }else if(showPart_.tabFlag===3){
                                    terInModel_.append({
                                                           "checked":false,
                                                           "content":pop_contentAdd_.modelContent,
                                                           "type":comboBox_type_.currentText,
                                                           "speaker":comboBox_speaker_.currentText,
                                                           "tabNum":showPart_.tabFlag,
                                                           "style":t0_broadStyle_.currentIndex,
                                                           "mylanguage":comboBox_language_.currentText})
                                }
                               pop_contentAdd_.close()
                            }else if(pop_contentAdd_.modifyFlag===1){
                                if(showPart_.tabFlag===0){
                                    firOutModel_.set(pop_contentAdd_.modiftRow,{
                                                         "checked":false,
                                                         "content":pop_contentAdd_.modelContent,
                                                         "type":comboBox_type_.currentText,
                                                         "speaker":comboBox_speaker_.currentText,
                                                         "mylanguage":comboBox_language_.currentText})
                                }else if(showPart_.tabFlag===1){
                                    genInModel_.set(pop_contentAdd_.modiftRow,{
                                                        "checked":false,
                                                        "content":pop_contentAdd_.modelContent,
                                                        "type":comboBox_type_.currentText,
                                                        "speaker":comboBox_speaker_.currentText,
                                                        "mylanguage":comboBox_language_.currentText})
                                }else if(showPart_.tabFlag===2){
                                    genOutModel_.set(pop_contentAdd_.modiftRow,{
                                                        "checked":false,
                                                        "content":pop_contentAdd_.modelContent,
                                                        "type":comboBox_type_.currentText,
                                                        "speaker":comboBox_speaker_.currentText,
                                                        "mylanguage":comboBox_language_.currentText})
                                }else if(showPart_.tabFlag===3){
                                    terInModel_.set(pop_contentAdd_.modiftRow,{
                                                        "checked":false,
                                                        "content":pop_contentAdd_.modelContent,
                                                        "type":comboBox_type_.currentText,
                                                        "speaker":comboBox_speaker_.currentText,
                                                        "mylanguage":comboBox_language_.currentText})
                                }
                                pop_contentAdd_.modiftRow = -1
                                pop_contentAdd_.modifyFlag = 0
                                pop_contentAdd_.close()
                            }//pop_contentAdd_.modifyFlag===1

                            if(pop_contentAdd_.insertFlag && (pop_contentAdd_.insertRow!=-1)){
                                if(showPart_.tabFlag===0){
                                    firOutModel_.insert(pop_contentAdd_.insertRow+1,{
                                                            "checked":false,
                                                            "content":pop_contentAdd_.modelContent,
                                                            "type":comboBox_type_.currentText,
                                                            "speaker":comboBox_speaker_.currentText,
                                                            "tabNum":showPart_.tabFlag,
                                                            "style":t0_broadStyle_.currentIndex,
                                                            "mylanguage":comboBox_language_.currentText})
                                }else if(showPart_.tabFlag===1){
                                    genInModel_.insert(pop_contentAdd_.insertRow+1,{
                                                           "checked":false,
                                                           "content":pop_contentAdd_.modelContent,
                                                           "type":comboBox_type_.currentText,
                                                           "speaker":comboBox_speaker_.currentText,
                                                           "tabNum":showPart_.tabFlag,
                                                           "style":t0_broadStyle_.currentIndex,
                                                           "mylanguage":comboBox_language_.currentText})
                                }else if(showPart_.tabFlag===2){
                                    genOutModel_.insert(pop_contentAdd_.insertRow+1,{
                                                            "checked":false,
                                                            "content":pop_contentAdd_.modelContent,
                                                            "type":comboBox_type_.currentText,
                                                            "speaker":comboBox_speaker_.currentText,
                                                            "tabNum":showPart_.tabFlag,
                                                            "style":t0_broadStyle_.currentIndex,
                                                            "mylanguage":comboBox_language_.currentText})
                                }else if(showPart_.tabFlag===3){
                                    terInModel_.insert(pop_contentAdd_.insertRow+1,{
                                                           "checked":false,
                                                           "content":pop_contentAdd_.modelContent,
                                                           "type":comboBox_type_.currentText,
                                                           "speaker":comboBox_speaker_.currentText,
                                                           "tabNum":showPart_.tabFlag,
                                                           "style":t0_broadStyle_.currentIndex,
                                                           "mylanguage":comboBox_language_.currentText})
                                }
                                pop_contentAdd_.close()
                                pop_contentAdd_.insertFlag=0
                                pop_contentAdd_.insertRow=-1
                                pop_contentAdd_.modifyFlag=0
                            }
                        }//pop_contentAdd_.modelContent != ""
                    }

                }

                Button{
                    x: 300
                    y: 10
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
                width: 500
                height: 30
                spacing: 10

                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("首站出站")

                    onClicked: {
                        showPart_.tabFlag = 0
                        tableView_.model = firOutModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("普通站进站")

                    onClicked: {
                        showPart_.tabFlag = 1
                        tableView_.model = genInModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("普通站出站")

                    onClicked: {
                        showPart_.tabFlag = 2
                        tableView_.model = genOutModel_
                    }
                }
                Con2.TabButton{
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("末站进站")

                    onClicked: {
                        showPart_.tabFlag = 3
                        tableView_.model = terInModel_
                    }
                }
            }
        }//标签按钮

        Rectangle{
            x: 0
            y: 40
            width: parent.width
            height: 40

                Button{
                    x:200
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("添加")

                    onClicked: {
                        popTopText_.text = "添加通用播报词"
                        pop_contentAdd_.open()
                    }
                }

                Button{
                    x: 300
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("插入")

                    onClicked: {
                        pop_contentAdd_.insertFlag = 1
                        pop_contentAdd_.insertRow = tableView_.currentRow
                        pop_contentAdd_.modifyFlag = 2
                        popTopText_.text = "插入通用播报词"
                        pop_contentAdd_.open()
                    }
                }

                Button{
                    x:400
                    implicitWidth: 80
                    implicitHeight: 30
                    text: qsTr("删除")

                    onClicked: {
                        if(showPart_.tabFlag===0){
                            for(var i=0;i<firOutModel_.count;i++){
                                if(firOutModel_.get(i).checked){
                                    firOutModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag===1){
                            for(i=0;i<genInModel_.count;i++){
                                if(genInModel_.get(i).checked){
                                    genInModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag===2){
                            for(i=0;i<genOutModel_.count;i++){
                                if(genOutModel_.get(i).checked){
                                    genOutModel_.remove(i)
                                    i--
                                }
                            }
                        }else if(showPart_.tabFlag===3){
                            for(i=0;i<terInModel_.count;i++){
                                if(terInModel_.get(i).checked){
                                    terInModel_.remove(i)
                                    i--
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    x: 10
                    width: 40
                    height: 30
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("报站风格")
                    }
                }
                ComboBox{
                    id: t0_broadStyle_
                    x: 70
                    width: 100
                    height: 30
                    model: styleModel_
                    editable: true

                    onAccepted: {
                        if(find(currentText)=== -1){
                            styleModel_.append({text:editText})
                            currentIndex = find(editText)
                        }
                        //报站风格存入Ta0Style
                        saveStyle()
                    }

                    onCurrentIndexChanged: {
                        //保存改变前报站风格内容
//                        console.log("currentIndex "+currentIndex)
                        sTsave();
                        //导入改变后报站风格内容
                        showPart_.indexFlag = currentIndex
                        firOutModel_.clear();
                        genInModel_.clear();
                        genOutModel_.clear();
                        terInModel_.clear();
                        sTChanged();
                    }
                }

        }//添加/删除按钮

        Item {
            y: 80
            width: parent.width
            height: parent.height - 80

            TableView{
                id: tableView_
                anchors.fill: parent
                model: firOutModel_

                TableViewColumn{ id: checkedColumn_; role: "checked"; title: "选择"; width: 80}
                TableViewColumn{ id: contentColumn_; role: "content"; title: "内容"; width: 500}
                TableViewColumn{ id: typeColumn_; role: "type"; title: "类型"; width: 100}
                TableViewColumn{ id: speakerColumn_; role: "speaker"; title: "喇叭"; width: 100}
                TableViewColumn{ id: languageColumn_; role: "mylanguage"; title: "语种"; width: 100}

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
                    Text {
                        anchors.left: parent.left
                        visible: tableView_.getColumn(styleData.column)===languageColumn_?true:false
                        text: styleData.value
                    }
                }

                onClicked: {
//                    console.log(currentRow)
                    if(showPart_.tabFlag===0){
                        firOutModel_.set(currentRow,{"checked":!firOutModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag===1){
                        genInModel_.set(currentRow,{"checked":!genInModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag===2){
                        genOutModel_.set(currentRow,{"checked":!genOutModel_.get(currentRow).checked})
                    }else if(showPart_.tabFlag===3){
                        terInModel_.set(currentRow,{"checked":!terInModel_.get(currentRow).checked})
                    }
                }
                onDoubleClicked: {
                    popTopText_.text = "修改通用播报词"
                    pop_contentAdd_.modifyFlag = 1
                    pop_contentAdd_.modiftRow = currentRow
                    pop_contentAdd_.open()
                }
            }//tableView_
        }//Item

    }

}

