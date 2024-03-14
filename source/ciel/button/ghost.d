/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.ghost;

import etabli;
import ciel.window;
import ciel.button.button;

final class GhostButton : TextButton!RoundedRectangle {
    private {
        RoundedRectangle _background;
    }

    this(string text_) {
        super(text_);

        setFxColor(Ciel.getNeutral());
        setTextColor(Ciel.getAccent());

        _background = RoundedRectangle.fill(getSize(), Ciel.getCorner());
        _background.color = Ciel.getNeutral();
        _background.anchor = Vec2f.zero;
        _background.alpha = .5f;
        _background.isEnabled = false;
        addImage(_background);

        addEventListener("mouseenter", { _background.isEnabled = true; });
        addEventListener("mouseleave", { _background.isEnabled = false; });
    }
}
