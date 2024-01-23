/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.secondary;

import etabli;
import ciel.window;
import ciel.button.button;

final class SecondaryButton : Button {
    private {
        RoundedRectangle _background;
    }

    this(string text_) {
        super(text_);

        setButtonColors(Ciel.theme.getColor("secondary"), Ciel.theme.getColor("onSecondary"));

        _background = new RoundedRectangle(getSize(), 8f, true, 0f);
        _background.color = Ciel.theme.getColor("secondary");
        _background.anchor = Vec2f.zero;
        addImage(_background);

        addEventListener("mouseenter", {
            Color rgb = Ciel.theme.getColor("secondary");
            HSLColor hsl = HSLColor.fromColor(rgb);
            hsl.l = hsl.l * .8f;
            _background.color = hsl.toColor();
        });
        addEventListener("mouseleave", {
            _background.color = Ciel.theme.getColor("secondary");
        });
    }
}
