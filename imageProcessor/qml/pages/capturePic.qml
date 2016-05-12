import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import an.qt.imageChange 1.0

Page{
    id:captureForPic;
    ImageChange{
        id:imageChange;
    }

    Camera{
        id:camera;
        focus{
            focusMode:Camera.FocusAuto;
            focusPointMode:Camera.FocusPointCenter;
        }
        imageProcessing{
            whiteBalanceMode:CameraImageProcessing.WhiteBalanceAuto;

        }
        flash{
            mode:Camera.FlashAuto;
        }
        imageCapture{
            //resolution:Qt.size(960,540);
            onImageCaptured:{
                camera.stop();
            }
            onImageSaved:{

            }
        }
        onLockStatusChanged:{
            switch(lockStatus){
            case Camera.Locked:
                imageCapture.captureToLocation("/home/nemo/Pictures/"+imageChange.getCurrentTime().toString()+".jpg");
                unlock();
                break;
            case Camera.Searching:
                break;
            case Camera.Unlocked:
                break;
            }
        }
    }
    VideoOutput{
        id:outputV;
        source:camera;
        anchors.fill:parent;
    }
    Rectangle{
        id:toolRect;
        width:parent.width;
        height:parent.height*1/10;
        color:"black";
        anchors{
            bottom:parent.bottom;
            horizontalCenter:parent.horizontalCenter;
        }
        IconButton{
            icon.source:"image://theme/icon-m-camera";
            anchors{
                bottom:parent.bottom;
                horizontalCenter:parent.horizontalCenter;
            }
            onClicked:{
                camera.start();
                camera.searchAndLock();
            }

        }
    }
}
