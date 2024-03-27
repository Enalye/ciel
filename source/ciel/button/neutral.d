/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.neutral;

import etabli;
import ciel.window;
import ciel.button.button;

final class NeutralButton : TextButton!RoundedRectangle {
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

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);

        addEventListener("enable", &_onEnable);
        addEventListener("disable", &_onDisable);
    }

    private void _onEnable() {
        _background.alpha = Ciel.getActiveOpacity();
        _background.color = Ciel.getNeutral();
        setTextColor(Ciel.getOnNeutral());

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onDisable() {
        _background.alpha = Ciel.getInactiveOpacity();
        _background.color = Ciel.getNeutral();
        setTextColor(Ciel.getNeutral());

        removeEventListener("mouseenter", &_onMouseEnter);
        removeEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onMouseEnter() {
        Color rgb = Ciel.getNeutral();
        HSLColor hsl = HSLColor.fromColor(rgb);
        hsl.l = hsl.l * .8f;
        _background.color = hsl.toColor();
    }

    private void _onMouseLeave() {
        _background.color = Ciel.getNeutral();
    }
}
