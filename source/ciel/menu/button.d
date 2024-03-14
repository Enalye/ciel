/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.menu.button;

import etabli;
import ciel.window;
import ciel.menu.bar;
import ciel.button;

final class MenuButton : TextButton!RoundedRectangle {
    private {
        RoundedRectangle _background;
        MenuBar _bar;
        Label _label;
        uint _id;
    }

    this(MenuBar bar, uint id, string text) {
        super(text);
        _bar = bar;
        _id = id;

        setFxColor(Ciel.getNeutral());
        setTextColor(Ciel.getOnNeutral());

        _background = RoundedRectangle.fill(getSize(), Ciel.getCorner());
        _background.color = Ciel.getNeutral();
        _background.anchor = Vec2f.zero;
        _background.alpha = .5f;
        _background.isEnabled = false;
        addImage(_background);

        addEventListener("mouseenter", {
            _background.isEnabled = true;
            _bar.switchMenu(_id);
        });
        addEventListener("mouseleave", {
            _background.isEnabled = false;
            _bar.leaveMenu(_id);
        });
        addEventListener("click", { _bar.toggleMenu(_id); });
    }
}
