/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.outlined;

import etabli;
import ciel.window;
import ciel.button.button;

final class OutlinedButton : Button {
    private {
        RoundedRectangle _background;
    }

    this(string text_) {
        super(text_);

        setFxColor(Ciel.getAccent());
        setTextColor(Ciel.getAccent());

        _background = new RoundedRectangle(getSize(), 8f, false, 2f);
        _background.color = Ciel.getAccent();
        _background.anchor = Vec2f.zero;
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
