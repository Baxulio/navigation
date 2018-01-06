/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0

FocusScope {
    id: root
    signal recipeSelected(url url)

    Component {
        id: sectionHeading
        Rectangle {

            width: listView.width
            height: sectionText.implicitHeight + 10
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                //width: sectionText.implicitWidth + 20
                height: sectionText.implicitHeight + 10
                color: Qt.rgba(0.9,0.9,0.9,0.5)
                anchors.centerIn: parent
                //radius: 10
                Text {
                    id: sectionText
                    anchors.centerIn: parent
                    text: qsTr(section)// + " :: Nurnazarov Bahman"
                    font.pixelSize: 10
                    color: "gray"
                }
                Text {
                    id: appendText
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 10
                    text: "+"// + " :: Nurnazarov Bahman"
                    font.pixelSize: 10
                    color: "gray"
                }

            }
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    appendText.text=="+"?appendText.text="-":appendText.text="+";
                    listView.sectionClicked(section);
                    //console.log(section);
                }
            }
        }
    }

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        ToolBar {
            id: headerBackground
            Layout.fillWidth: true
            implicitHeight: headerText.height + 20

            Label {
                id: headerText
                width: parent.width
                text: qsTr("DEUTSCH KOMPAKT")
                padding: 10
                anchors.centerIn: parent
            }
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            keyNavigationWraps: true
            clip: true
            focus: true
            ScrollBar.vertical: ScrollBar { }

            signal sectionClicked(string type)
            model: recipeModel

            delegate: ItemDelegate {
                id: it
                width: parent.width

                visible: shown
                height: shown ? mainText.implicitHeight + 20 : 0
                property bool shown: false

                Connections{
                    target: listView
                    onSectionClicked: if(it.ListView.section===type)shown = !shown;

                }

                contentItem: Text {
                    id: mainText
                    text: model.name + "<br><font color='gray' size=1><a title='class'>Для программы</a></font>"
                    font: parent.font
                    color: parent.enabled ? parent.Material.primaryTextColor
                                          : parent.Material.hintTextColor
                    //elide: Text.ElideRight
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.Wrap
                }

                property url url: model.url
                highlighted: ListView.isCurrentItem

                onClicked: {
                    listView.forceActiveFocus()
                    listView.currentIndex = model.index
                }

            }

            onCurrentItemChanged: {
                root.recipeSelected(currentItem.url)
            }

            ListModel {
                id: recipeModel

                ListElement {
                    name: "Verben"
                    url: "C:/Qt/Qt5.8.0/Examples/Qt-5.8/webengine/build-recipebrowser-Desktop_Qt_5_8_0_MSVC2015_32bit-Release/123.htm"
                    type: "A1"
                }

                ListElement {
                    name: "Independent work"
                    url: "C:/Users/Bahman/Desktop/1.htm"
                    type: "A1"
                }

                ListElement {
                    name: "Pizza Diavola"
                    url: "qrc:///pages/pizza.html"
                    type: "A2"
                }
                ListElement {
                    name: "Steak"
                    url: "qrc:///pages/steak.html"
                    type: "A2"
                }
                ListElement {
                    name: "Burger"
                    url: "qrc:///pages/burger.html"
                    type: "B1"
                }
                ListElement {
                    name: "Soup"
                    url: "qrc:///pages/soup.html"
                    type: "B1"
                }
                ListElement {
                    name: "Pasta"
                    url: "qrc:///pages/pasta.html"
                    type: "B2"
                }
                ListElement {
                    name: "Grilled Skewers"
                    url: "qrc:///pages/skewers.html"
                    type: "C"
                }
                ListElement {
                    name: "Cupcakes"
                    url: "qrc:///pages/cupcakes.html"
                    type: "KOMPAKT"
                }
            }

            section.property: "type"
            section.criteria: ViewSection.FullString
            section.delegate: sectionHeading
            section.labelPositioning: listView.section.labelPositioning |= ViewSection.CurrentLabelAtStart

            ToolTip {
                id: help
                implicitWidth: root.width - padding * 3
                y: root.y + root.height
                delay: 1000
                timeout: 5000
                text: qsTr("Use keyboard, mouse, or touch controls to navigate through the themes.")

                contentItem: Text {
                    text: help.text
                    font: help.font
                    color: help.Material.primaryTextColor
                    wrapMode: Text.Wrap
                }
            }
        }
    }


    function showHelp() {
        help.open()
    }
}

