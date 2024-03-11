/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.primary;

import etabli;
import ciel.window;
import ciel.button.button;

final class PrimaryButton : Button {
    private {
        RoundedRectangle _background;
    }

    this(string text_) {
        super(text_);

        setFxColor(Ciel.getAccent());
        setTextColor(Ciel.getOnAccent());

        _background = new RoundedRectangle(getSize(), 8f, true, 0f);
        _background.color = Ciel.getAccent();
        _background.anchor = Vec2f.zero;
        addImage(_background);

        addEventListener("mouseenter", {
            Color rgb = Ciel.getAccent();
            HSLColor hsl = HSLColor.fromColor(rgb);
            hsl.l = hsl.l * .8f;
            _background.color = hsl.toColor();
        });
        addEventListener("mouseleave", {
            _background.color = Ciel.getAccent();
        });
    }
}
