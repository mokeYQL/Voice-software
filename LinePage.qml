import QtQuick 2.8
import QtQuick.Window 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls 2.0 as Con2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.LocalStorage 2.0
import QtQuick.Dialogs 1.1

Item {
    //模块生成时创建数据库
    Component.onCompleted: {
        var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
        try{
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS lineModel(
                              checked Boolean,
                              type TEXT,
                              nameZh TEXT,
                              nameEn TEXT,
                              style TEXT,
                              ID INTEGER primary key
                              )')
                tx.executeSql('CREATE TABLE IF NOT EXISTS upModel(
                              lineID INTEGER,
                              ID INTEGER,
                              Ordinal INTEGER,
                              checked Boolean,
                              nameZh TEXT,
                              nameEn TEXT,
                              LongItude TEXT,
                              LatItude TEXT,
                              InRadius TEXT,
                              OutRadius TEXT,
                              SpeedLimit TEXT,
                              type TEXT,
                              primary key(lineID,ID)
                              )')
                tx.executeSql('CREATE TABLE IF NOT EXISTS downModel(
                              lineID INTEGER,
                              ID INTEGER,
                              Ordinal INTEGER,
                              checked Boolean,
                              nameZh TEXT,
                              nameEn TEXT,
                              LongItude TEXT,
                              LatItude TEXT,
                              InRadius TEXT,
                              OutRadius TEXT,
                              SpeedLimit TEXT,
                              type TEXT,
                              primary key(lineID,ID)
                              )')

                var results = tx.executeSql('SELECT * FROM Ta0Style')
                for(var i=0;i<results.rows.length;i++){
                    styleModel_.append({"text":results.rows.item(i).style})
                }

                results = tx.executeSql('SELECT * FROM lineModel')
                for(i=0;i<results.rows.length;i++){
                    lineModel_.append({
                                      "checked":Boolean(results.rows.item(i).checked),
                                      "type":results.rows.item(i).type,
                                      "nameZh":results.rows.item(i).nameZh,
                                      "nameEn":results.rows.item(i).nameEn,
                                      "ID":String(results.rows.item(i).ID),
                                      "style":results.rows.item(i).style})
                }
            })
        }
        catch(err){
            console.log("error create table in database :"+err)
        }
    }

    //点击 设置站点 按钮时  保存当前lineModel并读取所选线路的上下行数据至up/downModel
    function setStation(){
        var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
        try{
            db.transaction(function(tx){
                tx.executeSql('DELETE FROM lineModel')
                for(var i=0;i<lineModel_.count;i++){
                    tx.executeSql('INSERT INTO lineModel VALUES(?,?,?,?,?,?)',
                                  [lineModel_.get(i).checked,
                                  lineModel_.get(i).type,
                                  lineModel_.get(i).nameZh,
                                  lineModel_.get(i).nameEn,
                                  lineModel_.get(i).style,
                                  lineModel_.get(i).ID])
                }
                upModel_.clear()
                downModel_.clear()
                var results = tx.executeSql('SELECT * FROM upModel WHERE lineID = ? order by Ordinal asc',[pop_stationAdd_.lineID])
                for(i=0;i<results.rows.length;i++){
                    upModel_.append({   "lineID":results.rows.item(i).lineID,
                                        "ID":String(results.rows.item(i).ID),
                                        "Ordinal":results.rows.item(i).Ordinal,
                                        "checked":Boolean(results.rows.item(i).checked),
                                        "nameZh":results.rows.item(i).nameZh,
                                        "nameEn":results.rows.item(i).nameEn,
                                        "LongItude":results.rows.item(i).LongItude,
                                        "LatItude":results.rows.item(i).LatItude,
                                        "InRadius":results.rows.item(i).InRadius,
                                        "OutRadius":results.rows.item(i).OutRadius,
                                        "SpeedLimit":results.rows.item(i).SpeedLimit,
                                        "type":results.rows.item(i).type
                                    })
                }

                results = tx.executeSql('SELECT * FROM downModel WHERE lineID = ? order by Ordinal asc',[pop_stationAdd_.lineID])
                for(i=0;i<results.rows.length;i++){
                    downModel_.append({   "lineID":results.rows.item(i).lineID,
                                        "ID":String(results.rows.item(i).ID),
                                        "Ordinal":results.rows.item(i).Ordinal,
                                        "checked":Boolean(results.rows.item(i).checked),
                                        "nameZh":results.rows.item(i).nameZh,
                                        "nameEn":results.rows.item(i).nameEn,
                                        "LongItude":results.rows.item(i).LongItude,
                                        "LatItude":results.rows.item(i).LatItude,
                                        "InRadius":results.rows.item(i).InRadius,
                                        "OutRadius":results.rows.item(i).OutRadius,
                                        "SpeedLimit":results.rows.item(i).SpeedLimit,
                                        "type":results.rows.item(i).type
                                    })
                }
            })
        }catch(err){
            console.log("error save data to database :"+err)
        }

        console.log("__LinePage__func__setStation__")
    }

    //导出文件前 保存线路
    function beforExport(){
//        console.log("__func__beforExport__")
        var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
        try{
             db.transaction(function(tx){
                 tx.executeSql('DELETE FROM lineModel')
                 for(var i=0;i<lineModel_.count;i++){
                     tx.executeSql('INSERT INTO lineModel VALUES(?,?,?,?,?,?)',
                                   [lineModel_.get(i).checked,
                                   lineModel_.get(i).type,
                                   lineModel_.get(i).nameZh,
                                   lineModel_.get(i).nameEn,
                                   lineModel_.get(i).style,
                                   lineModel_.get(i).ID])
                 }
             })
        }
        catch(err){
            console.log("err in beforExport "+err)
        }
    }

    //站点界面点击确定后保存up/dowmModel_数据  并保存线路信息
    function saveStation(){
        var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
        try{
            db.transaction(function(tx){
                tx.executeSql('DELETE FROM upModel WHERE lineID = ?',[pop_stationAdd_.lineID])
                tx.executeSql('DELETE FROM downModel WHERE lineID = ?',[pop_stationAdd_.lineID])
                for(var i=0;i<upModel_.count;i++){
                    tx.executeSql('INSERT INTO upModel VALUES(?,?,?,?,?,?,?,?,?,?,?,?)',
                                  [upModel_.get(i).lineID,
                                  upModel_.get(i).ID,
                                  upModel_.get(i).Ordinal,
                                  upModel_.get(i).checked,
                                  upModel_.get(i).nameZh,
                                  upModel_.get(i).nameEn,
                                  upModel_.get(i).LongItude,
                                  upModel_.get(i).LatItude,
                                  upModel_.get(i).InRadius,
                                  upModel_.get(i).OutRadius,
                                  upModel_.get(i).SpeedLimit,
                                  upModel_.get(i).type])
                }
                for(i=0;i<downModel_.count;i++){
                    tx.executeSql('INSERT INTO downModel VALUES(?,?,?,?,?,?,?,?,?,?,?,?)',
                                  [downModel_.get(i).lineID,
                                  downModel_.get(i).ID,
                                  downModel_.get(i).Ordinal,
                                  downModel_.get(i).checked,
                                  downModel_.get(i).nameZh,
                                  downModel_.get(i).nameEn,
                                  downModel_.get(i).LongItude,
                                  downModel_.get(i).LatItude,
                                  downModel_.get(i).InRadius,
                                  downModel_.get(i).OutRadius,
                                  downModel_.get(i).SpeedLimit,
                                  downModel_.get(i).type])
                }
            })
        }catch(err){
            console.log("error save station data to database"+err)
        }
    }

    //删除路线
    function delLine(delID){
        var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
        try{
            db.transaction(function(tx){
                tx.executeSql('DELETE FROM upModel WHERE lineID = ?',[delID])
                tx.executeSql('DELETE FROM downModel WHERE lineID = ?',[delID])
            })
        }catch(err){
            console.log("error delete line from database"+err)
        }
    }

    //传输导出model至QT
    function transModel(){
        //导出文件前先保存当前信息
        beforExport()
        //遍历lineModel 找到checked为1的线路
        for(var i=0;i<lineModel_.count;i++){
            var styleIndex = 0
            if(lineModel_.get(i).checked){
                console.log("--------------------translate model--------------------")
                GetM.clearModel()

                for(var q=0;q<styleModel_.count;q++){
                    if(lineModel_.get(i).style===styleModel_.get(q).text)
                    {
                        styleIndex = q
                    }
                }
                console.log(lineModel_.get(i).style)
                console.log(styleIndex)

                getTransUPDOWMModel(lineModel_.get(i).ID,styleIndex)

                //传递线路 key:value 值至QT
                console.log("__start__GetM.getLineModel()__")
                 GetM.getLineModel(lineModel_.get(i).type,
                                   lineModel_.get(i).nameZh,
                                   lineModel_.get(i).nameEn,
                                   lineModel_.get(i).style,
                                   lineModel_.get(i).ID)

                console.log("__start__GetM.getUpModel()__")
                for(var j=0;j<upModel_.count;j++){
                    GetM.getUpModel(upModel_.get(j).Ordinal,
                                    upModel_.get(j).ID,
                                    upModel_.get(j).nameZh,
                                    upModel_.get(j).nameEn,
                                    upModel_.get(j).LongItude,
                                    upModel_.get(j).LatItude,
                                    upModel_.get(j).InRadius,
                                    upModel_.get(j).OutRadius,
                                    upModel_.get(j).SpeedLimit,
                                    upModel_.get(j).type)
                }
                console.log("__start__GetM.getDowModel()__")
                for(j=0;j<downModel_.count;j++){
                    GetM.getDownModel(downModel_.get(j).Ordinal,
                                     downModel_.get(j).ID,
                                     downModel_.get(j).nameZh,
                                     downModel_.get(j).nameEn,
                                     downModel_.get(j).LongItude,
                                     downModel_.get(j).LatItude,
                                     downModel_.get(j).InRadius,
                                     downModel_.get(j).OutRadius,
                                     downModel_.get(j).SpeedLimit,
                                     downModel_.get(j).type)
                }
                console.log("__start__GetM.getFOModel()__")
                for(j=0;j<firOutModel_.count;j++){
                    GetM.getFOModel(firOutModel_.get(j).content,
                                    firOutModel_.get(j).type,
                                    firOutModel_.get(j).speaker,
                                    firOutModel_.get(j).mylanguage)
                }
                console.log("__start__GetM.getGIModel()__")
                for(j=0;j<genInModel_.count;j++){
                    GetM.getGIModel(genInModel_.get(j).content,
                                    genInModel_.get(j).type,
                                    genInModel_.get(j).speaker,
                                    genInModel_.get(j).mylanguage)
                }
                console.log("__start__GetM.getGOModel()__")
                for(j=0;j<genOutModel_.count;j++){
                    GetM.getGOModel(genOutModel_.get(j).content,
                                    genOutModel_.get(j).type,
                                    genOutModel_.get(j).speaker,
                                    genOutModel_.get(j).mylanguage)
                }
                console.log("__start__GetM.getTIModel()__")
                for(j=0;j<terInModel_.count;j++){
                    GetM.getTIModel(terInModel_.get(j).content,
                                    terInModel_.get(j).type,
                                    terInModel_.get(j).speaker,
                                    terInModel_.get(j).mylanguage)
                }

                console.log("__start__GetM.exportMsg()__")
                GetM.exportMsg();


            }
        }

        console.log("exit transModel")
    }

    ListModel{id: firOutModel_}
    ListModel{id: genInModel_}
    ListModel{id: genOutModel_}
    ListModel{id: terInModel_}
    //获取指定ID线路的UP/DOWM Model
    function getTransUPDOWMModel(index,styleIndex){
        console.log("import lineID "+index+"UP/DOWM Model")
        var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
        try{
            db.transaction(function(tx){
                upModel_.clear()
                downModel_.clear()
                firOutModel_.clear()
                genInModel_.clear()
                genOutModel_.clear()
                terInModel_.clear()
                var results = tx.executeSql('SELECT * FROM upModel WHERE lineID = ? order by Ordinal asc',[index])
                for(var i=0;i<results.rows.length;i++){
                    upModel_.append({   "lineID":results.rows.item(i).lineID,
                                        "ID":String(results.rows.item(i).ID),
                                        "Ordinal":results.rows.item(i).Ordinal,
                                        "checked":Boolean(results.rows.item(i).checked),
                                        "nameZh":results.rows.item(i).nameZh,
                                        "nameEn":results.rows.item(i).nameEn,
                                        "LongItude":results.rows.item(i).LongItude,
                                        "LatItude":results.rows.item(i).LatItude,
                                        "InRadius":results.rows.item(i).InRadius,
                                        "OutRadius":results.rows.item(i).OutRadius,
                                        "SpeedLimit":results.rows.item(i).SpeedLimit,
                                        "type":results.rows.item(i).type
                                    })
                }
                results = tx.executeSql('SELECT * FROM downModel WHERE lineID = ? order by Ordinal asc',[index])
                for(i=0;i<results.rows.length;i++){
                    downModel_.append({   "lineID":results.rows.item(i).lineID,
                                        "ID":String(results.rows.item(i).ID),
                                        "Ordinal":results.rows.item(i).Ordinal,
                                        "checked":Boolean(results.rows.item(i).checked),
                                        "nameZh":results.rows.item(i).nameZh,
                                        "nameEn":results.rows.item(i).nameEn,
                                        "LongItude":results.rows.item(i).LongItude,
                                        "LatItude":results.rows.item(i).LatItude,
                                        "InRadius":results.rows.item(i).InRadius,
                                        "OutRadius":results.rows.item(i).OutRadius,
                                        "SpeedLimit":results.rows.item(i).SpeedLimit,
                                        "type":results.rows.item(i).type
                                    })
                }
                results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[0,styleIndex])
                for(i=0;i<results.rows.length;i++){
                    firOutModel_.append({
                                            "content":results.rows.item(i).content,
                                            "type":results.rows.item(i).type,
                                            "speaker":results.rows.item(i).type,
                                            "mylanguage":results.rows.item(i).mylanguage
                                        })
                }
                results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[1,styleIndex])
                for(i=0;i<results.rows.length;i++){
                    genInModel_.append({
                                           "content":results.rows.item(i).content,
                                           "type":results.rows.item(i).type,
                                           "speaker":results.rows.item(i).type,
                                           "mylanguage":results.rows.item(i).mylanguage
                                        })
                }
                results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[2,styleIndex])
                for(i=0;i<results.rows.length;i++){
                    genOutModel_.append({
                                            "content":results.rows.item(i).content,
                                            "type":results.rows.item(i).type,
                                            "speaker":results.rows.item(i).type,
                                            "mylanguage":results.rows.item(i).mylanguage
                                        })
                }
                results = tx.executeSql('SELECT * FROM Ta0 WHERE tabNum = ? AND style = ?',[3,styleIndex])
                for(i=0;i<results.rows.length;i++){
                    terInModel_.append({
                                           "content":results.rows.item(i).content,
                                           "type":results.rows.item(i).type,
                                           "speaker":results.rows.item(i).type,
                                           "mylanguage":results.rows.item(i).mylanguage
                                        })
                }
            })
        }
        catch(err){
            console.log("error getTransUPDOWMModel "+err)
        }
    }


    //Model 线路: lineModel_  上行: upModel_ 下行: downModel——
    ListModel{
        id: lineModel_
    }
    ListModel{
        id: upModel_
    }
    ListModel{
        id: downModel_
    }
    ListModel{
        id: styleModel_
    }

    IDWarning{
        id: pop_idWarning_
        x: (parent.width - width)/2
        y: (parent.height - height)/2
    }//pop_idWarning_

    PopTemplate{
        id: pop_lineAdd_
        x: 250
        property int modifyRow: -1
        property int modifyFlag: 0

        onOpened: {
            styleModel_.clear()
            var db = LocalStorage.openDatabaseSync("lineRebuild","1.0","save data",100000)
            try{
                db.transaction(function(tx){
                    var results = tx.executeSql('SELECT * FROM Ta0Style')
                    for(var i=0;i<results.rows.length;i++){
                        styleModel_.append({"text":results.rows.item(i).style})
                    }
                })
            }
            catch(err){
                console.log("err init styleModel_ from database "+err)
            }
        }

        Rectangle{
            id: popTopPart_
            width: parent.width
            height: 50
            color: "black"
            Text {
                id: pop_addText_
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
                x: 100
                y: 20
                width: 20
                height: 10
                text: qsTr("线路类型")
            }
            TextInput{
                id: addTypeText_
                x: 200
                y: 20
                width: 200
                height: 10
                selectByMouse: true
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }

            Label{
                x: 100
                y: 50
                width: 20
                height: 10
                text: qsTr("中文线路名")
            }
            TextInput{
                id: addnameZhText_
                x: 200
                y: 50
                width: 200
                height: 10
                selectByMouse: true
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 100
                y: 80
                width: 20
                height: 10
                text: qsTr("英文线路名")
            }
            TextInput{
                id: addnameEnText_
                x: 200
                y: 80
                width: 200
                height: 10
                selectByMouse: true
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 100
                y: 110
                width: 20
                height: 10
                text: qsTr("路线ID")
            }
            TextInput{
                id: addidText_
                x: 200
                y: 110
                width: 200
                height: 10
                validator: RegExpValidator{regExp:/[0-9][0-9]/}
                selectByMouse: true
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 100
                y: 140
                width: 20
                height: 10
                text: qsTr("报站风格")
            }
            ComboBox{
                id: comboBox_style_
                x: 195
                y: 130
                width: 210
                height: 30
                model: styleModel_
            }
        }

        Rectangle{
            x: 1
            y: 250
            width: parent.width - 2
            height: 49

            Button{
                x: 120
                text: qsTr("确定")
                implicitWidth: 80
                implicitHeight: 30
                onClicked: {
                    var idFlag = 0
                    if(pop_lineAdd_.modifyFlag==1){
                        for(var i=0;i<lineModel_.count;i++){
                            if(i==pop_lineAdd_.modifyRow){
                               //修改当前ID
                            }
                            else{
                                if(lineModel_.get(i).ID===addidText_.text){
                                    idFlag = 1
                                }
                            }
                        }

                        if(idFlag){
                            pop_idWarning_.open()
                        }
                        else{
                            lineModel_.set(pop_lineAdd_.modifyRow,{
                                               "type":addTypeText_.text,
                                               "nameZh":addnameZhText_.text,
                                               "nameEn":addnameEnText_.text,
                                               "ID":addidText_.text,
                                               "style":comboBox_style_.currentText})
                            pop_lineAdd_.modifyFlag = -1
                            pop_lineAdd_.close()
                        }
                    }
                    else{
                        for(i=0;i<lineModel_.count;i++){
                            if(lineModel_.get(i).ID===addidText_.text){
                                idFlag = 1
                            }
                        }

                        if(idFlag){
                            pop_idWarning_.open()
                        }
                        else{
                            lineModel_.append({
                                              "checked":false,
                                              "type":addTypeText_.text,
                                              "nameZh":addnameZhText_.text,
                                              "nameEn":addnameEnText_.text,
                                              "ID":addidText_.text,
                                              "style":comboBox_style_.currentText})
                            pop_lineAdd_.close()
                        }
                    }
                }
            }
            Button{
                x: 300
                text: qsTr("取消")
                implicitWidth: 80
                implicitHeight: 30
                onClicked: {
                    pop_lineAdd_.close()
                }
            }//button
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
                pop_lineAdd_.x = pop_lineAdd_.x+delta.x
                pop_lineAdd_.y = pop_lineAdd_.y+delta.y
            }
        }
        onClosed: {
            addTypeText_.text = ""
            addnameZhText_.text = ""
            addnameEnText_.text = ""
            addidText_.text = ""
        }
    }//pop_lineAdd_

    PopTemplate{
        id: pop_stationAdd_
        width: 300
        height: 400
        x: 350
        property int lineID: 0
        property int smodifyFlag: 0
        property int sCurrentRow: -1

        Rectangle{
            id: popsTopPart_
            width: parent.width
            height: 50
            color: "black"
            Text {
                id: pop_saddText_
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 30
                text: qsTr("添加上行站点")
            }
        }

        Rectangle{
            x: 1
            y: 50
            width: parent.width - 2
            height: 300

            Label{
                x: 10
                y: 20
                width: 20
                height: 10
                text: qsTr("站点ID")
            }
            TextInput{
                id: sIDText_
                x: 80
                y: 20
                width: 200
                height: 10
                validator: RegExpValidator{regExp:/[0-9][0-9]/}
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 10
                y: 50
                width: 20
                height: 10
                text: qsTr("站点中文名")
            }
            TextInput{
                id: snameZhText_
                x: 80
                y: 50
                width: 200
                height: 10
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 10
                y: 80
                width: 20
                height: 10
                text: qsTr("站点英文名")
            }
            TextInput{
                id: snameEnText_
                x: 80
                y: 80
                width: 200
                height: 10
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 10
                y: 110
                width: 20
                height: 10
                text: qsTr("经度")
            }
            TextInput{
                id: sLongItudeText_
                x: 80
                y: 110
                width: 200
                height: 10
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 10
                y: 140
                width: 20
                height: 10
                text: qsTr("纬度")
            }
            TextInput{
                id: sLatItudeText_
                x: 80
                y: 140
                width: 200
                height: 10
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 10
                y: 170
                width: 20
                height: 10
                text: qsTr("进站半径")
            }
            TextInput{
                id: sInRadiusText_
                x: 80
                y: 170
                width: 200
                height: 10
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 10
                y: 200
                width: 20
                height: 10
                text: qsTr("出站半径")
            }
            TextInput{
                id: sOutRadiusText_
                x: 80
                y: 200
                width: 200
                height: 10
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 10
                y: 230
                width: 20
                height: 10
                text: qsTr("限速")
            }
            TextInput{
                id: sSpeedLimitText_
                x: 80
                y: 230
                width: 200
                height: 10
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
        }

        Rectangle{
            x: 1
            y: 350
            height: 49
            width: parent.width - 2
            Button{
                x: 40
                text: qsTr("确定")
                implicitWidth: 80
                implicitHeight: 30

                onClicked: {
                    var flag = 0
                    if(pop_station_.udflag === 0){
                        //上行
                        if(pop_stationAdd_.smodifyFlag === 0){
                            // 0 直接添加
                            for(var i=0;i<upModel_.count;i++){
                                if(upModel_.get(i).ID === sIDText_.text){
                                    flag = 1
                                }
                            }
                            if(flag){
                                pop_idWarning_.open()
                            }
                            else{
                                upModel_.append({
                                                "checked":false,
                                                "lineID":pop_stationAdd_.lineID,
                                                "Ordinal":upModel_.count+1,
                                                "ID":sIDText_.text,
                                                "nameZh":snameZhText_.text,
                                                "nameEn":snameEnText_.text,
                                                "LongItude":sLongItudeText_.text,
                                                "LatItude":sLatItudeText_.text,
                                                "InRadius":sInRadiusText_.text,
                                                "OutRadius":sOutRadiusText_.text,
                                                "SpeedLimit":sSpeedLimitText_.text,
                                                "type":"0"
                                                })
                                pop_stationAdd_.close()
                            }
                        }
                        else if(pop_stationAdd_.smodifyFlag === 1){
                            //1 修改
                            for(i=0;i<upModel_.count;i++){
                                if(i===pop_stationAdd_.sCurrentRow){
                                    //pass
                                }
                                else if(upModel_.get(i).ID === sIDText_.text){
                                    flag = 1
                                }
                            }

                            if(flag){
                                pop_idWarning_.open()
                            }
                            else{
                                upModel_.set(pop_stationAdd_.sCurrentRow,{
                                                 "ID":sIDText_.text,
                                                 "nameZh":snameZhText_.text,
                                                 "nameEn":snameEnText_.text,
                                                 "LongItude":sLongItudeText_.text,
                                                 "LatItude":sLatItudeText_.text,
                                                 "InRadius":sInRadiusText_.text,
                                                 "OutRadius":sOutRadiusText_.text,
                                                 "SpeedLimit":sSpeedLimitText_.text})
                                pop_stationAdd_.smodifyFlag = 0
                                pop_stationAdd_.sCurrentRow = -1
                                pop_stationAdd_.close()
                            }
                        }
                    }
                    else if(pop_station_.udflag === 1){
                        //下行
                        if(pop_stationAdd_.smodifyFlag === 0){
                            // 0 直接添加
                            for(i=0;i<downModel_.count;i++){
                                if(downModel_.get(i).ID === sIDText_.text){
                                    flag = 1
                                }
                            }
                            if(flag){
                                pop_idWarning_.open()
                            }
                            else{
                                downModel_.append({
                                                "checked":false,
                                                "lineID":pop_stationAdd_.lineID,
                                                "Ordinal":downModel_.count+1,
                                                "ID":sIDText_.text,
                                                "nameZh":snameZhText_.text,
                                                "nameEn":snameEnText_.text,
                                                "LongItude":sLongItudeText_.text,
                                                "LatItude":sLatItudeText_.text,
                                                "InRadius":sInRadiusText_.text,
                                                "OutRadius":sOutRadiusText_.text,
                                                "SpeedLimit":sSpeedLimitText_.text,
                                                "type":"0"
                                                })
                                pop_stationAdd_.close()
                            }
                        }
                        else if(pop_stationAdd_.smodifyFlag === 1){
                            //1 修改
                            for(i=0;i<downModel_.count;i++){
                                if(i===pop_stationAdd_.sCurrentRow){
                                    //pass
                                }
                                else if(downModel_.get(i).ID === sIDText_.text){
                                    flag = 1
                                }
                            }

                            if(flag){
                                pop_idWarning_.open()
                            }
                            else{
                                downModel_.set(pop_stationAdd_.sCurrentRow,{
                                                 "ID":sIDText_.text,
                                                 "nameZh":snameZhText_.text,
                                                 "nameEn":snameEnText_.text,
                                                 "LongItude":sLongItudeText_.text,
                                                 "LatItude":sLatItudeText_.text,
                                                 "InRadius":sInRadiusText_.text,
                                                 "OutRadius":sOutRadiusText_.text,
                                                 "SpeedLimit":sSpeedLimitText_.text})
                                pop_stationAdd_.smodifyFlag = 0
                                pop_stationAdd_.sCurrentRow = -1
                                pop_stationAdd_.close()
                            }
                        }
                    }
                }
            }
            Button{
                x: 180
                text: qsTr("取消")
                implicitWidth: 80
                implicitHeight: 30

                onClicked: {
                    pop_stationAdd_.close()
                }
            }
        }

        MouseArea{
            anchors.fill: popsTopPart_
            acceptedButtons: Qt.LeftButton
            property point clickPos: "0,0"
            onPressed: {
                clickPos = Qt.point(mouse.x,mouse.y)
            }
            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x,mouse.y-clickPos.y)
                pop_stationAdd_.x = pop_stationAdd_.x+delta.x
                pop_stationAdd_.y = pop_stationAdd_.y+delta.y
            }
        }

        onClosed: {
            sIDText_.text = ""
            snameZhText_.text = ""
            snameEnText_.text = ""
            sLongItudeText_.text = ""
            sLatItudeText_.text = ""
            sInRadiusText_.text = ""
            sOutRadiusText_.text = ""
            sSpeedLimitText_.text = ""
        }
    }//pop_stationAdd_

    PopTemplate{
        id: pop_batchModify_
        width: 300
        height: 350
        x: 350

        Rectangle{
            id: popBatchTop_
            width: parent.width
            height: 50
            color: "black"
            Text {
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 30
                text: qsTr("批量修改")
            }
        }

        Rectangle{
            x: 1
            width: parent.width - 2
            y: 50
            height: 250

            Label{
                x: 10
                y: 40
                text: qsTr("进站半径")
            }
            TextInput{
                id: batchInRadiusText_
                x: 80
                y: 40
                width: 200
                height: 10
//                validator: RegExpValidator{regExp:/[0-9][0-9]/}
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 10
                y: 80
                text: qsTr("出站半径")
            }
            TextInput{
                id: batchOutRadiusText_
                x: 80
                y: 80
                width: 200
                height: 10
//                validator: RegExpValidator{regExp:/[0-9][0-9]/}
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }
            Label{
                x: 10
                y: 120
                text: qsTr("限速")
            }
            TextInput{
                id: batchSpeedText_
                x: 80
                y: 120
                width: 200
                height: 10
//                validator: RegExpValidator{regExp:/[0-9][0-9]/}
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: -5
                    color: "transparent"
                    border.width: 1
                }
            }

        }

        Rectangle{
            x: 1
            width: parent.width - 2
            y: 300
            height: 49

            Button{
                x: 40
                implicitWidth: 80
                implicitHeight: 30
                text: qsTr("确定")

                onClicked: {
                    if(batchInRadiusText_.text!=""){
                        if(pop_station_.udflag===0){
                            //批量修改上行
                            for(var i=0;i<upModel_.count;i++){
                                if(upModel_.get(i).checked){
                                    upModel_.set(i,{"InRadius":batchInRadiusText_.text})
                                }
                            }
                        }
                        if(pop_station_.udflag===1){
                            //批量修改下行
                            for(i=0;i<downModel_.count;i++){
                                if(downModel_.get(i).checked){
                                    downModel_.set(i,{"InRadius":batchInRadiusText_.text})
                                }
                            }
                        }
                    }//inRadius批量修改
                    if(batchOutRadiusText_.text!=""){
                        if(pop_station_.udflag===0){
                            //批量修改上行
                            for(i=0;i<upModel_.count;i++){
                                if(upModel_.get(i).checked){
                                    upModel_.set(i,{"OutRadius":batchOutRadiusText_.text})
                                }
                            }
                        }
                        if(pop_station_.udflag===1){
                            //批量修改下行
                            for(i=0;i<downModel_.count;i++){
                                if(downModel_.get(i).checked){
                                    downModel_.set(i,{"OutRadius":batchOutRadiusText_.text})
                                }
                            }
                        }
                    }//outRadius批量修改
                    if(batchSpeedText_.text!=""){
                        if(pop_station_.udflag===0){
                            //批量修改上行
                            for(i=0;i<upModel_.count;i++){
                                if(upModel_.get(i).checked){
                                    upModel_.set(i,{"SpeedLimit":batchSpeedText_.text})
                                }
                            }
                        }
                        if(pop_station_.udflag===1){
                            //批量修改下行
                            for(i=0;i<downModel_.count;i++){
                                if(downModel_.get(i).checked){
                                    downModel_.set(i,{"SpeedLimit":batchSpeedText_.text})
                                }
                            }
                        }
                    }//speed批量修改

                    pop_batchModify_.close()
                }
            }
            Button{
                x: 180
                implicitWidth: 80
                implicitHeight: 30
                text: qsTr("取消")

                onClicked: {
                    pop_batchModify_.close()
                }
            }
        }

        MouseArea{
            anchors.fill: popBatchTop_
            acceptedButtons: Qt.LeftButton
            property point clickPos: "0,0"
            onPressed: {
                clickPos = Qt.point(mouse.x,mouse.y)
            }
            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x,mouse.y-clickPos.y)
                pop_batchModify_.x = pop_batchModify_.x+delta.x
                pop_batchModify_.y = pop_batchModify_.y+delta.y
            }
        }

        onClosed: {
            batchInRadiusText_.text = ""
            batchOutRadiusText_.text = ""
            batchSpeedText_.text = ""
        }
    }

    PopStation{
        id: pop_station_
        width: parent.width
        height: parent.height
        property int udflag: 0

        Rectangle{
            width: 150
            height: 30
            color: "black"
            Text {
                id: setstLineIdText_
                anchors.centerIn: parent
                color: "white"
            }
        }//线路ID提示
        Rectangle{
            x: 160
            y: 1
            height: 40
            RowLayout{
                Button{
                    text: qsTr("上行")
                    implicitWidth: 80
                    implicitHeight: 30

                    onClicked: {
                        pop_saddText_.text = qsTr("添加上行站点")
                        stationTableView_.model = upModel_
                        pop_station_.udflag = 0
                    }
                }
                Button{
                    text: qsTr("下行")
                    implicitWidth: 80
                    implicitHeight: 30

                    onClicked: {
                        pop_saddText_.text = qsTr("添加下行站点")
                        stationTableView_.model = downModel_
                        pop_station_.udflag = 1
                    }
                }
                Button{
                    text: qsTr("添加")
                    implicitWidth: 80
                    implicitHeight: 30

                    onClicked: {
                        pop_stationAdd_.open()
                    }
                }
                Button{
                    text: qsTr("删除")
                    implicitWidth: 80
                    implicitHeight: 30

                    onClicked: {
                        if(pop_station_.udflag === 0){
                            //删除上行
                            for(var i=0;i<upModel_.count;i++){
                                if(upModel_.get(i).checked){
                                    upModel_.remove(i)
                                    i--
                                }
                            }
                        }
                        else if(pop_station_.udflag === 1){
                            //删除下行
                            for(i=0;i<downModel_.count;i++){
                                if(downModel_.get(i).checked){
                                    downModel_.remove(i)
                                    i--
                                }
                            }
                        }
                    }
                }
                Button{
                    text: qsTr("上移")
                    implicitWidth: 80
                    implicitHeight: 30

                    onClicked: {
                        var rowFlag = stationTableView_.currentRow
                        if(pop_station_.udflag === 0){
                            if(rowFlag>0){
                                var stO = upModel_.get(rowFlag).Ordinal
                                upModel_.set(rowFlag,{"Ordinal":stO-1})
                                upModel_.set(rowFlag-1,{"Ordinal":stO})
                                upModel_.move(rowFlag,rowFlag-1,1)
                                rowFlag -=1
                            }
                        }
                        else if(pop_station_.udflag === 1){
                            if(rowFlag>0){
                                stO = downModel_.get(rowFlag).Ordinal
                                downModel_.set(rowFlag,{"Ordinal":stO-1})
                                downModel_.set(rowFlag-1,{"Ordinal":stO})
                                downModel_.move(rowFlag,rowFlag-1,1)
                                rowFlag -=1
                            }
                        }
                    }
                }
                Button{
                    text: qsTr("下移")
                    implicitWidth: 80
                    implicitHeight: 30

                    onClicked: {
                        console.log("before:"+stationTableView_.currentRow)

                        if(pop_station_.udflag === 0){
                            var rowFlag = stationTableView_.currentRow
                            if(rowFlag+1<upModel_.count){
                                var stO = upModel_.get(rowFlag).Ordinal
                                upModel_.set(rowFlag,{"Ordinal":stO+1})
                                upModel_.set(rowFlag+1,{"Ordinal":stO})
                                upModel_.move(rowFlag,rowFlag+1,1)
                            }
                        }
                        else if(pop_station_.udflag === 1){
                            rowFlag = stationTableView_.currentRow
                            if(rowFlag+1<downModel_.count){
                                stO = downModel_.get(rowFlag).Ordinal
                                downModel_.set(rowFlag,{"Ordinal":stO+1})
                                downModel_.set(rowFlag+1,{"Ordinal":stO})
                                downModel_.move(rowFlag,rowFlag+1,1)
                            }
                        }
                        console.log("after:"+stationTableView_.currentRow)
                    }
                }
                Button{
                    text: qsTr("批量修改")
                    implicitWidth: 80
                    implicitHeight: 30

                    onClicked: {
                        pop_batchModify_.open()
                    }
                }
                Button{
                    text: qsTr("确定")
                    implicitWidth: 80
                    implicitHeight: 30

                    onClicked: {
                        saveStation()
                        pop_station_.close()
                    }
                }
            }
        }//按钮

        TableView{
            id: stationTableView_
            x: 1
            y: 40
            width: parent.width - 2
            height: parent.height - 41

            TableViewColumn{id: scheckedColumn_;role: "checked";title: "选择";width: 80}
            TableViewColumn{id: sOrdinalColumn_;role: "Ordinal";title: "站点序号";width: 80}
            TableViewColumn{id: sIDColumn_;role: "ID";title: "站点ID";width: 80}
            TableViewColumn{id: snameZhColumn_;role: "nameZh";title: "中文站点名";width: 100}
            TableViewColumn{id: snameEnColumn_;role: "nameEn";title: "英文站点名";width: 100}
            TableViewColumn{id: sLongItudeColumn_;role: "LongItude";title: "经度";width: 80}
            TableViewColumn{id: sLatItudeColumn_;role: "LatItude";title: "纬度";width: 80}
            TableViewColumn{id: sInRadiusColumn_;role: "InRadius";title: "进站半径";width: 80}
            TableViewColumn{id: sOutRadiusColumn_;role: "OutRadius";title: "出站半径";width: 80}
            TableViewColumn{id: sSpeedLimitColumn_;role: "SpeedLimit";title: "限速";width: 80}
            TableViewColumn{id: stypeColumn_;role: "type";title: "站点类型";width: 80}

            itemDelegate: Item {
                CheckBox{
                    anchors.centerIn: parent
                    checked: styleData.value
                    visible: stationTableView_.getColumn(styleData.column)===scheckedColumn_?true:false
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===sOrdinalColumn_?true:false
                    text: styleData.value
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===sIDColumn_?true:false
                    text: styleData.value
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===snameZhColumn_?true:false
                    text: styleData.value
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===snameEnColumn_?true:false
                    text: styleData.value
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===sLongItudeColumn_?true:false
                    text: styleData.value
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===sLatItudeColumn_?true:false
                    text: styleData.value
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===sInRadiusColumn_?true:false
                    text: styleData.value
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===sOutRadiusColumn_?true:false
                    text: styleData.value
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===sSpeedLimitColumn_?true:false
                    text: styleData.value
                }
                Text {
                    anchors.left: parent.left
                    visible: stationTableView_.getColumn(styleData.column)===stypeColumn_?true:false
                    text: styleData.value
                }
            }

            onClicked: {
                console.log(currentRow)
                if(pop_station_.udflag === 0){
                    upModel_.set(currentRow,{"checked":!upModel_.get(currentRow).checked})
                }
                else if(pop_station_.udflag === 1){
                    downModel_.set(currentRow,{"checked":!downModel_.get(currentRow).checked})
                }
            }

            onDoubleClicked: {
                if(pop_station_.udflag === 0){
                    sIDText_.text = upModel_.get(currentRow).ID
                    snameZhText_.text = upModel_.get(currentRow).nameZh
                    snameEnText_.text = upModel_.get(currentRow).nameEn
                    sLongItudeText_.text = upModel_.get(currentRow).LongItude
                    sLatItudeText_.text = upModel_.get(currentRow).LatItude
                    sInRadiusText_.text = upModel_.get(currentRow).InRadius
                    sOutRadiusText_.text = upModel_.get(currentRow).OutRadius
                    sSpeedLimitText_.text = upModel_.get(currentRow).SpeedLimit
                }
                else if(pop_station_.udflag === 1){
                    sIDText_.text = downModel_.get(currentRow).ID
                    snameZhText_.text = downModel_.get(currentRow).nameZh
                    snameEnText_.text = downModel_.get(currentRow).nameEn
                    sLongItudeText_.text = downModel_.get(currentRow).LongItude
                    sLatItudeText_.text = downModel_.get(currentRow).LatItude
                    sInRadiusText_.text = downModel_.get(currentRow).InRadius
                    sOutRadiusText_.text = downModel_.get(currentRow).OutRadius
                    sSpeedLimitText_.text = downModel_.get(currentRow).SpeedLimit
                }


                pop_stationAdd_.sCurrentRow = currentRow
                pop_stationAdd_.smodifyFlag = 1
                pop_stationAdd_.open()
            }
        }

        onOpened: {
            stationTableView_.model = upModel_
        }
    }//pop_station_

    //按钮  添加按钮 删除按钮
    Rectangle{
        width: parent.width
        height: 50

        RowLayout{
            x: 8
            spacing: 8

            Button{
                id: button_lineAdd_
                text: qsTr("添加路线")
                implicitWidth: 80
                implicitHeight: 30

                onClicked: {
                    pop_addText_.text = qsTr("添加路线")
                    pop_lineAdd_.open()
                }
            }
            Button{
                id: button_lineDel_
                text: qsTr("删除线路")
                implicitWidth: 80
                implicitHeight: 30

                onClicked: {
                    var delID
                    for(var i=0;i<lineModel_.count;i++){
                        if(lineModel_.get(i).checked===true){
                            delID = lineModel_.get(i).ID
                            lineModel_.remove(i)
                            i--
                            delLine(delID)
                        }
                    }
                }
            }
            Button{
                text: qsTr("导出配置文件")
                implicitWidth: 80
                implicitHeight: 30

                onClicked: {
                    transModel()
                }
            }
        }
    }//Rectangle

    Item{
        x: 0
        y: 50
        width: parent.width
        height: parent.height - 50

        TableView{
            id: lineTableView_
            anchors.fill: parent
            model: lineModel_

            TableViewColumn{id: checkedColumn_;title:qsTr("选择");role: "checked";width: 80}
            TableViewColumn{id: typeColumn_;title: qsTr("线路类型");role: "type";width: 100}
            TableViewColumn{id: nameZhColumn_;title: qsTr("中文线路名");role: "nameZh";width: 200}
            TableViewColumn{id: nameEnColumn_;title: qsTr("英文线路名");role: "nameEn";width: 200}
            TableViewColumn{id: idColumn_;title: qsTr("线路ID");role: "ID";width: 100}
            TableViewColumn{id: styleColumn_;title: qsTr("报站风格");role: "style";width: 100}
            TableViewColumn{id: setColumn_;title: qsTr("设置站点");role: "set";width: 100}


            itemDelegate: Item {
                id: lineDelegate_

                CheckBox{
                    anchors.centerIn: parent
                    checked: styleData.value
                    visible: lineTableView_.getColumn(styleData.column)===checkedColumn_?true:false
                }
                Text{
                    text: styleData.value
                    visible: lineTableView_.getColumn(styleData.column)===typeColumn_?true:false
                }
                Text {
                    text: styleData.value
                    visible: lineTableView_.getColumn(styleData.column)===nameZhColumn_?true:false
                }
                Text{
                    text: styleData.value
                    visible: lineTableView_.getColumn(styleData.column)===nameEnColumn_?true:false
                }
                Text{
                    text: styleData.value
                    visible: lineTableView_.getColumn(styleData.column)===idColumn_?true:false
                }
                Text {
                    text: styleData.value
                    visible: lineTableView_.getColumn(styleData.column)===styleColumn_?true:false
                }

                Button{
                    anchors.fill: parent
                    visible: lineTableView_.getColumn(styleData.column)===setColumn_?true:false
                    Label{
                        anchors.fill: parent
                        text: qsTr("设置站点")
                    }
                    onClicked: {
                        pop_stationAdd_.lineID = lineModel_.get(styleData.row).ID
                        setstLineIdText_.text = qsTr("线路ID:"+lineModel_.get(styleData.row).ID)
                        setStation()
                        pop_station_.udflag = 0;
                        pop_saddText_.text = qsTr("添加上行站点")
                        pop_station_.open()
                    }

                }
            }

            onClicked: {
                lineModel_.set(currentRow,{"checked":!lineModel_.get(currentRow).checked})
            }

            onDoubleClicked: {
                pop_addText_.text = "修改线路"
                pop_lineAdd_.modifyFlag = 1
                addTypeText_.text = lineModel_.get(currentRow).type
                addnameZhText_.text = lineModel_.get(currentRow).nameZh
                addnameEnText_.text = lineModel_.get(currentRow).nameEn
                addidText_.text = lineModel_.get(currentRow).ID
                pop_lineAdd_.modifyRow = currentRow
                pop_lineAdd_.open()
            }

        }
    }//lineTableView_
}
