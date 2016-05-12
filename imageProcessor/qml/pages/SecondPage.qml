/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import an.qt.imageChange 1.0

Page {
    id: page;
    property string pictureName;
    property string savePath : "/home/nemo/Pictures/"
    property string currentTime;
    property string pictureSaveName;
        Image{
        id:showPicture;
        width:parent.width;
        height:parent.height*5/6;
        anchors.centerIn:parent;
        fillMode:Image.PreserveAspectFit;
        source: pictureName;
        Component.onCompleted:{
            console.log(pictureName);
        }
        }
        PinchArea {
            pinch.target:showPicture;
            anchors.fill:parent;
            pinch.maximumScale:20;
            pinch.minimumScale:0.2;
            pinch.minimumRotation:0;
            pinch.maximumRotation:180;
            pinch.dragAxis:Pinch.XandYAxis;
            onPinchStarted:{
                button.visible=false;
            }
            onPinchFinished:{
                button.visible=true;
            }
        }
        ImageChange {
            id:imageChange;
        }
        Component.onCompleted:{
            currentTime = Date.now();
            console.log(currentTime);
            pictureSaveName = savePath + currentTime.toString() + ".jpg";
            console.log(pictureSaveName);
        }
        SilicaFlickable {
            id:toAbout;
            width:page.width;
            height:page.height/3;
            PullDownMenu {
                MenuItem {
                    text:qsTr("delete");
                    onClicked:{
                        imageChange.deleteItem(pictureName);
                        pageStack.push( Qt.resolvedUrl("FirstPage.qml") );
                    }
                }
                MenuItem{
                    text:qsTr("negative");
                    onClicked:{
                        console.log(pictureName);
                        imageChange.negative(pictureName, pictureSaveName);
                        showPicture.source=pictureSaveName;
                        canvasBtn.visible=false;
                    }
                }
                MenuItem{
                    text:qsTr("gray");
                    onClicked:{
                        console.log(pictureName);
                        imageChange.grayForPic(pictureName, pictureSaveName);
                        showPicture.source=pictureSaveName;
                        canvasBtn.visible=false;
                    }
                }
                MenuItem{
                    text:qsTr("white-black");
                    onClicked:{
                        imageChange.whiteBlack(pictureName, pictureSaveName);
                        showPicture.source=pictureSaveName;
                        canvasBtn.visible=false;
                    }
                }
            }
        }
        Button{
            id:canvasBtn;
            visible:true;
            text:qsTr("drawOnPic");
            width:parent.width*1/4;
            anchors{
                bottom:page.bottom;
                horizontalCenter:page.horizontalCenter;
            }
            onClicked:{
                pageStack.push(Qt.resolvedUrl("drawInPic.qml"),{picName : page.pictureName})
            }
        }
}





