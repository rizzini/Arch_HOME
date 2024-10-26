/*
 * Copyright 2013  Heena Mahour <heena393@gmail.com>
 * Copyright 2013 Sebastian Kügler <sebas@kde.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.6

import QtQuick.Controls 2.0

import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kquickcontrolsaddons 2.0
import org.kde.plasma.plasma5support 2.0 as P5Support
import org.kde.kirigami as Kirigami

PlasmoidItem  {
    id: root


    readonly property bool inPanel: (Plasmoid.location === PlasmaCore.Types.TopEdge
                                     || Plasmoid.location === PlasmaCore.Types.RightEdge
                                     || Plasmoid.location === PlasmaCore.Types.BottomEdge
                                     || Plasmoid.location === PlasmaCore.Types.LeftEdge)

    readonly property bool isVertical: (Plasmoid.location === PlasmaCore.Types.RightEdge
                                        || Plasmoid.location === PlasmaCore.Types.LeftEdge)
    //readonly property bool isVertical: Plasmoid.formFactor === PlasmaCore.Types.Vertical


    switchWidth: Kirigami.Units.gridUnit * 10
    switchHeight: Kirigami.Units.gridUnit * 10

    function colorWithAlpha(color: color, alpha: real): color {
        return Qt.rgba(color.r, color.g, color.b, alpha)
    }

    readonly property color hoverColor: colorWithAlpha(Kirigami.Theme.highlightColor, 0.6)

    P5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: (sourceName, data) => {
                       disconnectSource(sourceName)
                   }

        function exec(cmd) {
            executable.connectSource(cmd)
        }
    }

    fullRepresentation: compactRepresentation
    preferredRepresentation: compactRepresentation
    compactRepresentation: MouseArea{

        id: area

        Layout.fillHeight: false
        Layout.fillWidth: false
        Layout.minimumWidth: paintArea.width
        Layout.maximumWidth: Layout.minimumWidth
        Layout.minimumHeight: paintArea.height
        Layout.maximumHeight: Layout.minimumHeight

        Rectangle{
            anchors.fill: parent
            color: area.containsMouse ? root.hoverColor : "transparent"
            radius: Kirigami.Units.smallSpacing
        }
        Row {
            id: paintArea

            leftPadding: Plasmoid.configuration.paddingLeft
            rightPadding: Plasmoid.configuration.paddingRight
            topPadding: Plasmoid.configuration.paddingTop

            anchors.centerIn: parent

            Label{
                id: label
                text: Plasmoid.configuration.textLabel
                font.bold:  Plasmoid.configuration.boldText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.italic: Plasmoid.configuration.italicText
                font.pixelSize: Plasmoid.configuration.fixedFont ? Plasmoid.configuration.fontSize : PlasmaCore.Theme.defaultFont.pixelSize
                minimumPixelSize: 1
            }
        }

        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            executeCommand()
        }
    }

    function executeCommand() {
        executable.exec(Plasmoid.configuration.command)
    }
}
