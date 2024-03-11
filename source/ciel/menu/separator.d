/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.menu.separator;

import etabli;
import ciel.window;
import ciel.menu.bar;
import ciel.button;

final class MenuSeparator : UIElement {
    private {
        Rectangle _line;
    }

    this() {
        _line = new Rectangle(Vec2f(getWidth(), 2f), true, 2f);
        _line.color = Ciel.getNeutral();
        _line.anchor = Vec2f(0f, 0.5f);
        _line.alpha = 1f;
        addImage(_line);

        addEventListener("size", { _line.size = Vec2f(getWidth(), 2f); });
    }
}
