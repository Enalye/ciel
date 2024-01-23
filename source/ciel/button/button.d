/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.button;

import etabli;
import ciel.window;
import ciel.button.fx;

abstract class Button : UIElement {
    private {
        Vec2f _padding = Vec2f(24f, 8f);
        ButtonFx _fx;
        Label _text;
    }

    this(string text_) {
        _text = new Label(text_, Ciel.theme.getFont("button"));
        _text.color = Ciel.theme.getColor("primary");
        addElement(_text);

        setSize(_text.getSize() + _padding);

        _fx = new ButtonFx(this);

        addEventListener("enable", { alpha = 1f; });
        addEventListener("disable", { alpha = 0.12f; });
        addEventListener("press", { _fx.onClick(getMousePosition()); });
        addEventListener("unpress", { _fx.onUnclick(); });
        addEventListener("mousemove", { _fx.onUpdate(getMousePosition()); });
        addEventListener("update", { _fx.update(); });
        addEventListener("draw", { _fx.draw(); });
    }

    final Vec2f getPadding() const {
        return _padding;
    }

    final void setPadding(Vec2f padding) {
        _padding = padding;
        setSize(_text.getSize() + _padding);
    }

    void setText(string text_) {
        _text.text = text_;
        setSize(_text.getSize() + _padding);
    }

    void setButtonColors(Color fxColor, Color textColor) {
        _fx.setColor(fxColor);
        _text.color = textColor;
    }
}
