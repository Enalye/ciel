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
        _background.isVisible = false;
        addImage(_background);

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);

        addEventListener("enable", &_onEnable);
        addEventListener("disable", &_onDisable);
    }

    private void _onEnable() {
        setTextColor(Ciel.getAccent());

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onDisable() {
        _background.isVisible = false;
        setTextColor(Ciel.getNeutral());

        removeEventListener("mouseenter", &_onMouseEnter);
        removeEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onMouseEnter() {
        _background.isVisible = true;
    }

    private void _onMouseLeave() {
        _background.isVisible = false;
    }
}
