/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.panel.modal;

import etabli;

import ciel.window;

class Modal : UIElement {
    private {
        RoundedRectangle _background, _outline;
    }

    this() {
        movable = true;

        _background = RoundedRectangle.fill(getSize(), Ciel.getCorner());
        _background.anchor = Vec2f.zero;
        _background.color = Ciel.getSurface();
        addImage(_background);

        _outline = RoundedRectangle.outline(getSize(), Ciel.getCorner(), 1f);
        _outline.anchor = Vec2f.zero;
        _outline.color = Ciel.getNeutral();
        addImage(_outline);

        addEventListener("size", &_onSizeChange);
    }

    private void _onSizeChange() {
        _background.size = getSize();
        _outline.size = getSize();
    }
}
