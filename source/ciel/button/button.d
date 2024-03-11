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
        Label _label;
    }

    this(string text_) {
        _label = new Label(text_, Ciel.getFont());
        _label.color = Ciel.getOnNeutral();
        addUI(_label);

        setSize(_label.getSize() + _padding);

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
        setSize(_label.getSize() + _padding);
    }

    void setText(string text_) {
        _label.text = text_;
        setSize(_label.getSize() + _padding);
    }

    void setTextAlign(UIAlignX alignX, float offset = 0f) {
        _label.setAlign(alignX, UIAlignY.center);
        _label.setPosition(Vec2f(offset, 0f));
    }

    void setTextColor(Color color) {
        _label.color = color;
    }

    void setFxColor(Color color) {
        _fx.setColor(color);
    }
}
