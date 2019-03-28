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
                tx.executeSql('CREATE TABLE IF NOT EXISTS Ta2(
                              tabNum INTEGER,
                              checked Boolean,
                              content TEXT,
                              type TEXT,
                              speaker TEXT
                              )')
            })
        }
        catch(err){
            console.log("error create table in database Ta2"+err)

        }
    }

    function saveM(){
        console.log("__tab2__func__saveM__")
        saveSignal()
    }

    Item {
        id: showPart_
        anchors.fill: parent

        Component.onCompleted: {
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    var results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[0])
                    for(var i=0;i<results.rows.length;i++){
                        key0Model_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[1])
                    for(i=0;i<results.rows.length;i++){
                        key1Model_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[2])
                    for(i=0;i<results.rows.length;i++){
                        key2Model_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[3])
                    for(i=0;i<results.rows.length;i++){
                        key3Model_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[4])
                    for(i=0;i<results.rows.length;i++){
                        key4Model_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[5])
                    for(i=0;i<results.rows.length;i++){
                        key5Model_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[6])
                    for(i=0;i<results.rows.length;i++){
                        key6Model_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[7])
                    for(i=0;i<results.rows.length;i++){
                        key7Model_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[8])
                    for(i=0;i<results.rows.length;i++){
                        key8Model_.append({
                                                "tabNum":results.rows.item(i).tabNum,
                                                "checked":Boolean(results.rows.item(i).checked),
                                                "content":results.rows.item(i).content,
                                                "type":results.rows.item(i).type,
                                                "speaker":results.rows.item(i).type
                                            })
                    }

                    results = tx.executeSql('SELECT * FROM Ta2 WHERE tabNum = ?',[9])
                    for(i=0;i<results.rows.length;i++){
                        key9Model_.append({
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
                console.log('err init model from Ta2'+err)
            }
        }

        Connections{
            target: parent
            onSaveSignal:showPart_.saveData()
        }

        function saveData(){
            console.log("__tab2__func__saveData__")
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    tx.executeSql('DELETE FROM Ta2')
                    for(var i=0;i<key0Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key0Model_.get(i).tabNum,
                                      key0Model_.get(i).checked,
                                      key0Model_.get(i).content,
                                      key0Model_.get(i).type,
                                      key0Model_.get(i).speaker])
                    }

                    for(i=0;i<key1Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key1Model_.get(i).tabNum,
                                      key1Model_.get(i).checked,
                                      key1Model_.get(i).content,
                                      key1Model_.get(i).type,
                                      key1Model_.get(i).speaker])
                    }

                    for(i=0;i<key2Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key2Model_.get(i).tabNum,
                                      key2Model_.get(i).checked,
                                      key2Model_.get(i).content,
                                      key2Model_.get(i).type,
                                      key2Model_.get(i).speaker])
                    }

                    for(i=0;i<key3Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key3Model_.get(i).tabNum,
                                      key3Model_.get(i).checked,
                                      key3Model_.get(i).content,
                                      key3Model_.get(i).type,
                                      key3Model_.get(i).speaker])
                    }

                    for(i=0;i<key4Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key4Model_.get(i).tabNum,
                                      key4Model_.get(i).checked,
                                      key4Model_.get(i).content,
                                      key4Model_.get(i).type,
                                      key4Model_.get(i).speaker])
                    }

                    for(i=0;i<key5Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key5Model_.get(i).tabNum,
                                      key5Model_.get(i).checked,
                                      key5Model_.get(i).content,
                                      key5Model_.get(i).type,
                                      key5Model_.get(i).speaker])
                    }

                    for(i=0;i<key6Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key6Model_.get(i).tabNum,
                                      key6Model_.get(i).checked,
                                      key6Model_.get(i).content,
                                      key6Model_.get(i).type,
                                      key6Model_.get(i).speaker])
                    }

                    for(i=0;i<key7Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key7Model_.get(i).tabNum,
                                      key7Model_.get(i).checked,
                                      key7Model_.get(i).content,
                                      key7Model_.get(i).type,
                                      key7Model_.get(i).speaker])
                    }

                    for(i=0;i<key8Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key8Model_.get(i).tabNum,
                                      key8Model_.get(i).checked,
                                      key8Model_.get(i).content,
                                      key8Model_.get(i).type,
                                      key8Model_.get(i).speaker])
                    }

                    for(i=0;i<key9Model_.count;i++)
                    {
                        tx.executeSql('INSERT INTO Ta2 VALUES(?,?,?,?,?)',
                                      [key9Model_.get(i).tabNum,
                                      key9Model_.get(i).checked,
                                      key9Model_.get(i).content,
                                      key9Model_.get(i).type,
                                      key9Model_.get(i).speaker])
                    }

                })
            }
            catch(err){
                console.log("err save data to database Ta2"+err)
            }
        }

        //model KEY0-9
        ListModel{id: key0Model_}
        ListModel{id: key1Model_}
        ListModel{id: key2Model_}
        ListModel{id: key3Model_}
        ListModel{id: key4Model_}
        ListModel{id: key5Model_}
        ListModel{id: key6Model_}
        ListModel{id: key7Model_}
        ListModel{id: key8Model_}
        ListModel{id: key9Model_}

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
                    text: qsTr("添加按键播报信息")
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
                            if(pop_contentAdd_.modifyFlag === 0){
                                if(comboBox_key_.currentIndex === 0){
                                    key0Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===1){
                                    key1Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===2){
                                    key2Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===3){
                                    key3Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===4){
                                    key4Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===5){
                                    key5Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===6){
                                    key6Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===7){
                                    key7Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===8){
                                    key8Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===9){
                                    key9Model_.append({
                                                          "tabNum":comboBox_key_.currentIndex,
                                                          "checked":false,
                                                          "content":pop_contentAdd_.modelContent,
                                                          "type":comboBox_type_.currentText,
                                                          "speaker":comboBox_speaker_.currentText})
                                }
                                pop_contentAdd_.close()
                            }//modifyFlag=0 append
                            else if(pop_contentAdd_.modifyFlag === 1){
                                if(comboBox_key_.currentIndex === 0){
                                    key0Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===1){
                                    key1Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===2){
                                    key2Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===3){
                                    key3Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===4){
                                    key4Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===5){
                                    key5Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===6){
                                    key6Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===7){
                                    key7Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===8){
                                    key8Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }else if(comboBox_key_.currentIndex ===9){
                                    key9Model_.set(pop_contentAdd_.modiftRow,{
                                                       "checked":false,
                                                       "content":pop_contentAdd_.modelContent,
                                                       "type":comboBox_type_.currentText,
                                                       "speaker":comboBox_speaker_.currentText})
                                }
                                pop_contentAdd_.modiftRow = -1
                                pop_contentAdd_.modifyFlag = 0
                                pop_contentAdd_.close()
                            }//modifyFlag=1 set
                        }//pop_contentAdd_.modelContent不为空
                    }//onClicked
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

            Rectangle{
                width: 80
                height: 30
                Text {
                    anchors.centerIn: parent
                    text: qsTr("键名")
                }
            }
            ComboBox{
                id: comboBox_key_
                x: 100
                width: 200
                height: 30
                model: ["KEY0","KEY1","KEY2","KEY3","KEY4","KEY5","KEY6","KEY7","KEY8","KEY9"]

                onCurrentIndexChanged: {
//                    console.log("key"+currentIndex)
                    if(currentIndex===0){
                        tableView_.model = key0Model_
                    }else if(currentIndex===1){
                        tableView_.model = key1Model_
                    }else if(currentIndex===2){
                        tableView_.model = key2Model_
                    }else if(currentIndex===3){
                        tableView_.model = key3Model_
                    }else if(currentIndex===4){
                        tableView_.model = key4Model_
                    }else if(currentIndex===5){
                        tableView_.model = key5Model_
                    }else if(currentIndex===6){
                        tableView_.model = key6Model_
                    }else if(currentIndex===7){
                        tableView_.model = key7Model_
                    }else if(currentIndex===8){
                        tableView_.model = key8Model_
                    }else if(currentIndex===9){
                        tableView_.model = key9Model_
                    }
                }
            }
            Button{
                x: 320
                implicitWidth: 80
                implicitHeight: 30
                text: qsTr("添加")

                onClicked: {
                    pop_contentAdd_.open()
                }
            }
            Button{
                x:420
                implicitWidth: 80
                implicitHeight: 30
                text: qsTr("删除")

                onClicked: {
                    if(comboBox_key_.currentIndex===0){
                        for(var i=0;i<key0Model_.count;i++){
                            if(key0Model_.get(i).checked){
                                key0Model_.remove(i)
                                i--
                            }
                        }
                    }else if(comboBox_key_.currentIndex===1){
                        for(i=0;i<key1Model_.count;i++){
                            if(key1Model_.get(i).checked){
                                key1Model_.remove(i)
                                i--
                            }
                        }
                    }else if(comboBox_key_.currentIndex===2){
                        for(i=0;i<key2Model_.count;i++){
                            if(key2Model_.get(i).checked){
                                key2Model_.remove(i)
                                i--
                            }
                        }
                    }else if(comboBox_key_.currentIndex===3){
                        for(i=0;i<key3Model_.count;i++){
                            if(key3Model_.get(i).checked){
                                key3Model_.remove(i)
                                i--
                            }
                        }
                    }else if(comboBox_key_.currentIndex===4){
                        for(i=0;i<key4Model_.count;i++){
                            if(key4Model_.get(i).checked){
                                key4Model_.remove(i)
                                i--
                            }
                        }
                    }else if(comboBox_key_.currentIndex===5){
                        for(i=0;i<key5Model_.count;i++){
                            if(key5Model_.get(i).checked){
                                key5Model_.remove(i)
                                i--
                            }
                        }
                    }else if(comboBox_key_.currentIndex===6){
                        for(i=0;i<key6Model_.count;i++){
                            if(key6Model_.get(i).checked){
                                key6Model_.remove(i)
                                i--
                            }
                        }
                    }else if(comboBox_key_.currentIndex===7){
                        for(i=0;i<key7Model_.count;i++){
                            if(key7Model_.get(i).checked){
                                key7Model_.remove(i)
                                i--
                            }
                        }
                    }else if(comboBox_key_.currentIndex===8){
                        for(i=0;i<key8Model_.count;i++){
                            if(key8Model_.get(i).checked){
                                key8Model_.remove(i)
                                i--
                            }
                        }
                    }else if(comboBox_key_.currentIndex===9){
                        for(i=0;i<key9Model_.count;i++){
                            if(key9Model_.get(i).checked){
                                key9Model_.remove(i)
                                i--
                            }
                        }
                    }
                }
            }
        }

        Item {
            y:40
            width: parent.width
            height: parent.height - 40

            TableView{
                id: tableView_
                anchors.fill: parent
                model: key0Model_

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
                    if(comboBox_key_.currentIndex===0){
                        key0Model_.set(currentRow,{"checked":!key0Model_.get(currentRow).checked})
                    }else if(comboBox_key_.currentIndex===1){
                        key1Model_.set(currentRow,{"checked":!key1Model_.get(currentRow).checked})
                    }else if(comboBox_key_.currentIndex===2){
                        key2Model_.set(currentRow,{"checked":!key2Model_.get(currentRow).checked})
                    }else if(comboBox_key_.currentIndex===3){
                        key3Model_.set(currentRow,{"checked":!key3Model_.get(currentRow).checked})
                    }else if(comboBox_key_.currentIndex===4){
                        key4Model_.set(currentRow,{"checked":!key4Model_.get(currentRow).checked})
                    }else if(comboBox_key_.currentIndex===5){
                        key5Model_.set(currentRow,{"checked":!key5Model_.get(currentRow).checked})
                    }else if(comboBox_key_.currentIndex===6){
                        key6Model_.set(currentRow,{"checked":!key6Model_.get(currentRow).checked})
                    }else if(comboBox_key_.currentIndex===7){
                        key7Model_.set(currentRow,{"checked":!key7Model_.get(currentRow).checked})
                    }else if(comboBox_key_.currentIndex===8){
                        key8Model_.set(currentRow,{"checked":!key8Model_.get(currentRow).checked})
                    }else if(comboBox_key_.currentIndex===9){
                        key9Model_.set(currentRow,{"checked":!key9Model_.get(currentRow).checked})
                    }
                }
                onDoubleClicked: {
                    pop_contentAdd_.modifyFlag = 1
                    pop_contentAdd_.modiftRow = currentRow
                    pop_contentAdd_.open()
                }

            }//tableView_
        }




    }//showPart_
}
