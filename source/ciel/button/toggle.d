/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.toggle;

import std.algorithm.comparison;
import etabli;
import ciel.window;
import ciel.button.button;

final class ToggleButton : Button!Capsule {
    private {
        Capsule _background, _selection;
        Label _inactiveLabel, _activeLabel;
        bool _value;
        Timer _clickTimer;
        float _startPosition = 0f, _endPosition = 0f;
        float _selectionWidth = 0f;
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

    this(string inactiveText, string activeText, bool isChecked = false) {
        _value = isChecked;

        _inactiveLabel = new Label(inactiveText, Ciel.getFont());
        _inactiveLabel.setAlign(UIAlignX.left, UIAlignY.center);
        _inactiveLabel.color = _value ? Ciel.getOnAccent() : Ciel.getNeutral();
        addUI(_inactiveLabel);

        _activeLabel = new Label(activeText, Ciel.getFont());
        _activeLabel.setAlign(UIAlignX.right, UIAlignY.center);
        _activeLabel.color = _value ? Ciel.getAccent() : Ciel.getOnAccent();
        addUI(_activeLabel);

        _selectionWidth = max(_inactiveLabel.getWidth(), _activeLabel.getWidth()) + 6f;
        setSize(Vec2f(_selectionWidth * 2f + 12f, Ciel.getFont().size + 6f));

        _inactiveLabel.setPosition(Vec2f(3f + (_selectionWidth - _inactiveLabel.getWidth()) / 2f,
                0f));
        _activeLabel.setPosition(Vec2f(3f + (_selectionWidth - _activeLabel.getWidth()) / 2f, 0f));

        _background = Capsule.fill(getSize());
        _background.color = _value ? Ciel.getAccent() : Ciel.getNeutral();
        _background.anchor = Vec2f.zero;
        addImage(_background);

        _selection = Capsule.fill(Vec2f(_selectionWidth, Ciel.getFont().size));
        _selection.color = Ciel.getOnNeutral();
        _selection.anchor = Vec2f.half;
        _selection.position = Vec2f(_value ?
                getWidth() - (_selectionWidth / 2f + 3f) : _selectionWidth / 2f + 3f,
                getHeight() / 2f);
        addImage(_selection);

        setFxColor(_value ? Ciel.getAccent() : Ciel.getNeutral());

        addEventListener("click", &_onClick);
        addEventListener("update", &_onUpdate);

        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);
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
        _clickTimer.start(60);

        _startPosition = _selection.position.x;
        _endPosition = _value ? getWidth() - (_selectionWidth / 2f + 3f) : _selectionWidth / 2f + 3f;

        _activeLabel.color = _value ? Ciel.getAccent() : Ciel.getOnAccent();
        _inactiveLabel.color = _value ? Ciel.getOnAccent() : Ciel.getNeutral();
        setFxColor(_value ? Ciel.getAccent() : Ciel.getNeutral());

        if (isHovered) {
            _onMouseEnter();
        }
        else {
            _onMouseLeave();
        }
    }

    private void _onUpdate() {
        if (_clickTimer.isRunning) {
            _clickTimer.update();
            _selection.size = Vec2f(lerp(_selectionWidth / 4f, _selectionWidth,
                    easeOutBounce(_clickTimer.value01())), _selection.size.y);

            _selection.position.x = lerp(_startPosition, _endPosition,
                easeOutElastic(_clickTimer.value01()));
        }
    }
}
