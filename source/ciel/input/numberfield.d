/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.input.numberfield;

import std.algorithm.comparison : clamp;
import std.array : replace;
import std.conv : to;
import etabli;
import ciel.button;
import ciel.window;
import ciel.input.textfield;

final class ControlButton : TextButton!RoundedRectangle {
    private {
        RoundedRectangle _background;
    }

    this(string text_) {
        super(text_);

        setFxColor(Ciel.getNeutral());
        setTextColor(Ciel.getAccent());
        setSize(Vec2f(32f, 32f));

        _background = RoundedRectangle.fill(getSize(), Ciel.getCorner());
        _background.color = Ciel.getNeutral();
        _background.anchor = Vec2f.zero;
        _background.alpha = .5f;
        _background.isEnabled = false;
        addImage(_background);

        addEventListener("mouseenter", { _background.isEnabled = true; });
        addEventListener("mouseleave", { _background.isEnabled = false; });
    }
}

final class NumberField : UIElement {
    private {
        TextField _textField;
        ControlButton _decrementBtn, _incrementBtn;
        float _value = 0f;
        float _step = 1f;
        float _minValue = float.nan;
        float _maxValue = float.nan;
    }

    @property {
        float value() const {
            return _value;
        }

        float value(float value_) {
            _value = clamp(value_, _minValue, _maxValue);
            _textField.text = to!string(_value);
            return _value;
        }
    }

    this() {
        setSize(Vec2f(150f, 32f));

        _textField = new TextField();
        _textField.text = "0";
        _textField.setAllowedCharacters("0123456789+-.,");
        _textField.setSize(getSize());
        _textField.setInnerMargin(4f, 70f);
        addUI(_textField);

        HBox box = new HBox;
        box.setAlign(UIAlignX.right, UIAlignY.center);
        box.setChildAlign(UIAlignY.center);
        //box.setPosition(Vec2f(2f, 0f));
        //box.setSpacing(2f);
        addUI(box);

        _decrementBtn = new ControlButton("-");
        box.addUI(_decrementBtn);

        _incrementBtn = new ControlButton("+");
        box.addUI(_incrementBtn);

        _incrementBtn.addEventListener("click", { value(_value + _step); });
        _decrementBtn.addEventListener("click", { value(_value - _step); });
        _textField.addEventListener("input", &_onInput);
    }

    void setRange(float minValue, float maxValue) {
        _minValue = minValue;
        _maxValue = maxValue;
        value(_value);
    }

    private void _onInput() {
        try {
            string text = _textField.text;
            text = text.replace(',', '.');
            _value = clamp(to!float(text), _minValue, _maxValue);
        }
        catch (Exception e) {
            value(0f);
        }
    }
}

final class IntegerField : UIElement {
    private {
        TextField _textField;
        ControlButton _decrementBtn, _incrementBtn;
        int _value = 0;
        int _step = 1;
        int _minValue = int.min;
        int _maxValue = int.max;
    }

    @property {
        int value() const {
            return _value;
        }

        int value(int value_) {
            _value = clamp(value_, _minValue, _maxValue);
            _textField.text = to!string(_value);
            return _value;
        }
    }

    this() {
        setSize(Vec2f(150f, 32f));

        _textField = new TextField();
        _textField.text = "0";
        _textField.setAllowedCharacters("0123456789+-");
        _textField.setSize(getSize());
        _textField.setInnerMargin(4f, 70f);
        addUI(_textField);

        HBox box = new HBox;
        box.setAlign(UIAlignX.right, UIAlignY.center);
        box.setChildAlign(UIAlignY.center);
        addUI(box);

        _decrementBtn = new ControlButton("-");
        box.addUI(_decrementBtn);

        _incrementBtn = new ControlButton("+");
        box.addUI(_incrementBtn);

        _incrementBtn.addEventListener("click", { value(_value + _step); });
        _decrementBtn.addEventListener("click", { value(_value - _step); });
        _textField.addEventListener("input", &_onInput);
    }

    void setRange(int minValue, int maxValue) {
        _minValue = minValue;
        _maxValue = maxValue;
        value(_value);
    }

    private void _onInput() {
        try {
            string text = _textField.text;
            _value = clamp(to!int(text), _minValue, _maxValue);
        }
        catch (Exception e) {
            value(0);
        }
    }
}
