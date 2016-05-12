#ifndef IAMGECHANGE_H
#define IAMGECHANGE_H
#include <QtGui>
#include <QVariant>
#include <QString>
#include <QDir>
#include <QQuickImageProvider>

class imageChange : public QObject
{
    Q_OBJECT
public:
    imageChange(QObject *parent=0);
    ~imageChange();
    Q_INVOKABLE QStringList getFileList(const QVariant& url);
    Q_INVOKABLE int getNumber(const QStringList& list);
    Q_INVOKABLE QString  getFileName(const QStringList& nameList,const int& index);
    Q_INVOKABLE static void whiteBlack(const QVariant& picture,const QVariant& savePath);
    Q_INVOKABLE QVariant getCurrentTime();
    Q_INVOKABLE QVariant saveCvsPic(const QVariant& dataUrl,const QVariant& backgroundPic);
    Q_INVOKABLE QList<int> getWH(const QVariant& url);
public slots:
    static void negative(const QVariant& picture, const QVariant& savePath);
    void deleteItem(const QVariant& picture);
    static void grayForPic(const QVariant& picture,const QVariant& savePath);
private:
    static QString path;
    static QString picFormat;
};

#endif // IAMGECHANGE_H
