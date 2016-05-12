import QtQuick 2.0
import Sailfish.Silica 1.0

Page{
            id:page;
            Button{
                id:choseP;
                width:parent.width*1/3;
                text:qsTr("chose a pic");
                anchors.centerIn:page;
                onClicked:{
                    pageStack.push( Qt.resolvedUrl("FirstPage.qml") );
                }
            }
            Button{
                id:takeP;
                width:parent.width*1/3;
                text:qsTr("take a pic");
                anchors{
                    top:choseP.bottom;
                    topMargin:Theme.paddingLarge;
                    horizontalCenter:choseP.horizontalCenter;
                }
                onClicked:{
                    pageStack.push(Qt.resolvedUrl("capturePic.qml"));
                }
            }

            SilicaFlickable{
                width:page.width;
                height:page.height/2.5;
                PullDownMenu{
                    MenuItem {
                        text:"about";
                        onClicked:{
                            pageStack.push(Qt.resolvedUrl("about.qml"));
                        }
                    }
                }
            }
        }
