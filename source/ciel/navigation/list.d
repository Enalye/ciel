/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.navigation.list;

import etabli;
import ciel.window;
import ciel.scrollbar;

abstract class List : UIElement {

}

final class VList : UIElement {
    private {
        VScrollbar _scrollbar;
        VContentView _contentView;
        Rectangle _background;
    }

    this() {
        _background = Rectangle.fill(getSize());
        _background.color = Ciel.getBackground();
        _background.anchor = Vec2f.zero;
        addImage(_background);

        _contentView = new VContentView;
        _contentView.setAlign(UIAlignX.left, UIAlignY.top);
        _contentView.setChildAlign(UIAlignX.left);
        addUI(_contentView);

        _scrollbar = new VScrollbar;
        _scrollbar.setAlign(UIAlignX.right, UIAlignY.top);
        addUI(_scrollbar);

        addEventListener("size", &_onSize);
        _contentView.addEventListener("contentSize", &_onUpdateContent);
        _scrollbar.addEventListener("handlePosition", &_onHandlePosition);

        import ciel.button;

        foreach (key; [
                "chocolaté", "pamplemousse", "casserole", "poële", "saucisse",
                "ragondin", "tortue", "ouistiti", "phacochère", "cassoulet",
                "piémontaise", "camembert", "saint-nectaire", "aligot",
                "bernard l’hermitte", "dromadaire", "castor", "croustillant",
                "gargouille", "oblique", "palindrôme", "sourire", "herbe",
                "prairie"
            ]) {
            auto elt = new SecondaryButton(key);
            _contentView.addUI(elt);
        }
    }

    private void _onSize() {
        _background.size = getSize();
        _scrollbar.setHeight(getHeight());
        _contentView.setSize(getSize() - Vec2f(_scrollbar.getWidth(), 0f));
    }

    private void _onUpdateContent() {
        _scrollbar.setContentSize(_contentView.getContentHeight());
    }

    private void _onHandlePosition() {
        _contentView.setContentPosition(_scrollbar.getContentPosition());
    }
}
