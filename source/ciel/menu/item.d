/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.menu.item;

import etabli;
import ciel.window;
import ciel.menu.bar;
import ciel.button;

final class MenuItem : Button {
    private {
        RoundedRectangle _background;
        Label _label;
        MenuBar _bar;
        uint _id;
    }

    this(MenuBar bar, uint id, string text) {
        super(text);
        _bar = bar;
        _id = id;

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
        addEventListener("click", { _bar.toggleMenu(_id); });
        addEventListener("size", { _background.size = getSize(); });
    }
}
