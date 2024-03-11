/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.panel.surface;

import etabli;

import ciel.window;

final class Surface : UIElement {
    private {
        Rectangle _background;
    }

    this() {
        _background = new Rectangle(getSize(), true, 1f);
        _background.color = Ciel.getSurface();
        _background.anchor = Vec2f.zero;
        addImage(_background);

        addEventListener("size", &_onSizeChange);
    }

    private void _onSizeChange() {
        _background.size = getSize();
    }
}
