/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.outlined;

import etabli;
import ciel.window;
import ciel.button.button;

final class OutlinedButton : TextButton!RoundedRectangle {
    private {
        RoundedRectangle _background;
    }

    this(string text_) {
        super(text_);

        setFxColor(Ciel.getAccent());
        setTextColor(Ciel.getAccent());

        _background = RoundedRectangle.outline(getSize(), Ciel.getCorner(), 2f);
        _background.color = Ciel.getAccent();
        _background.anchor = Vec2f.zero;
        _background.thickness = 2f;
        addImage(_background);

        addEventListener("mouseenter", {
            setTextColor(Ciel.getOnAccent());
            _background.filled = true;
        });
        addEventListener("mouseleave", {
            setTextColor(Ciel.getAccent());
            _background.filled = false;
        });
    }
}
