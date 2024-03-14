/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.secondary;

import etabli;
import ciel.window;
import ciel.button.button;

final class SecondaryButton : TextButton!RoundedRectangle {
    private {
        RoundedRectangle _background;
    }

    this(string text_) {
        super(text_);

        setFxColor(Ciel.getNeutral());
        setTextColor(Ciel.getOnNeutral());

        _background = RoundedRectangle.fill(getSize(), Ciel.getCorner());
        _background.color = Ciel.getNeutral();
        _background.anchor = Vec2f.zero;
        addImage(_background);

        addEventListener("mouseenter", {
            Color rgb = Ciel.getNeutral();
            HSLColor hsl = HSLColor.fromColor(rgb);
            hsl.l = hsl.l * .8f;
            _background.color = hsl.toColor();
        });
        addEventListener("mouseleave", { _background.color = Ciel.getNeutral(); });
    }
}
