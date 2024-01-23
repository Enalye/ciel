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
        RoundedRectangle _outline, _background;
    }

    this(string text_) {
        super(text_);

        setButtonColors(Ciel.theme.getColor("primary"), Ciel.theme.getColor("primary"));

        _outline = new RoundedRectangle(getSize(), 8f, false, 2f);
        _outline.color = Ciel.theme.getColor("primary");
        _outline.anchor = Vec2f.zero;
        addImage(_outline);

        _background = new RoundedRectangle(getSize(), 8f, true, 2f);
        _background.color = Ciel.theme.getColor("primary");
        _background.anchor = Vec2f.zero;
        _background.alpha = .5f;
        _background.isEnabled = false;
        addImage(_background);

        addEventListener("mouseenter", {
            Color rgb = Ciel.theme.getColor("primary");
            HSLColor hsl = HSLColor.fromColor(rgb);
            hsl.l = hsl.l * .8f;
            _outline.color = hsl.toColor();
            _background.isEnabled = true;
        });
        addEventListener("mouseleave", {
            _outline.color = Ciel.theme.getColor("primary");
            _background.isEnabled = false;
        });
    }
}
