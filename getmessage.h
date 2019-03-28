#ifndef GETMESSAGE_H
#define GETMESSAGE_H

#include <QObject>
#include <QString>
#include <QDebug>
#include <QList>
#include <QMap>
#include <QFile>
#include <iostream>
#include <QTextStream>
#include <QDir>

class getMessage : public QObject
{
    Q_OBJECT
public:
    explicit getMessage(QObject *parent = nullptr);

    bool mkDirFile(const QString dirPa, const QString SPa, const QString XPa, const QString stylePa);

public slots:
    void setAgreement(const QString agreement);
    void setSerialPort(const QString serialPort);

    QString getAgreement();
    QString getSerialPort();

    void exportMsg();

    void getLineModel(const QString type, const QString nameZh, const QString nameEn,
                      const QString style, const QString ID);
    void getUpModel(const QString ordinal, const QString ID, const QString nameZh, const QString nameEn,
                    const QString LongItude, const QString LatItude,const QString InRadius, const QString OutRadius,
                    const QString SpeedLimit, const QString type);
    void getDownModel(const QString ordinal, const QString ID, const QString nameZh, const QString nameEn,
                     const QString LongItude, const QString LatItude,const QString InRadius, const QString OutRadius,
                     const QString SpeedLimit, const QString type);
    void getFOModel(const QString content,const QString type,
                    const QString speaker,const QString mylanguage);
    void getGIModel(const QString content,const QString type,
                    const QString speaker,const QString mylanguage);
    void getGOModel(const QString content,const QString type,
                    const QString speaker,const QString mylanguage);
    void getTIModel(const QString content,const QString type,
                    const QString speaker,const QString mylanguage);

    void clearModel();
    void eSXFile(const QString Path, const QList<QMap<QString, QString> > model);
    void eStyleFile(const QString Path);

signals:
    void exporeSXFile(const QString Path,const QList<QMap<QString,QString>> model);
    void exporeStyleFile(const QString Path);
private:
    QString m_Agreement;
    QString m_SerialPort;

    QMap<QString,QString> m_lineModel;
    QList<QMap<QString,QString>> m_upModel;
    QList<QMap<QString,QString>> m_dowModel;
    QList<QMap<QString,QString>> m_firOutModel;
    QList<QMap<QString,QString>> m_genInModel;
    QList<QMap<QString,QString>> m_genOutModel;
    QList<QMap<QString,QString>> m_terInModel;
};

#endif // GETMESSAGE_H
