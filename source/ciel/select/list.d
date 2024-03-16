/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.select.list;

import etabli;
import ciel.window;
import ciel.select.button;
import ciel.select.item;

package final class SelectList : UIElement {
    private {
        RoundedRectangle _background, _outline;
        string _name;
        uint _id;
        SelectButton _button;
        SelectItem[] _items;
    }

    this(SelectButton button) {
        _button = button;
        setAlign(UIAlignX.left, UIAlignY.top);

        _background = RoundedRectangle.fill(getSize(), Ciel.getCorner());
        _background.color = Ciel.getForeground();
        _background.anchor = Vec2f.zero;
        addImage(_background);

        _outline = RoundedRectangle.outline(getSize(), Ciel.getCorner(), 1f);
        _outline.color = Ciel.getNeutral();
        _outline.anchor = Vec2f.zero;
        addImage(_outline);

        addEventListener("size", &_onSizeChange);
        addEventListener("clickoutside", { _button.removeMenu(); });

        State hiddenState = new State("hidden");
        hiddenState.scale = Vec2f(1f, 0.5f);
        hiddenState.time = 5;
        hiddenState.spline = Spline.sineInOut;
        addState(hiddenState);

        State visibleState = new State("visible");
        visibleState.time = 5;
        visibleState.spline = Spline.sineInOut;
        addState(visibleState);

        setState("hidden");
        runState("visible");
    }

    private void _onSizeChange() {
        _background.size = getSize();
        _outline.size = getSize();
    }

    private void _updateSize() {
        Vec2f padding = Vec2f(32f, 16f);
        Vec2f margin = Vec2f(4f, 4f);
        float spacing = 2f;

        Vec2f newSize = Vec2f(padding.x, margin.y);
        float itemWidth = padding.x;

        foreach (SelectItem item; _items) {
            newSize.x = max(newSize.x, item.getWidth() + margin.x * 2f);
            itemWidth = max(itemWidth, item.getWidth());
        }

        foreach (SelectItem item; _items) {
            item.setSize(Vec2f(itemWidth, item.getHeight()));
        }

        foreach (UIElement child; getChildren()) {
            child.setAlign(UIAlignX.left, UIAlignY.top);
            child.setPosition(Vec2f(child.getPosition().x, newSize.y));
            newSize.y += child.getHeight() + spacing;
        }
        newSize.y = max(padding.y, newSize.y + margin.y);

        setSize(newSize);
    }

    package void startRemove() {
        runState("hidden");
        removeEventListener("state", &_onRemove);
        addEventListener("state", &_onRemove);
    }

    private void _onRemove() {
        removeEventListener("state", &_onRemove);
        if (getState() == "hidden") {
            remove();
        }
    }

    package SelectItem add(string itemName) {
        SelectItem item = new SelectItem(_button, itemName);
        item.setPosition(Vec2f(4f, 0f));
        _items ~= item;
        addUI(item);
        _updateSize();
        return item;
    }
}
