/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.panel.container;

import etabli;

import ciel.window;

final class Container : UIElement {
    private {
        Rectangle _background;
    }

    this() {
        _background = new Rectangle(getSize(), true, 1f);
        _background.color = Ciel.theme.getColor("container");
        _background.anchor = Vec2f.zero;
        addImage(_background);

        addEventListener("size", &_onSizeChange);
    }

    private void _onSizeChange() {
        _background.size = getSize();
    }
}