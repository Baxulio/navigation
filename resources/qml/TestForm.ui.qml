import QtQuick 2.4
import QtQuick.Controls 2.1

Item {
    width: 400
    height: 400

    ToolSeparator {
        id: toolSeparator

        TextField {
            id: textField
            x: 0
            y: 148
            text: qsTr("Text Field")
        }

        TextArea {
            id: textArea
            x: 325
            y: 198
            text: qsTr("Text Area")
        }
    }
}
