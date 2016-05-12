#include "imageChange.h"
#include <QFileInfo>
#include <QDebug>
#include <QDirIterator>


QString imageChange::path=QString("/home/nemo/Pictures/");
QString imageChange::picFormat=QString(".jpg");
imageChange::imageChange(QObject* parent)
    :QObject(parent)
{
    //构造函数.
}

imageChange::~imageChange()
{
    //析构.
}

QStringList imageChange::getFileList(const QVariant& url)
{
    QDir path(url.toString());
    if( !path.exists()){//判断该路径是否存在.
        qDebug()<<"failed";
    }
    //QStringList manyPath;
    QStringList filePathList;
    QStringList filters;
    filters<<QString("*.jpg")<<QString("*.png")<<QString("*.jpeg");
    QDirIterator dirIterator(url.toString(), filters, QDir::Files|QDir::NoSymLinks, QDirIterator::Subdirectories);
    while(dirIterator.hasNext()){
        QString thePath;
        //QString m_Path;
        thePath=dirIterator.next();
        filePathList.append(thePath);//get pictures;
        //m_Path=dirIterator.path();
        //manyPath.append(m_Path);
    }
    filePathList.sort(Qt::CaseInsensitive);
    /*manyPath.sort(Qt::CaseSensitive);
    QList<QString>::const_iterator iter=manyPath.begin();
    qDebug()<<manyPath.size()<<"=.="<<manyPath.at(20);
    qDebug()<<"size:"<<filePathList.size();
    QDir otherDir;
    otherDir.setPath(QString("/home/nemo/"));
    QList<QString> sList;
    sList<<"*";
    QFileInfoList fileInfoL= otherDir.entryInfoList(sList,QDir::AllEntries, QDir::DirsFirst);
    QList<QString> pList;
    for(int i=0; i<fileInfoL.size(); ++i){
        QString fileName=fileInfoL.at(i).filePath();
        qDebug()<<fileName;
        pList.append(fileName);
    }*/
    /*QStringList fList,getAllPath;
    fList<<QString("*");
    QDirIterator dIter(url.toString(), fList, QDir::AllDirs, QDirIterator::Subdirectories);
    while(dIter.hasNext()){
        QString getP;
        getP=dIter.next();
        getAllPath.append(getP);
    }
    for(int x=0; x<getAllPath.size(); ++x){
        qDebug()<<getAllPath[x];
    }*/

    return filePathList;
}


int imageChange::getNumber(const QStringList& list)
{
    return list.size();
}

QString imageChange::getFileName(const QStringList& nameList, const int& index)
{
    return nameList[index];
}

void imageChange::whiteBlack(const QVariant& picture, const QVariant& savePath)
{
    QImage image;
    image.load(picture.toString());
    qDebug()<<picture.toString();
    if(image.isNull()){
        qDebug()<<"failed";
    }
    int width = image.width();
    int height = image.height();
    qDebug()<<width;
    qDebug()<<height;
    QRgb color;
    QRgb avg;
    QRgb black = qRgb(0,0,0);
    QRgb white = qRgb(255,255,255);
    for(int i=0; i<width; ++i){
        for(int j=0; j<height; ++j){
            color = image.pixel(i, j);
            avg = (qRed(color) + qGreen(color) + qBlue(color))/3;
            image.setPixel(i,j,avg >= 128? white :black);
        }
    }
    image.save(savePath.toString());
    return;
}

void imageChange::negative(const QVariant& picture, const QVariant& savePath)
{
    QImage image;
    image.load(picture.toString());
    qDebug()<<picture.toString();
    if(image.isNull()){
        qDebug()<<"failed";
        return;
    }
    int width=image.width();
    int height=image.height();
    QRgb color;
    QRgb negativeP;
    for(int i=0; i <width; i++){
        for(int j=0; j<height; ++j){
            color=image.pixel(i,j);
            negativeP=qRgba(255-qRed(color), 255-qGreen(color), 255-qBlue(color), qAlpha(color));
            image.setPixel(i, j, negativeP);
        }
    }

    image.save(savePath.toString());
    return;
}

void imageChange::deleteItem(const QVariant& picture)
{
    QFile file(picture.toString());
    qDebug()<<picture.toString();
    if(file.remove()){
        qDebug()<<"successful";
    }else{
        qDebug()<<"failed";
    }
}

void imageChange::grayForPic(const QVariant& picture,const QVariant& savePath)
{
    QImage image(picture.toString());
    if(image.isNull()){
        qDebug()<<"failed";
        return;
    }
    int width=image.width();
    int height=image.height();
    QRgb color;
    int gray;
    for(int i=0; i<width; ++i){
        for(int j=0; j<height; ++j){
            color=image.pixel(i, j);
            gray=qGray(color);
            image.setPixel(i, j,qRgba(gray, gray, gray, qAlpha(color)));
        }
    }
    image.save(savePath.toString());
    return;
}

QVariant imageChange::getCurrentTime()
{
    QDate nowDate=QDate::currentDate();
    QTime nowTime=QTime::currentTime();
    QString sTr;
    sTr=QString("%1%2%3%4%5%6").arg(nowDate.year())
                                .arg(nowDate.month())
                                .arg(nowDate.day())
                                .arg(nowTime.hour())
                                .arg(nowTime.minute())
                                .arg(nowTime.second());
    return QVariant(sTr);
}

QVariant imageChange::saveCvsPic(const QVariant& dataUrl,const QVariant& backgroundPic)
{
    QImage img;
    img.loadFromData(QByteArray::fromBase64(dataUrl.toString().split(",").at(1).toLatin1()),"png");

    QVariant cTime=this->getCurrentTime();
    /*if(img.save(this->path+cTime.toString()+this->picFormat)){
        qDebug()<<"successful";
        return QVariant(this->path+cTime.toString()+this->picFormat);
    }else{
        return QVariant("");
    }*/
    QImage bgImg;
    if(bgImg.load(backgroundPic.toString())){
        qDebug()<<"loacal:"<<QUrl(backgroundPic.toString()).toLocalFile();
        QPainter paint;
        paint.begin(&img);
        paint.setCompositionMode(QPainter::CompositionMode_DestinationOver);
        paint.drawImage(QRectF(img.rect()), bgImg, bgImg.rect());
        paint.end();
    }
    if(img.save(this->path+cTime.toString()+this->picFormat)){
            qDebug()<<"successful";
            return QVariant(this->path+cTime.toString()+this->picFormat);
        }else{
            return QVariant("");
        }
}

QList<int> imageChange::getWH(const QVariant& url)
{
    QImage img;
    if(img.load(url.toString())){
        qDebug()<<"succes";
    }
    QList<int> forWH;
    forWH.append(img.width());
    forWH.append(img.height());
    if(!forWH.isEmpty()){
        return forWH;
    }
    return QList<int>();
}


