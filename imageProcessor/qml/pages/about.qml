import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id:page;
    PageHeader{
        title:qsTr("about")
    }

    Text {
        id:statement;
        anchors.centerIn:page;
        text:qsTr("By:SHIHUA,蝉曦,bridZhang");
        color:"white";
        font.pixelSize:40;
    }
    Text {
        id:statementT
        anchors{
            top:statement.bottom;
            margins:10;
            horizontalCenter:statement.horizontalCenter;
        }
        color:"white";
        font.pixelSize:40;
        text:qsTr("fisheggs,saber");
    }
    Image {
        id:tubiao;
        source:"images/tubiao.png";
        anchors{
            bottom:statement.top;
            margins:10;
            horizontalCenter:statement.horizontalCenter;
        }
    }

    Text{
        id:version;
        text:qsTr("version:1.5.9");
        anchors{
            top:statementT.bottom;
            horizontalCenter:statementT.horizontalCenter;
        }
        color:"white";
        font.pixelSize:40;
    }
}
