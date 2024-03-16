/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.select.item;

import etabli;
import ciel.window;
import ciel.button;
import ciel.window;
import ciel.select.button;

final class SelectItem : TextButton!RoundedRectangle {
    private {
        RoundedRectangle _background;
        Label _label;
        SelectButton _button;
    }

    this(SelectButton button, string text) {
        super(text);
        _button = button;

        setAlign(UIAlignX.left, UIAlignY.top);
        setFxColor(Ciel.getNeutral());
        setTextColor(Ciel.getOnNeutral());
        setPadding(Vec2f(48f, 8f));
        setTextAlign(UIAlignX.left, 16f);

        _background = RoundedRectangle.fill(getSize(), Ciel.getCorner());
        _background.color = Ciel.getAccent();
        _background.anchor = Vec2f.zero;
        _background.alpha = 1f;
        _background.isEnabled = false;
        addImage(_background);

        addEventListener("mouseenter", { _background.isEnabled = true; });
        addEventListener("mouseleave", { _background.isEnabled = false; });
        addEventListener("click", { _button.value = text; _button.removeMenu(); });
        addEventListener("size", { _background.size = getSize(); });
    }
}
