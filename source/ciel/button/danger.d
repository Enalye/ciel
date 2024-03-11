/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.danger;

import etabli;
import ciel.window;
import ciel.button.button;

final class DangerButton : Button {
    private {
        RoundedRectangle _background;
    }

    this(string text_) {
        super(text_);

        setFxColor(Ciel.getDanger());
        setTextColor(Ciel.getOnDanger());

        _background = new RoundedRectangle(getSize(), 8f, true, 0f);
        _background.color = Ciel.getDanger();
        _background.anchor = Vec2f.zero;
        addImage(_background);

        addEventListener("mouseenter", {
            Color rgb = Ciel.getDanger();
            HSLColor hsl = HSLColor.fromColor(rgb);
            hsl.l = hsl.l * .8f;
            _background.color = hsl.toColor();
        });
        addEventListener("mouseleave", {
            _background.color = Ciel.getDanger();
        });
    }
}
