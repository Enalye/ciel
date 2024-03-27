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

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);

        addEventListener("enable", &_onEnable);
        addEventListener("disable", &_onDisable);
    }

    private void _onEnable() {
        _background.alpha = Ciel.getActiveOpacity();
        _background.color = Ciel.getAccent();
        setTextColor(Ciel.getAccent());

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onDisable() {
        _background.filled = false;
        _background.alpha = Ciel.getInactiveOpacity();
        _background.color = Ciel.getNeutral();
        setTextColor(Ciel.getNeutral());

        removeEventListener("mouseenter", &_onMouseEnter);
        removeEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onMouseEnter() {
        setTextColor(Ciel.getOnAccent());
        _background.filled = true;
    }

    private void _onMouseLeave() {
        setTextColor(Ciel.getAccent());
        _background.filled = false;
    }
}
