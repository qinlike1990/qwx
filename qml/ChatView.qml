// Copyright (C) 2014 Leslie Zhai <xiang.zhai@i-soft.com.cn>

import QtQuick 2.2
import QtQuick.Controls 1.1
import cn.com.isoft.qwx 1.0

Item {
    id: chatView
    width: parent.width; height: parent.height

    property string uin
    property string sid
    property string skey
    property string fromUserName
    property string toUserName
    property string toNickName

    SendMsg {
        id: sendMsgObj
    }

    ListModel {
        id: chatListModel

        ListElement { content: "" }
    }

    ListView {
        id: chatListView
        model: chatListModel
        width: parent.width; height: parent.height - backImage.height - 
        sendMsgTextField.height
        anchors.top: backImage.bottom
        spacing: 10
        delegate: Item {
            height: 60
   
            HeadImg {
                id: fromUserHeadImgObj 
                userName: chatView.fromUserName 
                onFilePathChanged: { 
                    fromUserHeadImage.source = fromUserHeadImgObj.filePath 
                }
            }

            Image {
                id: fromUserHeadImage
                width: 42; height: 42
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Rectangle {
                color: "#b3d073"
                width: content.length * 12; height: parent.height
                anchors.left: fromUserHeadImage.right
                anchors.leftMargin: 10

                Text { 
                    text: content 
                    font.pixelSize: 12 
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
            }
        }
    }

    Rectangle {                                                            
        id: chatHeader                                                
        width: parent.width; height: 58                                    
        anchors.top: parent.top                                            
        color: "#20282a"                                                   

        Image {
            id: backImage
            source: "../images/back.png"
            width: 36; height: 36
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 19

            MouseArea {
                anchors.fill: parent
                onClicked: { navigatorStackView.pop() }
            }
        }

        Text {                                                             
            text: chatView.toNickName
            font.pixelSize: 22                                             
            anchors.verticalCenter: parent.verticalCenter                  
            anchors.left: backImage.right
            anchors.leftMargin: 19                                         
            color: "white"                                                 
        }                                                                  
    }

    TextField {
        id: sendMsgTextField
        width: parent.width - sendButton.width
        anchors.bottom: parent.bottom
    }

    Button {
        id: sendButton
        text: "发送"
        anchors.top: sendMsgTextField.top
        anchors.right: parent.right
        onClicked: {
            sendMsgObj.post(chatView.uin, 
                            chatView.sid, 
                            chatView.skey, 
                            chatView.fromUserName, 
                            chatView.toUserName, 
                            sendMsgTextField.text)
            chatListModel.append({"content": sendMsgTextField.text})
            sendMsgTextField.text = ""
        }
    }
}