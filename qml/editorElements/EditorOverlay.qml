import Felgo 3.0
import QtQuick 2.0
import "../common"


Item {
  id: editorOverlay

  // make components accessible from the outside
  property alias grid: grid
  property alias sidebar: sidebar

  // holds the currently selected BuildEntityButton
  property var selectedButton

  // this is the gameScene, over which this overlay is put
  // by default this is this item's parent
  property var scene: parent

  // makes accessing the gameScene's container easier
  property var containerComponent: scene.container

  // this switches between true and false, if the user clicks the itemEditorButton
  property bool itemEditorVisible: false

  property bool inEditMode: false
  visible: false

  anchors.fill: scene.gameWindowAnchorItem

  EditorGrid {
    id: grid

    visible: inEditMode

    container: containerComponent
  }

  /**
   * SIDEBAR --------------------------------------
   */
  Sidebar {
    id: sidebar

    visible: inEditMode

    // set all components, that can be accessed in the sidebar
    bgImage: scene.bgImage
    grid: grid
  }

  /**
   * Item editor ----------------------------------
   */
  // item editor for balancing the game


  /**
   * TOP BAR --------------------------------------
   */

  // this button enables switching between edit and test mode
  ImageButton {
    id: testButton

    width: 50
    height: 30

    // place on top, centered
    anchors.horizontalCenter: editorOverlay.horizontalCenter
    anchors.top: editorOverlay.top

    // set image source, depending on if we're in edit mode
    image.source: inEditMode ? "../../assets/ui/play.png" : "../../assets/ui/edit.png"

    // set opacity to 0.5 when in test mode, to be less distracting
    opacity: inEditMode ? 1 : 0.5

    // set game state depending on current game state
    onClicked: {
      if(inEditMode) {
        scene.state = "test"
      }
      else
        scene.state = "edit"
    }
  }

  // this row holds the buttons in the top right corner
  Row {
    id: topbar

    visible: inEditMode

    height: 30

    anchors.right: editorOverlay.right
    anchors.top: editorOverlay.top

    spacing: 4

    // save level button
    ImageButton {
      id: saveButton

      width: 40

      image.source: "../../assets/ui/save.png"

      onClicked: {
        // save level
        saveLevel()

        // show saved text
        savedTextAnimation.restart()
      }

      // this text signals, that the level has been saved
      Text {
        // text and text color
        text: "saved"
        color: "#ffffff"

        // by default this text is opaque/invisible
        opacity: 0

        // anchor to the bottom of the save button
        anchors.top: saveButton.bottom

        // outline the text, to increase it's visibility
        style: Text.Outline
        styleColor: "#009900"

        // this animation shows and slowly fades out the save text
        NumberAnimation on opacity {
          id: savedTextAnimation

          // slowly reduce opacity from 1 to 0
          from: 1
          to: 0

          // duration of the animation, in ms
          duration: 2000
        }
      }
    }

    // back to menu button
    ImageButton {
      id: menuButton

      width: 40

      image.source: "../../assets/ui/home.png"

      // open save dialog when in edit mode
      onClicked: saveLevelDialog.opacity = 1
    }
  }


  /**
   * DIALOGS
   */

  // this is the save dialog that pops up, when the user clicks
  // the backButton in edit mode



  /**
   * JAVASCRIPT FUNCTIONS --------------------------------------
   */
  // handles the clicking of an entity
  function clickEntity(entity) {
    EditorLogic.clickEntity(entity);
  }

  // if entity is removable: remove entity and return the undoObject of this action
  function removeEntity(entity) {
    return EditorLogic.removeEntity(entity);
  }

  // returns the top-left coordinate of the grid the mouse is in
  function getMouseGridPos(mouseX, mouseY) {
    return EditorLogic.getMouseGridPos(mouseX, mouseY);
  }

  // This function checks, if there is a body in the 32x32 area
  // below/right the position parameter. We use this to make sure
  // there isn't already an entity at the position where we want
  // to create a new one.
  // The position parameter is the top-left point of the checked
  // area.
  // Returns true, if there is a body in this area;
  // false else.
  function isBodyIn32Grid(position) {
    return EditorLogic.isBodyIn32Grid(position);
  }

  // place a new object and return it
  function placeEntityAtPosition(mouseX, mouseY) {
    return EditorLogic.placeEntityAtPosition(mouseX, mouseY);
  }

  // converts mouse coordinates to level coordinates
  // return point with level coordinates
  function mouseToLevelCoordinates(mouseX, mouseY) {
    return EditorLogic.mouseToLevelCoordinates(mouseX, mouseY);
  }

  // calculates the grid coordinates of the grid the position (levelX, levelY) is in
  function snapToGrid(levelX, levelY) {
    return EditorLogic.snapToGrid(levelX, levelY);
  }

  // saves the current level
  function saveLevel() {
    EditorLogic.saveLevel();
  }

  function initEditor() {
    EditorLogic.initEditor();
  }

  function resetEditor() {
    EditorLogic.resetEditor();
  }
}
