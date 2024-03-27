/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.radio;

import std.exception : enforce;
import etabli;
import ciel.window;
import ciel.button.button;

final class RadioGroup {
    private {
        RadioButton[] _buttons;
    }

    private bool add(RadioButton button, bool isChecked) {
        if (isChecked) {
            check(null);
        }

        _buttons ~= button;
        // Le premier élément est coché par défaut
        return (_buttons.length == 1) || isChecked;
    }

    private void check(RadioButton button_) {
        foreach (RadioButton button; _buttons) {
            button._updateValue(button == button_);
        }
    }

    private void enable(bool isEnabled) {
        foreach (RadioButton button; _buttons) {
            button.isEnabled = isEnabled;
            if (isEnabled) {
                button._onEnable();
            }
            else {
                button._onDisable();
            }
        }
    }
}

final class RadioButton : Button!Circle {
    private {
        Circle _outline, _check;
        RadioGroup _group;
        bool _value;
    }

    @property {
        bool value() const {
            return _value;
        }
    }

    this(RadioGroup group, bool isChecked = false) {
        enforce(group, "groupe non-spécifié");
        _group = group;
        _value = _group.add(this, isChecked);
        setSize(Vec2f(24f, 24f));

        _outline = Circle.outline(24f, 2f);
        _outline.position = getCenter();
        _outline.anchor = Vec2f.half;
        _outline.color = _value ? Ciel.getAccent() : Ciel.getNeutral();
        addImage(_outline);

        _check = Circle.fill(14f);
        _check.position = getCenter();
        _check.anchor = Vec2f.half;
        _check.color = Ciel.getAccent();
        _check.isVisible = _value;
        addImage(_check);

        setFxColor(_value ? Ciel.getAccent() : Ciel.getNeutral());

        addEventListener("click", &_onClick);

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);

        addEventListener("enable", { _group.enable(true); });
        addEventListener("disable", { _group.enable(false); });
    }

    void check() {
        _group.check(this);
    }

    private void _onEnable() {
        _outline.alpha = Ciel.getActiveOpacity();
        _check.alpha = Ciel.getActiveOpacity();

        if (isHovered) {
            _onMouseEnter();
        }
        else {
            _onMouseLeave();
        }

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onDisable() {
        _outline.alpha = Ciel.getInactiveOpacity();
        _check.alpha = Ciel.getInactiveOpacity();

        removeEventListener("mouseenter", &_onMouseEnter);
        removeEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onMouseEnter() {
        Color rgb = _value ? Ciel.getAccent() : Ciel.getNeutral();
        HSLColor hsl = HSLColor.fromColor(rgb);
        hsl.l = hsl.l * .8f;
        _outline.color = hsl.toColor();
        _check.color = _outline.color;
    }

    private void _onMouseLeave() {
        _outline.color = _value ? Ciel.getAccent() : Ciel.getNeutral();
        _check.color = _outline.color;
    }

    private void _onClick() {
        if (!_value)
            check();
    }

    private void _updateValue(bool value_) {
        if (_value == value_)
            return;

        _value = value_;
        setFxColor(_value ? Ciel.getAccent() : Ciel.getNeutral());

        _check.isVisible = _value;

        if (isHovered) {
            _onMouseEnter();
        }
        else {
            _onMouseLeave();
        }

        dispatchEvent("value", false);
    }
}
