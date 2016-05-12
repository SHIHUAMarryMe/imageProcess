import QtQuick 2.0
import Sailfish.Silica 1.0
import an.qt.imageChange 1.0

Page{
    id:canvasPage;
    property string picName;
    property var listWH;
    ImageChange{
        id:imageChange;
    }
    Component.onCompleted:{
        console.log(picName);
        listWH=imageChange.getWH(picName);
        console.log(listWH[1], listWH[0]);
        //console.log(showImg);
    }
    Image{
        id:showImg;
        source:picName;
        height:parent.height*4/5;
        width:parent.width;
        anchors.centerIn:parent;
        fillMode:Image.PreserveAspectFit;
    Canvas{
        id:canvasForPic;
        property int theX;
        property int theY;
        //property bool juge:true;
        width:parent.width;
        height:parent.height*4/5;
        antialiasing:true;
        anchors.centerIn:parent;
        onPaint:{
            var ctx=getContext("2d");
            /*if(juge){
            ctx.beginPath();
            ctx.drawImage(picName,0,0,parent.width,parent.height*4/5);
            ctx.fill();
            ctx.closePath();
            ctx.save();
            ctx.restore();
                juge=false;
            }*/

            ctx.lineWidth=4;
            ctx.strokeStyle="red";
            ctx.beginPath();
            ctx.moveTo(theX,theY);
            theX=mouseA.mouseX;
            theY=mouseA.mouseY;
            ctx.lineTo(theX,theY);
            ctx.stroke();
            ctx.closePath();
            ctx.save();
            ctx.restore();
        }
        MouseArea{
            id:mouseA;
            anchors.fill:parent;
            onPressed:{
                canvasForPic.theX=mouseA.mouseX;
                canvasForPic.theY=mouseA.mouseY;
            }
            onPositionChanged:{
                canvasForPic.requestPaint();
            }
        }
    }
 }
    Button{
        id:saveCvsPic;
        text:qsTr("save");
        anchors{
            bottom:parent.bottom;
            horizontalCenter:parent.horizontalCenter;
        }
        onClicked:{
            var data=canvasForPic.toDataURL();
            imageChange.saveCvsPic(data,picName);
            //console.log(data);
        }
    }
}
