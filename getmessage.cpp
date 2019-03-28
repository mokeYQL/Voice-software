#include "getmessage.h"

getMessage::getMessage(QObject *parent) : QObject(parent)
{
    connect(this,SIGNAL(exporeSXFile(QString,QList<QMap<QString,QString> >)),this,SLOT(eSXFile(QString,QList<QMap<QString,QString> >)));
    connect(this,SIGNAL(exporeStyleFile(QString)),this,SLOT(eStyleFile(QString)));
}

void getMessage::exportMsg()
{
    const QString dirPath = "C:/"+m_lineModel.value("ID")+"/线路文件/"+m_lineModel.value("ID");
    const QString SPath = m_lineModel.value("ID")+"S.csv";
    const QString XPath = m_lineModel.value("ID")+"X.csv";
    const QString stylePath = m_lineModel.value("ID")+"StyleConfig.csv";

    if(mkDirFile(dirPath,SPath,XPath,stylePath)){
        emit exporeSXFile(SPath,m_upModel);
        emit exporeSXFile(XPath,m_dowModel);
        emit exporeStyleFile(stylePath);
    }
}

bool getMessage::mkDirFile(const QString dirPa,const QString SPa,const QString XPa,const QString stylePa)
{
    const QString dirPath = dirPa;
    const QString SPath = SPa;
    const QString XPath = XPa;
    QDir *folder = new QDir;
    if(folder->exists(dirPath)){
        qDebug()<<"线路已存在";
    }
    else {
        if(folder->mkpath(dirPath)){
            qDebug()<<"文件夹创建成功";
        }
        else {
            qDebug()<<"文件夹创建失败";
            return false;
        }
    }

    QDir tempDir;
    tempDir.setCurrent(dirPath);
    QFile *tempFile = new QFile;
    if(tempFile->exists(SPath)){
        qDebug()<<"文件存在";
    }
    else{
        tempFile->setFileName(SPath);
        if(!tempFile->open(QIODevice::WriteOnly|QIODevice::Text)){
            qDebug()<<"文件打开失败";
            return false;
        }
    }
    tempFile->close();

    if(tempFile->exists(XPath)){
        qDebug()<<"文件存在";
    }
    else{
        tempFile->setFileName(XPath);
        if(!tempFile->open(QIODevice::WriteOnly|QIODevice::Text)){
            qDebug()<<"文件打开失败";
            return false;
        }
    }
    tempFile->close();

    if(tempFile->exists(stylePa)){
        qDebug()<<"文件存在";
    }
    else{
        tempFile->setFileName(stylePa);
        if(!tempFile->open(QIODevice::WriteOnly|QIODevice::Text)){
            qDebug()<<"文件打开失败";
            return false;
        }
    }
    tempFile->close();

    delete folder;
    delete tempFile;

    return true;
}

void getMessage::setAgreement(const QString agreement)
{
    m_Agreement = agreement;
}

void getMessage::setSerialPort(const QString serialPort)
{
    m_SerialPort = serialPort;
}

QString getMessage::getAgreement()
{
    return m_Agreement;
}

QString getMessage::getSerialPort()
{
    return m_SerialPort;
}

void getMessage::getLineModel(const QString type, const QString nameZh, const QString nameEn,
                              const QString style, const QString ID)
{
    qDebug()<<"__func__getLineModel__";

    m_lineModel["type"]=type;
    m_lineModel["nameZh"]=nameZh;
    m_lineModel["nameEn"]=nameEn;
    m_lineModel["style"]=style;
    m_lineModel["ID"]=ID;

//    QMap<QString,QString>::const_iterator i;
//    for(i=m_lineModel.constBegin();i!=m_lineModel.constEnd();++i){
//        qDebug()<<i.key()<<":"<<i.value();
//    }

//    exportMsg();
}

void getMessage::getUpModel(const QString ordinal, const QString ID, const QString nameZh, const QString nameEn,
                            const QString LongItude, const QString LatItude,const QString InRadius, const QString OutRadius,
                            const QString SpeedLimit, const QString type)
{
    qDebug("__func__getUpModel__");

    QMap<QString,QString> map;
    map["ordinal"]=ordinal;
    map["ID"]=ID;
    map["nameZh"]=nameZh;
    map["nameEn"]=nameEn;
    map["LongItude"]=LongItude;
    map["LatItude"]=LatItude;
    map["InRadius"]=InRadius;
    map["OutRadius"]=OutRadius;
    map["SpeedLimit"]=SpeedLimit;
    map["type"]=type;
    m_upModel.append(map);


//    QMap<QString,QString>::const_iterator iterator;
//    QMap<QString,QString> itMap;
//    for(int i=0; i<m_upModel.count();i++){
//        itMap = m_upModel.at(i);
//        for(iterator=itMap.constBegin();iterator!=itMap.constEnd();++iterator){
//            qDebug()<<iterator.key()<<":"<<iterator.value();
//        }
//    }
}

void getMessage::getDownModel(const QString ordinal, const QString ID, const QString nameZh, const QString nameEn,
                             const QString LongItude, const QString LatItude,const QString InRadius, const QString OutRadius,
                             const QString SpeedLimit, const QString type)
{
    qDebug()<<"__func__getDownModel__";

    QMap<QString,QString> map;
    map["ordinal"]=ordinal;
    map["ID"]=ID;
    map["nameZh"]=nameZh;
    map["nameEn"]=nameEn;
    map["LongItude"]=LongItude;
    map["LatItude"]=LatItude;
    map["InRadius"]=InRadius;
    map["OutRadius"]=OutRadius;
    map["SpeedLimit"]=SpeedLimit;
    map["type"]=type;
    m_dowModel.append(map);

//    QMap<QString,QString>::const_iterator x;
//    QMap<QString,QString> itMap;
//    for(int i=0; i<m_dowModel.count();i++){
//        itMap = m_dowModel.at(i);
//        for(x=itMap.constBegin();x!=itMap.constEnd();++x){
//            qDebug()<<x.key()<<":"<<x.value();
//        }
//    }
}

void getMessage::getFOModel(const QString content,const QString type,
                            const QString speaker,const QString mylanguage)
{
    qDebug()<<"__func__getFOModel__";

    QMap<QString,QString> map;
    map["content"]=content;
    map["type"]=type;
    map["speaker"]=speaker;
    map["mylanguage"]=mylanguage;
    m_firOutModel.append(map);

//    QMap<QString,QString>::const_iterator iterator;
//    QMap<QString,QString> itMap;
//    for(int i=0; i<m_firOutModel.count();i++){
//        itMap = m_firOutModel.at(i);
//        for(iterator=itMap.constBegin();iterator!=itMap.constEnd();++iterator){
//            qDebug()<<iterator.key()<<":"<<iterator.value();
//        }
//    }
}

void getMessage::getGIModel(const QString content,const QString type,
                            const QString speaker,const QString mylanguage)
{
    qDebug()<<"__func__getGIModel__";

    QMap<QString,QString> map;
    map["content"]=content;
    map["type"]=type;
    map["speaker"]=speaker;
    map["mylanguage"]=mylanguage;
    m_genInModel.append(map);

//    QMap<QString,QString>::const_iterator iterator;
//    QMap<QString,QString> itMap;
//    for(int i=0; i<m_genInModel.count();i++){
//        itMap = m_genInModel.at(i);
//        for(iterator=itMap.constBegin();iterator!=itMap.constEnd();++iterator){
//            qDebug()<<iterator.key()<<":"<<iterator.value();
//        }
//    }
}

void getMessage::getGOModel(const QString content,const QString type,
                            const QString speaker,const QString mylanguage)
{
    qDebug()<<"__func__getGOModel__";

    QMap<QString,QString> map;
    map["content"]=content;
    map["type"]=type;
    map["speaker"]=speaker;
    map["mylanguage"]=mylanguage;
    m_genOutModel.append(map);

//    QMap<QString,QString>::const_iterator iterator;
//    QMap<QString,QString> itMap;
//    for(int i=0; i<m_genOutModel.count();i++){
//        itMap = m_genOutModel.at(i);
//        for(iterator=itMap.constBegin();iterator!=itMap.constEnd();++iterator){
//            qDebug()<<iterator.key()<<":"<<iterator.value();
//        }
//    }
}

void getMessage::getTIModel(const QString content,const QString type,
                            const QString speaker,const QString mylanguage)
{
    qDebug()<<"__func__getTIModel__";

    QMap<QString,QString> map;
    map["content"]=content;
    map["type"]=type;
    map["speaker"]=speaker;
    map["mylanguage"]=mylanguage;
    m_terInModel.append(map);

//    QMap<QString,QString>::const_iterator iterator;
//    QMap<QString,QString> itMap;
//    for(int i=0; i<m_terInModel.count();i++){
//        itMap = m_terInModel.at(i);
//        for(iterator=itMap.constBegin();iterator!=itMap.constEnd();++iterator){
//            qDebug()<<iterator.key()<<":"<<iterator.value();
//        }
//    }
}

void getMessage::clearModel()
{
    m_lineModel.clear();
    m_upModel.clear();
    m_dowModel.clear();
    m_firOutModel.clear();
    m_genInModel.clear();
    m_genOutModel.clear();
    m_terInModel.clear();
}

void getMessage::eSXFile(const QString Path, const QList<QMap<QString, QString> > model)
{
    QFile file(Path);
    if(!file.open(QIODevice::WriteOnly|QIODevice::Text)){
        qDebug()<<"failed to open file";
        return;
    }
    QTextStream out(&file);

    //row 1
    out<<tr("头牌显示,")<<tr("显示方式,")<<tr("线路名,")<<tr(",")
      <<tr("腰牌显示,")<<tr("显示方式,")<<tr(",")<<tr(",")
     <<tr("尾牌显示,")<<tr("显示方式")<<tr(",\n");
    //row 2
    out<<tr(",\n");
    //row 3
    out<<tr("站点序号,")<<tr("站点编号,")<<tr("站点类型（0：正常站点 1：转弯站点）,")
      <<tr("站名,")<<tr("纬度,")<<tr("经度,")<<tr("进站半径,")
     <<tr("出站半径,")<<tr("限速,")<<tr("第一语种,")<<tr("第二语种,")<<tr(",\n");

    for(int i=0;i<model.count();i++){
        out<<QString::number(i)+tr(",")
          <<model.at(i).value("ordinal")+tr(",")
         <<tr("0,")
        <<model.at(i).value("nameZh")+tr(",")
        <<model.at(i).value("LatItude")+tr(",")
        <<model.at(i).value("LongItude")+tr(",")
        <<model.at(i).value("InRadius")+tr(",")
        <<model.at(i).value("OutRadius")+tr(",")
        <<model.at(i).value("SpeedLimit")+tr(",")
        <<model.at(i).value("nameZh")+tr("_N,")+tr(",\n");
    }

    file.close();
}

void getMessage::eStyleFile(const QString Path)
{
    QFile file(Path);
    if(!file.open(QIODevice::WriteOnly|QIODevice::Text)){
        qDebug()<<"failed to open file";
        return;
    }
    QTextStream out(&file);

    out<<tr("起点语音,");


}
