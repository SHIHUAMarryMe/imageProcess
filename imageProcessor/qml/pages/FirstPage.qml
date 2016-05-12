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
    property string path:"/home/nemo/Pictures/";
    property var list;
    property int number;
    ImageChange {
        id:imageChange;
    }
    PageHeader{
        title:qsTr("images");
    }

    Component.onCompleted:{
        list = imageChange.getFileList(path);
        number = imageChange.getNumber(imageChange.getFileList(path));
        console.log("have picture:"+number);
    }

    SilicaGridView{
        id:showPictures;
        anchors.fill:page;
        anchors.topMargin:page.height*1/8;
        cellWidth:page.width/5;
        cellHeight:page.width/5;
        model:number;
        delegate:pictures;
        snapMode:ListView.SnapOneItem;
        cacheBuffer: page.width;
    }

    Component {
        id:pictures;
        Item{
            width:page.width/5;
            height:page.width/5;
            clip:true;
            smooth:true;
        Image {
            id:images;
            anchors.fill:parent;
            sourceSize.height:page.width/5;
            asynchronous:true;
            smooth:true;
            source:imageChange.getFileName(imageChange.getFileList(path), index);
            MouseArea {
                id:clickToSecondPage;
                anchors.fill:parent;
                onClicked:{
                    pageStack.push(Qt.resolvedUrl("SecondPage.qml"),{ pictureName :  imageChange.getFileName(imageChange.getFileList(path), index) });
                }
            }
            BusyIndicator {
                id:wait;
                anchors.centerIn:parent;
                z:2;
                running:false;
            }
            onStatusChanged:{
                if(images.status === Image.Loading){
                    wait.running=true;
                }else{
                    wait.running=false;
                }
            }
        }
    }
}
}


