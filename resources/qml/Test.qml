import QtQuick 2.4

Rectangle {
    id: container
    width: 300
    height: 360

    ListModel {
        id: animalsModel
        ListElement { name: "Ant"; size: "Tiny" }
        ListElement { name: "Flea"; size: "Tiny" }
        ListElement { name: "Parrot"; size: "Small" }
        ListElement { name: "Guinea pig"; size: "Small" }
        ListElement { name: "Rat"; size: "Small" }
        ListElement { name: "Butterfly"; size: "Small" }
        ListElement { name: "Dog"; size: "Medium" }
        ListElement { name: "Cat"; size: "Medium" }
        ListElement { name: "Pony"; size: "Medium" }
        ListElement { name: "Koala"; size: "Medium" }
        ListElement { name: "Horse"; size: "Large" }
        ListElement { name: "Tiger"; size: "Large" }
        ListElement { name: "Giraffe"; size: "Large" }
        ListElement { name: "Elephant"; size: "Huge" }
        ListElement { name: "Whale"; size: "Huge" }
    }

    // The delegate for each section header
    Component {
        id: sectionHeading
        Rectangle {
            id: sectionHeadingRectangle
            width: container.width
            height: childrenRect.height
            color: "lightsteelblue"

            Text {
                text: section
                font.bold: true
                font.pixelSize: 20;
            }
            MouseArea {
                anchors.fill: parent
                onClicked: view.sectionClicked(section)
            }
        }
    }

    Component {
        id: section
        Rectangle {
            id: rect
            width: container.width
            height: shown ? mainText.height : 0
            visible: shown
            property bool shown: true

            Text { id: mainText; text: name; font.pixelSize: 18 }
            Connections {
                target: rect.ListView.view
                onSectionClicked: if (rect.ListView.section === name) shown = !shown;
            }
        }
    }

    ListView {
        id: view
        anchors.fill: parent
        // width: parent.width
        signal sectionClicked(string name)
        model: animalsModel
        delegate: section
        section.property: "size"
        section.criteria: ViewSection.FullString
        section.delegate: sectionHeading
    }
}
