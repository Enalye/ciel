/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.checkbox;

import etabli;
import ciel.window;
import ciel.button.button;

final class Checkbox : Button!RoundedRectangle {
    private {
        RoundedRectangle _background;
        Rectangle _tick1, _tick2;
        bool _value;
    }

    @property {
        bool value() const {
            return _value;
        }

        bool value(bool value_) {
            _updateValue(value_);
            return _value;
        }
    }

    this(bool isChecked = false) {
        _value = isChecked;
        setSize(Vec2f(24f, 24f));

        _background = RoundedRectangle.outline(getSize(), Ciel.getCorner(), 2f);
        _background.anchor = Vec2f.zero;
        _background.color = _value ? Ciel.getAccent() : Ciel.getNeutral();
        _background.filled = _value;
        addImage(_background);

        _tick1 = Rectangle.fill(Vec2f(7f, 2f));
        _tick1.position = Vec2f(11f, 17f);
        _tick1.color = Ciel.getOnAccent();
        _tick1.angle = 45f;
        _tick1.anchor = Vec2f(1f, 0.5f);
        _tick1.pivot = Vec2f(1f, 0.5f);
        _tick1.isVisible = _value;
        addImage(_tick1);

        _tick2 = Rectangle.fill(Vec2f(11f, 2f));
        _tick2.position = Vec2f(11f, 15f);
        _tick2.color = Ciel.getOnAccent();
        _tick2.angle = -45f;
        _tick2.anchor = Vec2f(0f, 0.5f);
        _tick2.pivot = Vec2f(0f, 0.5f);
        _tick2.isVisible = _value;
        addImage(_tick2);

        setFxColor(_value ? Ciel.getAccent() : Ciel.getNeutral());

        addEventListener("click", &_onClick);

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);

        addEventListener("enable", &_onEnable);
        addEventListener("disable", &_onDisable);
    }

    private void _onEnable() {
        _background.alpha = Ciel.getActiveOpacity();
        _tick1.alpha = Ciel.getActiveOpacity();
        _tick2.alpha = Ciel.getActiveOpacity();

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onDisable() {
        _background.alpha = Ciel.getInactiveOpacity();
        _tick1.alpha = Ciel.getInactiveOpacity();
        _tick2.alpha = Ciel.getInactiveOpacity();

        removeEventListener("mouseenter", &_onMouseEnter);
        removeEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onMouseEnter() {
        Color rgb = _value ? Ciel.getAccent() : Ciel.getNeutral();
        HSLColor hsl = HSLColor.fromColor(rgb);
        hsl.l = hsl.l * .8f;
        _background.color = hsl.toColor();
    }

    private void _onMouseLeave() {
        _background.color = _value ? Ciel.getAccent() : Ciel.getNeutral();
    }

    private void _onClick() {
        _updateValue(!_value);
    }

    private void _updateValue(bool value_) {
        if (_value == value_)
            return;

        _value = value_;
        setFxColor(_value ? Ciel.getAccent() : Ciel.getNeutral());

        _tick1.isVisible = _value;
        _tick2.isVisible = _value;
        _background.filled = _value;

        if (isHovered) {
            _onMouseEnter();
        }
        else {
            _onMouseLeave();
        }
    }
}
